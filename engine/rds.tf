resource "aws_db_subnet_group" "main" {
  for_each   = { for t in local.json_dbsubnet : t.tags.Name => t }
  name       = each.value.name
  subnet_ids = [aws_subnet.main[each.value.subnets[0]].id,aws_subnet.main[each.value.subnets[1]].id]

  tags = {
    Name = each.value.tags.Name
  }
}

resource "aws_db_instance" "main" {
  for_each = { for t in local.json_rdss : t.tags.Name => t }

  identifier =  each.value.identifier
  allocated_storage       = each.value.allocated_storage
  db_name                 = each.value.db_name
  engine                  = each.value.engine
  engine_version          = each.value.engine_version
  instance_class          = each.value.instance_class
  username                = each.value.username
  password                = each.value.password
  db_subnet_group_name    = each.value.db_subnet_group
  parameter_group_name    = each.value.parameter_group_name
  skip_final_snapshot     = each.value.skip_final_snapshot
  vpc_security_group_ids  = [ for sgn in each.value.security_group_names : aws_security_group.main[sgn].id ]
  tags = {
    Name = each.value.tags.Name
  }

  depends_on = [
    aws_db_subnet_group.main
  ]

}
