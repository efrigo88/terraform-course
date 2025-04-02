########################
# Imports
########################
# import {
#   to = aws_iam_openid_connect_provider.terraform_cloud
#   id = "arn:aws:iam::140023373701:oidc-provider/app.terraform.io"
# }
# import {
#   to = aws_iam_role.terraform_cloud_admin
#   id = "terraform-cloud-automation-admin"
# }
# import {
#   to = aws_iam_role_policy_attachment.admin_policy
#   id = "${aws_iam_role.terraform_cloud_admin.name}/${data.aws_iam_policy.admin_policy.arn}"
# }
########################

# For this to work, the following environment variables must be set in Terraform Cloud:
# These can be set as workspace variables or as variable sets if you need to share them across workspaces
#
# TFC_AWS_PROVIDER_AUTH = true
# TFC_AWS_RUN_ROLE_ARN = arn:aws:iam::ACCOUNT_ID:role/terraform-cloud-automation-admin-example

data "tls_certificate" "terraform_cloud" {
  url = "https://${var.tf_cloud_hostname}"
}

resource "aws_iam_openid_connect_provider" "terraform_cloud" {
  url             = data.tls_certificate.terraform_cloud.url
  client_id_list  = [var.tf_cloud_audience]
  thumbprint_list = [data.tls_certificate.terraform_cloud.certificates[0].sha1_fingerprint]
}

data "aws_iam_policy_document" "terraform_cloud_admin_assume_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.terraform_cloud.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${var.tf_cloud_hostname}:aud"
      values   = [var.tf_cloud_audience]
    }

    condition {
      test     = "StringLike"
      variable = "${var.tf_cloud_hostname}:sub"
      values = [
        "organization:my-lab-organization:project:terraform-oidc:workspace:*:run_phase:*"
      ]
    }
  }
}

resource "aws_iam_role" "terraform_cloud_admin" {
  name               = "terraform-cloud-automation-admin"
  assume_role_policy = data.aws_iam_policy_document.terraform_cloud_admin_assume_policy.json
}

data "aws_iam_policy" "admin_policy" {
  name = "AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "admin_policy" {
  role       = aws_iam_role.terraform_cloud_admin.name
  policy_arn = data.aws_iam_policy.admin_policy.arn
}
