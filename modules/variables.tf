variable "rgname" {
  type        = string
  description = "Name of resource group"
}

variable "rglocation" {
  type        = string
  description = "select the location"
}

variable "vnetname" {
  type        = string
  description = "Name of vnet"
}

variable "vnet01_cidr_prefix" {
  type        = string
  description = "This varible defines address space for vnet"
}

variable "subnetname" {
  type        = string
  description = "Name  for subnet"
  }
variable "subnet01_cidr_prefix" {
  type        = string
  description = "This varible defines address space for subnet"
  }

variable "nic-interfacename" {
  type        = string
  description = "Name of nic card"
  }

  variable "vmname01" {
  type        = string
  description = "Name of VM"
  }

 variable "publicipname_id" {
  type        = string
  description = "Name of public ip"
  }

  variable "nsgname" {
  type        = string
  description = "Name of nsg"
  }

  variable "admin_name" {
  type        = string
  description = "Username of admin"
  }


variable "admin_password" {
  type        = string
  description = "password of admin"
}


