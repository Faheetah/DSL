```
terraform {
  required_version = ">= 0.13.0"
}

variable "wait_for_write" {}

resource "null_resource" "dependency" {
  triggers = {
    dependency_id = var.wait_for_write
  }
}

resource "aws_instance" "ubuntu" {
  count = var.some_var ? 1 : 0
  ami = data.aws_ami.ubuntu_14_04.image_id
  instance_type = "t2.micro"
  associate_public_ip_address = ( count.index == 1 ? true : false)
  subnet_id = aws_subnet.my_subnet.id

  tags = {
    Name  = format("terraform-0.12-for-demo-%d", count.index)
  }
}

data "local_file" "apple" {
    filename = "${path.root}/apple.txt"
    depends_on = [null_resource.dependency]
}

data "local_file" "banana" {
    filename = "${path.root}/banana.txt"
    depends_on = [null_resource.dependency]
}

data "local_file" "orange" {
    filename = "${path.root}/orange.txt"
    depends_on = [null_resource.dependency]
}

output "fruit" {
  value = [
    data.local_file.apple.content,
    data.local_file.banana.content,
    data.local_file.orange.content,
  ]
}
```
