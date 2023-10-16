import 'package:fikkton/res/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class UserGeograph extends StatefulWidget {
  const UserGeograph({super.key});

  @override
  State<UserGeograph> createState() => _UserGeographState();
}

class _UserGeographState extends State<UserGeograph> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BarData {
  final double view1;
  final double view2;
  final double view3;
  final double view4;
  final double view5;
  final double view6;
  final double view7;

  BarData({
    required this.view1,
    required this.view2,
    required this.view3,
    required this.view4,
    required this.view5,
    required this.view6,
    required this.view7,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: view1),
      IndividualBar(x: 1, y: view2),
      IndividualBar(x: 2, y: view3),
      IndividualBar(x: 3, y: view4),
      IndividualBar(x: 4, y: view5),
      IndividualBar(x: 5, y: view6),
      IndividualBar(x: 6, y: view7),
    ];
  }
}

class IndividualBar {
  final int x;
  final double y;

  IndividualBar({
    required this.x,
    required this.y,
  });
}

class Demograph extends StatelessWidget {
  final List demoSummary;
  const Demograph({
    super.key,
    required this.demoSummary,
  });

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      view1: demoSummary[0],
      view2: demoSummary[1],
      view3: demoSummary[2],
      view4: demoSummary[3],
      view5: demoSummary[4],
      view6: demoSummary[5],
      view7: demoSummary[6],
    );
    myBarData.initializeBarData();
    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(
                  x: data.x,
                  barRods: [
                    BarChartRodData(
                      toY: data.y,
                      color: AppColors.lightSecondary,
                      width: 10,
                      borderRadius: BorderRadius.circular(3),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 100,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
