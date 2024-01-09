eksctl create iamserviceaccount \
  --cluster=<CLUSTER NAME 입력> \
  --profile <AWS PROFILE 입력> \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --attach-policy-arn=arn:aws:iam::<AWS 계정 ID>:policy/AWSLoadBalancerControllerIAMPolicy \
  --override-existing-serviceaccounts \
  --approve
