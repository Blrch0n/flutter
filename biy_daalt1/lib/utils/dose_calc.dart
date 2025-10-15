Map<String, dynamic> computeDose({required double doseMg, required int freqPerDay, required int days, required double mgPerUnit}){
  if([doseMg,freqPerDay.toDouble(),days.toDouble(),mgPerUnit].any((v)=>v<=0)) throw ArgumentError('positive only');
  final unitsPerDose = doseMg / mgPerUnit;
  final totalUnits = unitsPerDose * freqPerDay * days;
  return {'unitsPerDose': unitsPerDose, 'totalUnits': totalUnits, 'schedule': '${doseMg.toStringAsFixed(0)} mg x $freqPerDay/day x $days days'};
}
