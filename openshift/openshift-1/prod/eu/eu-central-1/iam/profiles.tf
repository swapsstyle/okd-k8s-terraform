resource "aws_iam_instance_profile" "openshift_iam_instance_profile" {
  name = "${var.cluster_name}-iam-instance-profile"
  role = "${aws_iam_role.openshift_iam_role.name}"
}
