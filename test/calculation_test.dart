import 'package:test/test.dart';
import 'package:test_calculation/pages/calculation.dart';

void main() {
  group('Calculation', () {
    test('value should start at 1', () {
      expect(Calculation().interest, 0);
    });

    test('value should be calculated for simple interest', () {
      final calculation = Calculation();

      calculation.interestCal();

      expect(calculation.principal, 0);
      expect(calculation.rate, 0);
      expect(calculation.time, 0);
    });

    test('value should be calculated for principal Amount ', () {
      final calculation = Calculation();

      calculation.principalWithInterestCal();

      expect(calculation.interest, 0);
      expect(calculation.principal, 0);
    });
  });
}
