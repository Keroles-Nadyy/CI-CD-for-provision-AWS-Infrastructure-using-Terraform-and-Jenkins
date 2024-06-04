vpc_cidr="10.0.0.0/16"
# machine_type="t2.micro"
region="eu-west-1"
machine_details={
    name="bastion",
    type="t2.micro",
    ami="ami144238737",
    public_ip=true
}

subnets_details=[
    {
        name="public_subnet_I",
        cidr="10.0.1.0/24",
        type="public",
        az = "eu-west-1a"
    },

    {
        name="public_subnet_II",
        cidr="10.0.2.0/24",
        type="public",
        az = "eu-west-1b"
    },

    {
        name="private_subnet_I",
        cidr="10.0.3.0/24",
        type="private",
        az = "eu-west-1a"
    },
    {
        name="private_subnet_II",
        cidr="10.0.4.0/24",
        type="private",
        az = "eu-west-1b"
    }
]

# create_key_file=true