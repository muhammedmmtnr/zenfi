// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// // ignore: depend_on_referenced_packages
// import 'package:intl/intl.dart';
// import 'package:zenfi/Constants/color.dart';
// import 'package:zenfi/domain/models/transaction_model.dart';
// import 'package:collection/collection.dart';

// class SplineChart extends StatefulWidget {
//   final List<Transaction> transactions;
//   final int currIndex;
//   const SplineChart({
//     super.key,
//     required this.transactions,
//     required this.currIndex,
//   });

//   @override
//   State<SplineChart> createState() => _SplineChartState();
// }

// class _SplineChartState extends State<SplineChart> {
//   late TooltipBehavior _tooltipBehavior;
//   List<String> customFormats = [
//     'Jan',
//     'Feb',
//     'Mar',
//     'Apr',
//     'May',
//     'Jun',
//     'Jul',
//     'Aug',
//     'Sep',
//     'Oct',
//     'Nov',
//     'Dec'
//   ];
//   List<ChartData> chartDataIncome = [];
//   List<ChartData> chartDataExpense = [];

//   DateFormat dateFormat = DateFormat.MMM();

//   @override
//   void initState() {
//     super.initState();
//     _tooltipBehavior = TooltipBehavior(enable: true, color: primaryColor);
//     calculateChartData();
//   }

//   @override
//   void didUpdateWidget(SplineChart oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.currIndex != oldWidget.currIndex ||
//         !const ListEquality()
//             .equals(widget.transactions, oldWidget.transactions)) {
//       calculateChartData();
//     }
//   }

//   void calculateChartData() {
//     chartDataIncome.clear();
//     chartDataExpense.clear();

//     for (var element in widget.transactions) {
//       String formattedDate =
//           getFormattedDate(widget.currIndex, element.createAt);
//       if (element.category.type == 'Income') {
//         chartDataIncome
//             .add(ChartData(formattedDate, double.parse(element.amount)));
//       } else {
//         chartDataExpense
//             .add(ChartData(formattedDate, double.parse(element.amount)));
//       }
//     }

//     chartDataIncome.sort((a, b) => a.x.compareTo(b.x));
//     chartDataExpense.sort((a, b) => a.x.compareTo(b.x));
//   }

//   String getFormattedDate(int index, DateTime dateTime) {
//     if (index == 3) {
//       return customFormats[dateTime.month - 1];
//     } else {
//       return '${dateFormat.format(dateTime)} ${dateTime.day}';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 380,
//       child: SfCartesianChart(
//         primaryXAxis: CategoryAxis(
//           labelRotation: -45,
//           labelIntersectAction: AxisLabelIntersectAction.rotate45,
//         ),
//         primaryYAxis: NumericAxis(
//           numberFormat: NumberFormat.compact(),
//           maximum: 20000000,
//         ),
//         legend: Legend(
//           isVisible: true,
//           position: LegendPosition.bottom,
//           toggleSeriesVisibility: true,
//         ),
//         tooltipBehavior: _tooltipBehavior,
//         series: <ChartSeries>[
//           SplineSeries<ChartData, String>(
//             name: 'Income',
//             color: Colors.green,
//             splineType: SplineType.cardinal,
//             width: 5,
//             dataSource: chartDataIncome,
//             xValueMapper: (ChartData data, _) => data.x,
//             yValueMapper: (ChartData data, _) => data.y,
//             markerSettings: const MarkerSettings(isVisible: true),
//             dataLabelSettings: const DataLabelSettings(isVisible: false),
//             enableTooltip: true,
//           ),
//           SplineSeries<ChartData, String>(
//             name: 'Expense',
//             width: 5,
//             color: Colors.red,
//             splineType: SplineType.cardinal,
//             dataSource: chartDataExpense,
//             xValueMapper: (ChartData data, _) => data.x,
//             yValueMapper: (ChartData data, _) => data.y,
//             markerSettings: const MarkerSettings(isVisible: true),
//             dataLabelSettings: const DataLabelSettings(isVisible: false),
//             enableTooltip: true,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ChartData {
//   ChartData(this.x, this.y);
//   final String x;
//   final double? y;
// }
