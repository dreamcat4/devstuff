# Configure the Vultr Provider
provider "vultr" {
  api_key = "VULTR_API_KEY"
  rate_limit = 700
  retry_limit = 3
}

resource "vultr_server" "my_server" {
    plan_id = "201"
    region_id = "6"
    os_id = "167"
    label = "my-server-label"
    tag = "my-server-tag"
    hostname = "test01"
    user_data = "{'foo': true}"
