resource "aws_subnet" "private_subnet" {
  count = length(data.aws_availability_zones.zones.names) 
  availability_zone = data.aws_availability_zones.zones.names[count.index]
  vpc_id = var.vpcid
  cidr_block = "${local.digit[0]}.${local.digit[1]}.${count.index}.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.subnetname}_private_${count.index}"
    Type = "private"
  }
}

resource "aws_subnet" "public_subnet" {
  count = length(data.aws_availability_zones.zones.names) 
  availability_zone = data.aws_availability_zones.zones.names[count.index]
  vpc_id = var.vpcid
  cidr_block = "${local.digit[0]}.${local.digit[1]}.${10+count.index}.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.subnetname}_public_${count.index}"
    Type = "public"
  }
}
