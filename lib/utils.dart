double calculateBMI(double height, double weight) {
  if (height <= 0 || weight <= 0) {
    throw ArgumentError('Height and weight must be greater than zero.');
  }
  return weight / ((height / 100) * (height / 100));
}
