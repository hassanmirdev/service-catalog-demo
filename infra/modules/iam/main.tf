# IAM Policy for Launch Role
resource "aws_iam_policy" "ec2_servicecatalog_policy" {
  name        = var.policy_name
  description = "Policy to allow Service Catalog to create EC2 instances, access S3 artifacts, and manage resource groups"
  policy      = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:RunInstances",
                "ec2:TerminateInstances",
                "ec2:DescribeInstances",
                "ec2:DescribeSubnets",
                "ec2:DescribeVpcs",
                "ec2:CreateSecurityGroup",
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:AuthorizeSecurityGroupEgress",
                "ec2:AssociateIamInstanceProfile",
                "iam:PassRole",
                "ec2:CreateTags"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowS3AccessForServiceCatalogProvisioning",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "s3:ExistingObjectTag/servicecatalog:provisioning": "true"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::*"
            ]
        },
        {
            "Sid": "AllowResourceGroupManagement",
            "Effect": "Allow",
            "Action": [
                "resource-groups:CreateGroup",
                "resource-groups:ListGroupResources",
                "resource-groups:DeleteGroup",
                "resource-groups:Tag"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowListingResourcesForServiceCatalog",
            "Effect": "Allow",
            "Action": [
                "tag:GetResources",
                "tag:GetTagKeys",
                "tag:GetTagValues",
                "servicecatalog:ListRecordHistory",
                "servicecatalog:ListProvisionedProductPlans",
                "servicecatalog:ListPortfoliosForProduct",
                "servicecatalog:ListLaunchPaths",
                "servicecatalog:DescribeRecord"
            ],
            "Resource": "*"
        }
    ]
}
POLICY
}



#  IAM Role for Launch Constraint
resource "aws_iam_role" "servicecatalog_launch_role" {
  name               = "var.role_name"
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "GivePermissionsToServiceCatalog",
            "Effect": "Allow",
            "Principal": {
                "Service": "servicecatalog.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::686255946921:root"
            },
            "Action": "sts:AssumeRole",
            "Condition": {
                "StringLike": {
                    "aws:PrincipalArn": [
                        "arn:aws:iam::686255946921:role/TerraformEngine/TerraformExecutionRole*",
                        "arn:aws:iam::686255946921:role/TerraformEngine/ServiceCatalogExternalParameterParserRole*",
                        "arn:aws:iam::686255946921:role/TerraformEngine/ServiceCatalogTerraformOSParameterParserRole*"
                    ]
                }
            }
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.servicecatalog_launch_role.name
  policy_arn = aws_iam_policy.ec2_servicecatalog_policy.arn
}
