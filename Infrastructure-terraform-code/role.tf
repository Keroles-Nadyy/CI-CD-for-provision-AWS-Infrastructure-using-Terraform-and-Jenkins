resource "aws_iam_role" "lambda_role" {
  name = "lambda-ses-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_ses_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSESFullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}





# resource "aws_s3_bucket_notification" "bucket_notification" {
#   bucket = "terraform-iti-cloud-pd44"

#   lambda_function {
#     lambda_function_arn = aws_lambda_function.send_email_lambda.arn
#     events              = ["s3:ObjectCreated:*"]
#   }
# }

# resource "aws_lambda_permission" "allow_bucket" {
#   statement_id  = "AllowExecutionFromS3Bucket"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.send_email_lambda.function_name
#   principal     = "s3.amazonaws.com"
#   source_arn    = "arn:aws:s3:::terraform-iti-cloud-pd44"
# }