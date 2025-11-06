aws-region = "eu-north-1"
env        = "dev"
cidr-block = "10.0.0.0/16"
#pub-subnet-count=4
pub-cidr-block = {
  block1 = { cidr = "10.0.0.0/20", az = "eu-north-1a" }
  block2 = { cidr = "10.0.16.0/20", az = "eu-north-1b" }
  block3 = { cidr = "10.0.32.0/20", az = "eu-north-1c" }
  block4 = { cidr = "10.0.64.0/20", az = "eu-north-1d" }
}

ec2-instances = {
  jenkins-server          = { type = "m7i-flex.large", subnet = "block1" }
  monitoring-server       = { type = "m7i-flex.large", subnet = "block2" }
  kubernetes-control-node = { type = "m7i-flex.large", subnet = "block3" }
  kubernetes-worker-node  = { type = "m7i-flex.large", subnet = "block4" }
}
ec2_volume_size = 30
ec2_volume_type = "gp3"



