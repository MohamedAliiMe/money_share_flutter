import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';

class ExpenseOverviewCard extends StatefulWidget {
  final Map<String, double> data;
  final Map<String, double> dropdownValue;
  final double total;

  const ExpenseOverviewCard({
    super.key,
    required this.data,
    required this.total,
    required this.dropdownValue,
  });

  @override
  State<ExpenseOverviewCard> createState() => _ExpenseOverviewCardState();
}

class _ExpenseOverviewCardState extends State<ExpenseOverviewCard> {
  late String selectedPerson;

  @override
  void initState() {
    super.initState();
    selectedPerson = widget.dropdownValue.keys.first;
  }

  static const Map<String, Color> _defaultColors = {
    'You': Color(0xFF6C5CE7),
    'Ahmed': Color(0xFF0984E3),
    'Ali': Color(0xFF00B894),
    'Hassan': Color(0xFFB2BEC3),
  };

  List<PieChartSectionData> _buildSections(Map<String, double> data) {
    final totalValue = data.values.fold<double>(0.0, (p, e) => p + e);
    int i = 0;
    return data.entries.map((e) {
      final percent = (totalValue == 0) ? 0.0 : (e.value / totalValue) * 100;
      final color = _defaultColors[e.key] ??
          Colors.primaries[i % Colors.primaries.length];
      i++;
      return PieChartSectionData(
        color: color,
        value: e.value,
        title: '${percent.toStringAsFixed(0)}%',
        radius: 52.r,
        titleStyle: tr13,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final sections = _buildSections(widget.data);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: AllColors.grey.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AllColors.grey.withValues(alpha: 0.12)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Expense Overview', style: tr16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    height: 34.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AllColors.globalAppColor.withValues(alpha: 0.2),
                      ),
                      color: AllColors.white.withValues(alpha: 0.05),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedPerson,
                        icon: const Icon(Icons.keyboard_arrow_down_sharp,
                            size: 20),
                        isDense: true,
                        style: tr13,
                        items: widget.dropdownValue.keys.map((person) {
                          return DropdownMenuItem(
                            value: person,
                            child: Text(person, style: tr13),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedPerson = value;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Divider(height: 0, color: AllColors.grey.withValues(alpha: 0.3)),
              SizedBox(height: 24.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 130,
                    height: 130,
                    child: PieChart(
                      PieChartData(
                        sections: sections,
                        centerSpaceRadius: 24.r,
                        sectionsSpace: 1.5.w,
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.data.entries.map((entry) {
                      final color = _defaultColors[entry.key] ?? Colors.grey;
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Row(
                          children: [
                            Container(
                              width: 8.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(40.r),
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Text(entry.key, style: tr13),
                          ],
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AllColors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total", style: tr16),
                Text("${widget.total} EGP", style: tr16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
