
locals {
  name_prefix = "${var.name}-${var.environment}"
 // selected_subnet_ids = var.public_subnet ? var.public_subnet_ids : var.private_subnet_ids
 /* subnet_map = {
    for i, subnet_id in var.public_subnet_ids : i => subnet_id
  }
  */
  domain_name = "${local.name_prefix}.sctp-sandbox.com"  # e.g., estee-dev.sctp-sandbox.com
}

