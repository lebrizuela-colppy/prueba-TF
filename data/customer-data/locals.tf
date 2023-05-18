locals {
  json_vpc = [
    jsondecode(file("${path.module}/vpc.json"))
  ]

  json_subnets = jsondecode(file("${path.module}/subnets.json"))

  json_routetables = jsondecode(file("${path.module}/routetables.json"))

  json_routetablesassocs = flatten([
        for rt_key, rt in local.json_routetables : [
            for subnet_key, subnet in rt.associations.subnets : {
                id = "${rt_key}-${subnet_key}"
                subnet_name = subnet
                rt_name = rt.tags.Name
            }
        ]
    ])

  json_nats = [
    jsondecode(file("${path.module}/nat.json")),
  ]

  json_eips = jsondecode(file("${path.module}/eips.json"))

  json_transit_gateway_attachment = jsondecode(file("${path.module}/transit_gateway_attachment.json"))


  json_internetgateways = [
    jsondecode(file("${path.module}/internetgateway.json"))
  ]
}

data "aws_security_group" "default" {
  vpc_id = aws_vpc.main["customer-data-prod-svc-vpc"].id
  name   = "default"
}
