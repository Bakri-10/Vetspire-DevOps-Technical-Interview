variable "project_id" {
    type = string
}
variable "instance_name" {
    type = string
}
variable "env_variables" {
    type = map(string)
}
variable "image" {
    type = string
}
variable "custom_command" {
    type = string
}
variable "privileged_mode" {
    type = number
}
variable "activate_tty" {
    type = number
}
variable "network_name" {
    type = string
}
variable "client_email" {
    type = string
}