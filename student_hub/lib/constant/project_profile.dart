enum CompanySize {
  justMe(0), // Assign value 0
  small(1), // Assign value 0
  medium(2), // Assign value 1
  large(3), // Assign value 0
  veryLarge(4); // Assign value 0

  const CompanySize(this.value);
  final int value;
}
