import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartExpense extends StatelessWidget {
  final double expense;
  final double budget;

  PieChartExpense({super.key, required this.expense, required this.budget});

  Map<String, double> getDataMap() {
    return {
      "Budget": budget - expense,
      "Expense": expense,
    };
  }

  List<Color> colorList = [
    Colors.green,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return PieChart(
      colorList: colorList,
      dataMap: getDataMap(),
      // chartType: ChartType.ring,
      chartRadius: MediaQuery.of(context).size.width / 1.5,
      chartValuesOptions:
          const ChartValuesOptions(showChartValuesInPercentage: true),
    );
  }
}
