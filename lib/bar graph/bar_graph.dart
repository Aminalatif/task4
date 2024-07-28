import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'bar_data.dart';
class MyBarGraph extends StatelessWidget {

  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tuesAmount;
  final double wedAmount;
  final double thursAmount;
  final double friAmount;
  final double satAmount;
  const MyBarGraph({super.key, this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tuesAmount,
    required this.wedAmount,
    required this.thursAmount,
    required this.friAmount,
    required this.satAmount,

  });

  @override
  Widget build(BuildContext context) {

    BarData myBarData = BarData(
        sunAmount:sunAmount,
        monAmount:monAmount,
        tuesAmount:tuesAmount,
        wedAmount:wedAmount,
         thursAmount:thursAmount,
         friAmount:friAmount,
         satAmount: satAmount,
    );

   myBarData.initializeBarData();
    return BarChart(
      BarChartData(
        maxY : maxY,
        minY : 0,
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget:getBottomTitles,
              ),
            ),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups : myBarData.barData.map((data)=>
            BarChartGroupData(
              x: data.x,
              barRods:[
                BarChartRodData(toY: data.y,
                color: Colors.grey.shade800,
                width: 22,
                borderRadius: BorderRadius.circular(4),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: maxY,
                  color: Colors.grey.shade400,
                )),
              ],
            ),
        ).
        toList()
      )
    );
  }
}
 Widget getBottomTitles(double value, TitleMeta meta){
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  Widget text;
  switch(value.toInt()) {
    case 0:
      text = const Text('Sun', style: style);
      break;
    case 1:
      text = const Text('Mon', style:style );
      break;
    case 2:
      text = const Text('Tue', style: style);
      break;
    case 3:
      text = const Text('wed', style: style);
      break;
    case 4:
      text = const Text('Thu', style: style);
      break;
    case 5:
      text = const Text('Fri', style: style);
      break;
    case 6:
      text = const Text('Sat', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide,
  );
 }
