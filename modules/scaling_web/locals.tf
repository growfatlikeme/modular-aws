
locals {
  name_prefix = "${var.name}-${var.environment}"
 // selected_subnet_ids = var.public_subnet ? var.public_subnet_ids : var.private_subnet_ids
 /* subnet_map = {
    for i, subnet_id in var.public_subnet_ids : i => subnet_id
  }
  */
}

