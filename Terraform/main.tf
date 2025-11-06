
resource "aws_instance" "ec2" {
  for_each = var.ec2-instances

  ami                  = data.aws_ami.ubuntu
  subnet_id            = aws_subnet.public_subnet[each.value.subnet]
  instance_type        = each.value.type
  iam_instance_profile = aws_iam_instance_profile.iam_instance_profile.name

  root_block_device {
    volume_size = var.ec2_volume_size
    volume_type = var.ec2_volume_type
  }

  tags = {
    Name = "${local.org}-${local.project}-${local.env}-${each.key}"
    Env  = "${local.env}"
  }
}