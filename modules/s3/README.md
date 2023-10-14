# deploy static website on s3

## Requirements

* You must have a valid AWS profile/access_key and secret_key in your system.

## Usage
1. add your aws profile with aws iam role 
    ```bash
    aws configure --profile 'your profile name'
    ```
* you must have update profile name in provide.tf

2. Initialize the terraform state
    ```bash
    terraform init
    ```

3. Execute the script
    ```bash
    terraform apply -auto-approve
    ```

4. (optional) Destroy the resources when no longer needed
    ```bash
    terraform destroy -auto-approve
    ```
# static-websiteOn-s3-terrafrom
