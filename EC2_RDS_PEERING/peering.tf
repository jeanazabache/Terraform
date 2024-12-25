
resource "aws_vpc_peering_connection" "request" {
  provider    = aws.virginia
  vpc_id      = aws_vpc.vpc_virginia.id
  peer_vpc_id = aws_vpc.vpc_oregon.id
  peer_region = var.name_accepter_region
  auto_accept = false

  tags = {
    Name = "peer_to_accepter"
  }

  depends_on = [
    aws_vpc.vpc_virginia,
    aws_vpc.vpc_oregon
  ]
  
}

resource "aws_vpc_peering_connection_accepter" "accepter" {
  provider                  = aws.oregon
  vpc_peering_connection_id = aws_vpc_peering_connection.request.id
  auto_accept               = true

  tags = {
    Name = "peer_to_requester"
  }

  depends_on = [
    aws_vpc.vpc_virginia,
    aws_vpc.vpc_oregon
  ]
}