import 'package:flutter_test/flutter_test.dart';
import 'package:digital_prescription/utils/dose_calc.dart';

void main(){
  test('Dose calculation', (){
    final r = computeDose(doseMg: 500, freqPerDay: 3, days: 7, mgPerUnit: 500);
    expect((r['unitsPerDose'] as double).toStringAsFixed(2), '1.00');
    expect((r['totalUnits'] as double).round(), 21);
  });
}
