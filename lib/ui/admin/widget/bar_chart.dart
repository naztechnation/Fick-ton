
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../model/posts/admin_model.dart';
import '../../../res/app_colors.dart';

class AdminDashboardGraph extends StatefulWidget {

 final DashBoardAnalysis? analysis;

  AdminDashboardGraph({super.key,  this.analysis});

  final Color leftBarColor = Color(0xffFF8150);
  final Color rightBarColor = AppColors.lightSecondary;
  final Color avgColor =
      AppColors.cardColor;
  @override
  State<StatefulWidget> createState() => AdminDashboardGraphState();
}

class AdminDashboardGraphState extends State<AdminDashboardGraph> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    loadAnalysisData();
  }

  loadAnalysisData(){

    final barGroup1 = makeGroupData(0, widget.analysis!.data!.viewsAnalysis!.jan!.toDouble(), widget.analysis!.data!.usersAnalysis!.jan!.toDouble());
    final barGroup2 = makeGroupData(1, widget.analysis!.data!.viewsAnalysis!.feb!.toDouble(), widget.analysis!.data!.usersAnalysis!.feb!.toDouble());
    final barGroup3 = makeGroupData(2, widget.analysis!.data!.viewsAnalysis!.mar!.toDouble(), widget.analysis!.data!.usersAnalysis!.mar!.toDouble());
    final barGroup4 = makeGroupData(3, widget.analysis!.data!.viewsAnalysis!.apr!.toDouble(), widget.analysis!.data!.usersAnalysis!.apr!.toDouble());
    final barGroup5 = makeGroupData(4, widget.analysis!.data!.viewsAnalysis!.may!.toDouble(), widget.analysis!.data!.usersAnalysis!.may!.toDouble());
    final barGroup6 = makeGroupData(5, widget.analysis!.data!.viewsAnalysis!.jun!.toDouble(), widget.analysis!.data!.usersAnalysis!.jun!.toDouble());
    final barGroup7 = makeGroupData(6, widget.analysis!.data!.viewsAnalysis!.jul!.toDouble(), widget.analysis!.data!.usersAnalysis!.jul!.toDouble());
    final barGroup8 = makeGroupData(7, widget.analysis!.data!.viewsAnalysis!.aug!.toDouble(), widget.analysis!.data!.usersAnalysis!.aug!.toDouble());
    final barGroup9 = makeGroupData(8, widget.analysis!.data!.viewsAnalysis!.sep!.toDouble(), widget.analysis!.data!.usersAnalysis!.sep!.toDouble());
    final barGroup10 = makeGroupData(9, widget.analysis!.data!.viewsAnalysis!.oct!.toDouble(), widget.analysis!.data!.usersAnalysis!.oct!.toDouble());
    final barGroup11 = makeGroupData(10, widget.analysis!.data!.viewsAnalysis!.nov!.toDouble(), widget.analysis!.data!.usersAnalysis!.nov!.toDouble());
    final barGroup12 = makeGroupData(11, widget.analysis!.data!.viewsAnalysis!.dec!.toDouble(), widget.analysis!.data!.usersAnalysis!.dec!.toDouble());

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
      barGroup8,
      barGroup9,
      barGroup10,
      barGroup11,
      barGroup12,

    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           
             
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 20,
                  groupsSpace: 0.0,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.grey,
                      getTooltipItem: (a, b, c, d) => null,
                    ),
                    touchCallback: (FlTouchEvent event, response) {
                      if (response == null || response.spot == null) {
                        setState(() {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                        });
                        return;
                      }
        
                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;
        
                      setState(() {
                        if (!event.isInterestedForInteractions) {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                          return;
                        }
                        showingBarGroups = List.of(rawBarGroups);
                        if (touchedGroupIndex != -1) {
                          var sum = 0.0;
                          for (final rod
                              in showingBarGroups[touchedGroupIndex].barRods) {
                            sum += rod.toY;
                          }
                          final avg = sum /
                              showingBarGroups[touchedGroupIndex]
                                  .barRods
                                  .length;
        
                          showingBarGroups[touchedGroupIndex] =
                              showingBarGroups[touchedGroupIndex].copyWith(
                            barRods: showingBarGroups[touchedGroupIndex]
                                .barRods
                                .map((rod) {
                              return rod.copyWith(
                                  toY: avg, color: widget.avgColor);
                            }).toList(),
                          );
                        }
                      });
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 18,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    );
    String text;
    if (value == 10) {
      text = '10';
    } else if (value == 20) {
      text = '20';
    } else if (value == 30) {
      text = '30';
    } else if (value == 40) {
      text = '40';
    } else if (value == 50) {
      text = '50';
    }else if (value == 60) {
      text = '60';
    }else if (value == 70) {
      text = '70';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, 
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 1.5;
    const space = 1.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}