data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda_code.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "send_email_lambda" {
  filename         = "./lambda_function_payload.zip"  
  function_name    = "send_email_lambda"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_code.lambda_handler" 
  runtime          = "python3.10"

  # environment {
  #   variables = {
  #     SES_SENDER_EMAIL    = var.ses_email_reciever
  #     SES_RECIPIENT_EMAIL = var.ses_email_reciever
  #   }
  # }
}


resource "aws_s3_bucket_notification" "tfstate_bucket_notification" {
  bucket = "terraform-iti-cloud-pd44"

  lambda_function {
    lambda_function_arn = aws_lambda_function.send_email_lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.send_email_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::terraform-iti-cloud-pd44"
}



# # resource "null_resource" "trigger_lambda_on_apply" {
# #   provisioner "local-exec" {
# #     command = <<EOT
# #       # Check if terraform apply was successful
# #       if [ "$?" -eq 0 ]; then
# #         aws lambda invoke --function-name ${aws_lambda_function.send_email.function_name} --payload {} /dev/null
# #       fi
# #     EOT
# #   }

# #   triggers = {
# #     always_run = "${timestamp()}"
# #   }
# # }
