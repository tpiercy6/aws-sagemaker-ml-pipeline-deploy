#
# Variables updated to reflect BreakFree requirements. Note that the region is
# determined by the supported regions in the BreakFree AWS subscription.
#

## Change project_name to your project name
project_name = "breakfree-ml-pipeline" 
region = "us-east-1" 

## Updated instance types for the lowest priced possible (free tier, according
## to https://aws.amazon.com/sagemaker/pricing/)
training_instance_type = "ml.m3.medium"
inference_instance_type = "ml.m3.medium"
volume_size_sagemaker = 5

## Should not be changed with the current folder structure
handler_path  = "../../src/lambda_function"
handler       = "config_lambda.lambda_handler"

