data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
#creates IAM roles for your cluster
resource "aws_iam_role" "eksrole" { 
  name               = "eks-cluster-tmr"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
#Attaches IAM policy to role
resource "aws_iam_role_policy_attachment" "eksrole-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eksrole.name
}


