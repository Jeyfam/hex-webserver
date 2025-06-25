variable "region" {
  default = "ap-southeast-2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "SSH Key pair name (optional for debugging)"
  type        = string
  default     = ""
}
