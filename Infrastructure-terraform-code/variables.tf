variable "vpc_cidr" {
  type        = string
  description = "description"
}

variable "ses_email_reciever" {
  type = string
  description = "description"
}

variable "common_resource_name" {
  type        = string
  default= "Cloud_PD44"
  description = "description"
}

variable "region" {
  type        = string
  description = "description"
}


variable "machine_details" {
  type        = object({
    type = string,
    public_ip = bool
  })
  description = "description"
}


variable subnets_details {
  type        = list(object({
    name = string,
    cidr = string,
    type = string,
    az = string
  }))
  description = "description"
}

# variable create_key_file {
#   type        = bool
#   description = "description"
# }

