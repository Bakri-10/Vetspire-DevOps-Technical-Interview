env_variables = {
  HOST = "localhost"
}
image           = "nginx"
privileged_mode = 0
activate_tty    = 0
custom_command = "nginx -s"
instance_name = "nginx"
network_name  = "test-net"
client_email = "dev-api@test-project.iam.gserviceaccount.com"
project_id = "test-project"
