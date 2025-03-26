# Terraform Course

Welcome to my Terraform Course project! This repository contains all the materials and code examples from the Terraform course I am currently taking on Udemy.

## Course Overview

This course covers the fundamentals of Terraform, an open-source infrastructure as code software tool. Throughout the course, I will learn how to:

- Understand the basics of Terraform and its core concepts
- Write and manage Terraform configuration files
- Use Terraform to provision and manage infrastructure
- Implement best practices for Terraform usage

## Repository Structure

- `modules/`: Contains reusable Terraform modules
- `environments/`: Contains environment-specific configurations (e.g., dev, staging, production)
- `scripts/`: Contains helper scripts for managing Terraform state and deployments
- `examples/`: Contains example configurations and use cases

## Getting Started

To get started with the code in this repository, you will need to have the following prerequisites installed:

- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://aws.amazon.com/cli/) (if using AWS as the cloud provider)

Clone the repository and navigate to the desired directory to start working with the Terraform configurations.

```sh
git clone https://github.com/your-username/terraform-course.git
cd terraform-course
```

## Usage

1. Initialize the Terraform configuration:
Make sure you have the AWS CLI correctly installed and configured. 
Additionally, create a `.env` file with your environment variables (if you don't make use of profiles) and run the following command to export them:

```sh
source .env
```

2. Validate the configuration (terraform must be installed correctly):
    ```sh
    terraform init
    ```
    ```sh
    terraform validate
    ```

3. Plan the deployment:

    ```sh
    terraform plan
    ```

4. Apply the configuration to provision the infrastructure:

    ```sh
    terraform apply
    ```

5. Destroy the infrastructure when no longer needed:

    ```sh
    terraform destroy
    ```

## Resources

- [Terraform Documentation](https://www.terraform.io/docs/index.html)
- [Udemy Course](https://www.udemy.com/course-dashboard-redirect/?course_id=5761444)

## Acknowledgements

Special thanks to the instructor and the Udemy platform for providing this comprehensive Terraform course.

Happy Terraforming!