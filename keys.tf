
# resource "aws_key_pair" "project_key" {
#   key_name = "project_key"
#   public_key = file("project_key.pub")
# }

resource "aws_key_pair" "project_key" {
  key_name = var.key_name
  public_key = file("${var.key_file}.pub")
}