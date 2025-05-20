
locals {
  name_prefix = "${var.name}-${var.environment}"
  /*subnet_map = {
    for i, subnet_id in var.public_subnet_ids : i => subnet_id
  }
  */
}
