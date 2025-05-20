resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = var.azs  # Match EC2's AZ
  size              = 1  # 1 GB volume
  type              = "gp3"
  iops              = 3000
  throughput        = 125

  tags = {
    Name = "${local.name_prefix}-ebs-volume"
  }

}

resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.ebs_volume.id
  instance_id = var.instance_ids  # Attach to the first instance in the list

  lifecycle {
    prevent_destroy = false  # Allow Terraform to destroy this attachment
  }
}