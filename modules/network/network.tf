
resource "azurerm_virtual_network" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg
  address_space       = var.address_space

  tags = {
    created_by = var.tag
    name       = var.name
    environment      = var.env
  }
}

# ###########
# # Subnets #
# ###########

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.subnet1_space

}


# resource "azurerm_subnet" "subnet2" {
#   name                 = "subnet2"
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.this.name
#   address_prefixes     = var.subnet2_space
# }

# resource "azurerm_subnet" "subnet2" {
#   name                 = "f1-subnet2-${var.environment}"
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = azurerm_virtual_network.this.name
#   address_prefixes     = var.subnet2_space

#   delegation {
#     name = "delegation"

#     service_delegation {
#       name    = "Microsoft.Web/serverFarms"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }
# }

# resource "azurerm_subnet" "subnet3" {
#   name                 = "f1-subnet3-${var.environment}"
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = azurerm_virtual_network.this.name
#   address_prefixes     = var.subnet3_space
#   service_endpoints    = ["Microsoft.Storage", "Microsoft.Web"]

#   delegation {
#     name = "delegation"

#     service_delegation {
#       name    = "Microsoft.ContainerInstance/containerGroups"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }
# }

# ###########################################
# # NSG for Application Gateway in Subnet 1 #
# ###########################################

# resource "azurerm_network_security_group" "application_gateway" {
#   name                = "f1-nsg-appgtw-${var.environment}"
#   location            = var.location
#   resource_group_name = var.resource_group_name

#   security_rule {
#     name                       = "AllowInbound"
#     description                = "NSG rule to allow Inbound connections"
#     priority                   = 1000
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }

# resource "azurerm_subnet_network_security_group_association" "application_gateway" {
#   subnet_id                 = azurerm_subnet.subnet1.id
#   network_security_group_id = azurerm_network_security_group.application_gateway.id
# }

# ###########################################
# # NSG for Container Instances in Subnet 3 #
# ###########################################

# resource "azurerm_network_security_group" "aci" {
#   name                = "f1-nsg-aci-${var.environment}"
#   location            = var.location
#   resource_group_name = var.resource_group_name

#   security_rule {
#     name                       = "AllowInboundFromAppGateway"
#     description                = "NSG rule to allow Inbound connections from App Gateway"
#     priority                   = 1000
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefixes    = azurerm_subnet.subnet1.address_prefixes
#     destination_address_prefix = "*"
#   }

#   security_rule {
#     name                       = "AllowInboundFromServers"
#     description                = "NSG rule to allow Inbound connections from Server Functions"
#     priority                   = 1500
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefixes    = var.server_functions_outbound_ips
#     destination_address_prefix = "*"
#   }
# }

# resource "azurerm_subnet_network_security_group_association" "aci" {
#   subnet_id                 = azurerm_subnet.subnet3.id
#   network_security_group_id = azurerm_network_security_group.aci.id
# }

# ########################################
# # Network profile for ACIs in Subnet 3 #
# ########################################

# resource "azurerm_network_profile" "this" {
#   name                = "f1-aci-nprofile-${var.environment}"
#   location            = var.location
#   resource_group_name = var.resource_group_name

#   container_network_interface {
#     name = "aci-ntwrkint"

#     ip_configuration {
#       name      = "aci-ntwrkint-ipconfig"
#       subnet_id = azurerm_subnet.subnet3.id
#     }
#   }
# }

# data "azurerm_virtual_network" "vn_common" {
#   name                = "f1-vn-common"
#   resource_group_name = "f1-rg-common"
# }

# # Virtual network peering which allows resources from this rg to access other resources from common virtual network
# resource "azurerm_virtual_network_peering" "this" {
#   name                      = "f1-vn-${var.environment}-common"
#   resource_group_name       = var.resource_group_name
#   virtual_network_name      = azurerm_virtual_network.this.name
#   remote_virtual_network_id = data.azurerm_virtual_network.vn_common.id
# }