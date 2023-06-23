class Calculation {
  double principal = 0;
  double rate = 0;
  double time = 0;
  double interest = 0;
  double principalWithInterest = 0;

  void interestCal() => (principal * rate * time) / 100;

  void principalWithInterestCal() => principal + interest ;
}