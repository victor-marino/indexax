class PerformanceDataPoint {
  final DateTime date;
  final double bestReturn;
  final double worstReturn;
  final double expectedReturn;
  final double realReturn;
  final double realMonthlyReturn;

  PerformanceDataPoint({this.date, this.bestReturn, this.worstReturn, this.expectedReturn, this.realReturn, this.realMonthlyReturn});
}