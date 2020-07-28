import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';
import 'package:indexa_dashboard/models/amounts_datapoint.dart';

class AmountsChart extends StatelessWidget {
  const AmountsChart({
    Key key,
    //@required this.gradientColors,
    @required this.amountsSeries,
  }) : super(key: key);

  //final LinearGradient gradientColors;
  final List<AmountsDataPoint> amountsSeries;

  @override
  Widget build(BuildContext context) {
    final List<Color> color = <Color>[];
    color.add(Colors.blue[50]);
    color.add(Colors.blue);


    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);

    final LinearGradient gradientColors =
    LinearGradient(transform: GradientRotation(pi*1.5), colors: color, stops: stops);

    return SfCartesianChart(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        primaryYAxis: NumericAxis(
            labelFormat: '{value} €'),
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
          tooltipAlignment: ChartAlignment.near,
          tooltipSettings: InteractiveTooltip(
            enable: true,
            decimalPlaces: 2,
          ),
        ),
        palette: <Color>[
          Colors.blue,
          Colors.blueGrey,
        ],
        legend: Legend(
            isVisible: true,
            position: LegendPosition.top,
            padding: 4,
            itemPadding: 10),
        // Initialize DateTime axis
        primaryXAxis: DateTimeAxis(),
        series: <
            ChartSeries<AmountsDataPoint,
                DateTime>>[
          AreaSeries<AmountsDataPoint,
              DateTime>(
            name: 'Total',
            opacity: 0.7,
            // Bind data source
            dataSource:
            amountsSeries,
            xValueMapper:
                (AmountsDataPoint amounts, _) =>
            amounts.date,
            yValueMapper:
                (AmountsDataPoint amounts, _) =>
            amounts.totalAmount,
            gradient: gradientColors,
          ),
          LineSeries<AmountsDataPoint,
              DateTime>(
            name: 'Aportado',
            // Bind data source
            dataSource:
            amountsSeries,
            xValueMapper:
                (AmountsDataPoint amounts, _) =>
            amounts.date,
            yValueMapper:
                (AmountsDataPoint amounts, _) =>
            amounts.netAmount,
          ),
        ]);
  }
}