variable "OS" {
    default= "ami-04b70fa74e45c3917"
}
variable "Processor" {
    default= "t2.micro"
}
variable "KeyPair" {
    default = "ConnectKey"
}
variable "SecGroupId" {
 default = "sg-0030c841b212cf15d" 
}
variable "InstanceName" {
    default = "TerraForm_Creation"  
}