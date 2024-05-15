enum ProjectDuration {
  lessThanOneMonth(0), // Assign value 0
  oneToThreeMonths(1), // Assign value 0
  threeToSixMonths(2), // Assign value 1
  moreThanSixMonth(3); // Assign value 0

  const ProjectDuration(this.value);
  final int value;
}
