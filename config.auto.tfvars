tags = {
  costcode    = "123456"
  owner       = "terraform"
  environment = "dev"
  test        = "some_tag"
  ANOTHER_TAG = "another_tag"
}
subnet_address_spaces = {
  "wkld_data" = {
    name             = "wkld_data"
    address_prefixes = ["10.0.10.0/24"]
  }
  "wkld_compute" = {
    name             = "wkld_compute"
    address_prefixes = ["10.0.11.0/24"]
  }
}
default_groups = [ "contributor" ]