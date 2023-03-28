module "availabilityZone" {
  source = "./az"
}

module "vpc" {
  source = "./vpc"
}

module "publicSubnet" {
  source = "./publicsn"
  vpcId = module.vpc.vpcId
  cidrBlock = module.vpc.cidrBlock
  availabilityZone = module.availabilityZone.name
}

module "privateSubnet" {
  source = "./privatesn"
  vpcId = module.vpc.vpcId
  cidrBlock = module.vpc.cidrBlock
  availabilityZone = module.availabilityZone.name
}

module "ig" {
  source = "./ig"
  vpcId = module.vpc.vpcId
}

module "awsEip" {
  source = "./eip"
  counts      = 2
  subId = module.publicSubnet.subnetId
  depends_on = [module.ig]
}

module "awsRoute" {
  source = "./route"
  counts      = 2
  vpcId = module.vpc.vpcId
  cidrBlock = "0.0.0.0/0"
  subId = module.privateSubnet.subnetId
  natGatewayId = module.awsEip.natGateId
  routeTableId = module.vpc.routeTableId
  internetGatewayId = module.ig.igId
}

module "awsloadBalancer" {
  source = "./lb"
  vpcId = module.vpc.vpcId
  securityGroupName = "example-alb-security-group"
  subId = module.publicSubnet.subnetId
  loadBalancerName = "example-lb"
  lbTargetGrpName = "example-target-group"
  protocol = "HTTP"
  httpPort = 80
}

module "awsIam" {
  source = "./iam"
}

module "awsEcs" {
  source = "./ecs"
  ecsClusterName = "example-cluster"
  ecsServiceName = "hello-world-service"
  ecsFamilyName = "hello-world-app"
  escTaskSecGrpName = "example-task-security-group"
  ecsLbContainerName = "hello-world-app"
  ecsCapability = "FARGATE"
  iamRoleArns = module.awsIam.iamRoleArn
  vpcId = module.vpc.vpcId
  httpPort = 8081
  lbSecGroups = module.awsloadBalancer.lbSecurityGrpId
  lbTargetGroups = module.awsloadBalancer.lbTargetGrpId
  subId = module.privateSubnet.subnetId
  cidrBlock = "0.0.0.0/0"

  depends_on = [module.awsloadBalancer]
}

module "awsAutoScale" {
  source = "./scale"
  maxInstanceCapacity = 5
  minInstanceCapacity = 1
  resourceId = join("/", ["service", module.awsEcs.clusterName, module.awsEcs.serviceName])
  scalableDimension = "ecs:service:DesiredCount"
  serviceNamespace = "ecs"
  autoScalePname = "dev-to-cpu"
  autoScalePtype = "TargetTrackingScaling"
  predefinedMetricType = "ECSServiceAverageCPUUtilization"
  targetValue = 0.02
}

output "load_balancer_ip" {
  value = module.awsloadBalancer.awsDnsName
}