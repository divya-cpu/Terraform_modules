variable "rg-name" {

  default = "RG-001"
}

variable "name" {

  default = "my-vn-dev"
}

variable "address_space" {
  default = ["10.0.0.0/16"]

}

variable "subnet1_space" {

  default = ["10.0.0.0/24"]

}

variable "subnet2_space" {

  default = ["10.0.1.0/24"]

}

variable "tag" {
  default = "terraform"
}

variable "env" {}