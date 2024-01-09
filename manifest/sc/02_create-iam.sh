eksctl create iamserviceaccount \
    --name ebs-csi-controller-sa \
    --namespace kube-system \
    --cluster<CLUSTER NAME> \
    --attach-policy-arn arn:aws:iam::<AWS ACCOUNT ID>:policy/AmazonEKS_EBS_CSI_Driver_Policy \
    --approve \
    --role-only --profile <PROFILE NAME>
