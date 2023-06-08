resource "aws_instance" "base_ec2" {
  ami                     =  var.ami
  instance_type           =  var.type_instance
  subnet_id = var.private_subnet
  tags = var.tags_ec2
    root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }
  vpc_security_group_ids = [aws_security_group.base_sg.id]
  iam_instance_profile = aws_iam_instance_profile.test_profile.name
  key_name = aws_key_pair.terraform_key_pair.key_name


}


resource "aws_key_pair" "terraform_key_pair" {
  key_name   = "terraform_key_pair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxLBaA9hkN2H2wiCIWNQxnOj4v0Ll7H4hVhfrIRLqKSsllGaA3sZVvWhZJm2PVN7huRB7W3aGMC2KphNz0Y6br5Zc9ZXNfD3RLKN1JMGn6rrZKLAFfLommJ7TIustMlJpp5VKNVzBO6E+++650MybITK6bjx5XBEPIAevQkW/162rMRB167cmjuaGkzC4EZylE/JrtfV9B59vnA3JxiaYSJWqcH+s2P9IadvlDnjEbGx49mfa9n+46g7AlC1TKqYkwgVQI/R2NsxmaBbAjzRURLsDSL68JLs2Gcasb1P9emoNNF0maTuFGq161uylPSZTuXIE3IIjZ1fL7hLVOd+vn terraform"
}


resource "aws_security_group" "base_sg" {
  name        = "sg_ec2_instance"
  description = "Permitir trafico para instancias"
  vpc_id      = var.cidr_vpc_base

  ingress {
    description      = "Definir para que se va a usar esta entrada"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/16"]
  }

   ingress {
    description      = "Definir para que se va a usar esta entrada"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/16"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}




# Get the policy by name
data "aws_iam_policy" "required-policy" {
  name = "AmazonEC2RoleforSSM"
}

data "aws_iam_policy" "required-policy1" {
  name = "AmazonSSMManagedInstanceCore"
}


# Create the role
resource "aws_iam_role" "system-role" {
  name = "data-stream-system-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}


# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "attach-s3" {
  role       = aws_iam_role.system-role.name
  policy_arn = data.aws_iam_policy.required-policy.arn
}

resource "aws_iam_role_policy_attachment" "attach-s3-2" {
  role       = aws_iam_role.system-role.name
  policy_arn = data.aws_iam_policy.required-policy1.arn
}


resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = aws_iam_role.system-role.name
}



