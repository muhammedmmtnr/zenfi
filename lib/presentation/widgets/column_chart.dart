
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import 'package:zenfi/Constants/color.dart';
import 'package:zenfi/domain/models/transaction_model.dart';

class ColumnChart extends StatefulWidget {
  final List<Transaction> transactions;
  final int currIndex;

  const ColumnChart({
    Key? key,
    required this.transactions,
    required this.currIndex,
  }) : super(key: key);

  @override
  State<ColumnChart> createState() => _ColumnChartState();
}

class _ColumnChartState extends State<ColumnChart> {
  late TooltipBehavior _tooltipBehavior;
  final List<ChartData> chartData = [];
  final Map<String, List<double>> mapData = {};
  final DateFormat dateFormat = DateFormat.MMM();

  final List<String> customFormats = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true, color: primaryColor);
    calculateChartData();
  }

  @override
  void didUpdateWidget(covariant ColumnChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currIndex != oldWidget.currIndex ||
        widget.transactions != oldWidget.transactions) {
      calculateChartData();
    }
  }

  void calculateChartData() {
    // Clear previous data
    mapData.clear();

    // Populate mapData with transactions
    for (var transaction in widget.transactions) {
      String formattedDate = getFormattedDate(widget.currIndex, transaction.createAt);

      // Initialize map values if not present
      mapData.putIfAbsent(formattedDate, () => [0.0, 0.0]);

      double amount = double.tryParse(transaction.amount) ?? 0.0;
      if (transaction.type == 'Income') {
        mapData[formattedDate]![0] += amount;  // Accumulate income
      } else if (transaction.type == 'Expense') {
        mapData[formattedDate]![1] += amount;  // Accumulate expense
      }
    }

    // Clear and populate chartData based on mapData
    chartData.clear();
    mapData.forEach((key, value) {
      chartData.add(ChartData(key, value[0], value[1]));
    });

    // Sort chartData by the x values (formatted dates)
    chartData.sort((a, b) => customFormats.indexOf(a.x).compareTo(customFormats.indexOf(b.x)));
  }

  String getFormattedDate(int index, DateTime dateTime) {
    // Custom format for index 3; otherwise, include the day
    return index == 3
        ? customFormats[dateTime.month - 1]
        : '${dateFormat.format(dateTime)} ${dateTime.day}';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 380,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
          numberFormat: NumberFormat.compact(),
        ),
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          toggleSeriesVisibility: true,
        ),
        tooltipBehavior: _tooltipBehavior,
        series: <CartesianSeries<ChartData, String>>[
          ColumnSeries<ChartData, String>(
            name: 'Income',
            dataSource: chartData,
            color: Colors.green,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            dataLabelSettings: const DataLabelSettings(isVisible: false),
            enableTooltip: true,
          ),
          ColumnSeries<ChartData, String>(
            name: 'Expense',
            color: Colors.red,
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y1,
            dataLabelSettings: const DataLabelSettings(isVisible: false),
            enableTooltip: true,
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1);

  final String x;
  final double y;  // Income value
  final double y1; // Expense value
}
