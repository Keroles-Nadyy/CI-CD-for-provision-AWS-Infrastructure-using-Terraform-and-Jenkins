import boto3
import datetime
import os

ses_client = boto3.client('ses')

def lambda_handler(event, context):
    region = event['region']

    current_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # Compose the email message
    subject = "New Terraform Deployment happened"
    body = f"A new deployment has occurred in workspace:, region: {region}, at: {current_time}"
    # sender = os.environ['SES_SENDER_EMAIL']
    # recipient = os.environ['SES_RECIPIENT_EMAIL']
    sender = 'keroles_N@outlook.com'
    recipient = 'keroles_N@outlook.com'

    # Send the email
    response = ses_client.send_email(
        Source=sender,
        Destination={'ToAddresses': [recipient]},
        Message={
            'Subject': {'Data': subject}, 
            'Body': {'Text': {'Data': body}}}
    )

    return {
        'statusCode': 200,
        'body': response
    }
