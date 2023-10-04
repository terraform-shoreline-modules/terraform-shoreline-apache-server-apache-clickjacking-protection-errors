resource "shoreline_notebook" "apache_clickjacking_protection_errors" {
  name       = "apache_clickjacking_protection_errors"
  data       = file("${path.module}/data/apache_clickjacking_protection_errors.json")
  depends_on = [shoreline_action.invoke_add_x_frame_options_to_apache_conf]
}

resource "shoreline_file" "add_x_frame_options_to_apache_conf" {
  name             = "add_x_frame_options_to_apache_conf"
  input_file       = "${path.module}/data/add_x_frame_options_to_apache_conf.sh"
  md5              = filemd5("${path.module}/data/add_x_frame_options_to_apache_conf.sh")
  description      = "Configure the web server to send X-Frame-Options headers to prevent clickjacking attacks. This can be done by adding the following line to the Apache configuration file: "Header always append X-Frame-Options SAMEORIGIN"."
  destination_path = "/agent/scripts/add_x_frame_options_to_apache_conf.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_add_x_frame_options_to_apache_conf" {
  name        = "invoke_add_x_frame_options_to_apache_conf"
  description = "Configure the web server to send X-Frame-Options headers to prevent clickjacking attacks. This can be done by adding the following line to the Apache configuration file: "Header always append X-Frame-Options SAMEORIGIN"."
  command     = "`chmod +x /agent/scripts/add_x_frame_options_to_apache_conf.sh && /agent/scripts/add_x_frame_options_to_apache_conf.sh`"
  params      = []
  file_deps   = ["add_x_frame_options_to_apache_conf"]
  enabled     = true
  depends_on  = [shoreline_file.add_x_frame_options_to_apache_conf]
}

