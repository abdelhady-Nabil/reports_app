import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reports_app/features/report/view_model/cubit/report_cubit.dart';
import 'package:reports_app/helper/localization_helper.dart';

import '../../../core/utils/responsive.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/text_wedget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FinalReportScreen extends StatelessWidget {
  const FinalReportScreen({super.key});

  Color getColor(double value) {
    if (value >= 8) return Colors.green;
    if (value >= 5) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ReportCubit.get(context);
    final report = cubit.masterReport;
    final t = AppLocalizations.of(context)!;

    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          t.showFinalReport,
          style: const TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // ================= HEADER =================
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xffFF3B3B), Color(0xffD90429)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                _buildHeaderRow(
                  title: t.generalEvaluation,
                  value: "${(report.totalAverage * 10).toStringAsFixed(0)}%",
                ),

                _buildHeaderRow(
                  title: t.name,
                  value: report.factoryName,
                ),

                _buildHeaderRow(
                  title: t.mobileNumber,
                  value: report.phone,
                ),

                _buildHeaderRow(
                  title: t.address,
                  value: report.address,
                ),

                _buildHeaderRow(
                  title: t.date,
                  value: report.date.toString().split(' ')[0],
                ),

                _buildHeaderRow(
                  title: t.time,
                  value: report.reportTime != null
                      ? "${report.reportTime!.hour}:${report.reportTime!.minute}"
                      : "--:--",
                ),

                _buildHeaderRow(
                  title: t.inspectorName,
                  value: report.inspectorName,
                ),

                _buildHeaderRow(
                  title: t.escortName,
                  value: report.escortName,
                ),

                _buildHeaderRow(
                  title: t.jobTitle,
                  value: t.translate(report.jobTitle),
                ),

                // _buildHeaderRow(
                //   title: t.officialDocument,
                //   value: report.officialDocument,
                // ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ================= ZONES =================
          ...report.zones.map((zone) {
            final avg = zone.average;

            return TweenAnimationBuilder(
              duration: const Duration(milliseconds: 600),
              tween: Tween<double>(begin: 0, end: avg),
              builder: (context, value, child) {

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // ================= TITLE =================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AppText(
                                title: t.translate(zone.title),
                              color: Colors.black,
                            ),
                          ),
                          AppText(
                            title: avg.toStringAsFixed(1),
                            color: getColor(avg),
                          ),

                        ],
                      ),

                      const SizedBox(height: 10),

                      // ================= PROGRESS =================
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: (value as double) / 10,
                          minHeight: 10,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation(
                            getColor(avg),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // ================= DETAILS =================
                      ...zone.ratings.entries.map((e) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: AppText(
                                    title:t.translate(e.key),
                                  color: Colors.black,
                                ),
                              ),

                              AppText(
                                title:e.value.toStringAsFixed(1),
                                color: Colors.black,

                              ),

                            ],
                          ),
                        );
                      }),


                      const SizedBox(height: 10),
                      // ================= ZONE NOTES =================
                      if (zone.notes.isNotEmpty)
                        Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(title: t.notes,color: Colors.black,),
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(16),

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  )
                                ],
                              ),
                              child:Text(
                                zone.notes,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: isTablet ? 35 : 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                            ),
                          ],
                        ),

                      const SizedBox(height: 10),

                      /// ================= ZONE IMAGES =================
                      if (zone.images.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(title: "📸 ${t.photos}", color: Colors.black),

                            const SizedBox(height: 10),

                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: zone.images.map((imgPath) {
                                return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => Dialog(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(16),
                                          child: Image.file(
                                            File(imgPath),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      File(imgPath),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            const SizedBox(height: 10),
                          ],
                        ),

                    ],
                  ),
                );
              },
            );
          }),

          const SizedBox(height: 20),

          // ================= paper =================
          if (report.officialDocument.isNotEmpty)
            Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(title: t.officialDocument,color: Colors.black,),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child:Text(
                    report.officialDocument,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: isTablet ? 35 : 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                ),
              ],
            ),
          // ================= NOTES =================
          if (report.generalNotes.isNotEmpty)
            Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(title: t.general_notes,color: Colors.black,),
                Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                  child:Text(
                    report.generalNotes,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: isTablet ? 35 : 25,
                        fontWeight: FontWeight.w600,
                    ),
                  ),

                ),
              ],
            ),


          const SizedBox(height: 25),

          /// ================= CHART =================

          Container(
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                AppText(
                  title: "📊 ${t.generalEvaluation}",
                  color: Colors.black,
                ),

                const SizedBox(height: 25),

                SizedBox(
                  height: 350,

                  child: BarChart(

                    BarChartData(

                      maxY: 10,

                      alignment: BarChartAlignment.spaceAround,

                      gridData: FlGridData(
                        show: true,
                        horizontalInterval: 2,
                        drawVerticalLine: false,
                      ),

                      borderData: FlBorderData(show: false),

                      titlesData: FlTitlesData(

                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),

                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),

                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 2,
                            reservedSize: 30,
                          ),
                        ),

                        bottomTitles: AxisTitles(

                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 90,

                            getTitlesWidget: (value, meta) {

                              final index = value.toInt();

                              if (index >= report.zones.length) {
                                return const SizedBox();
                              }

                              final zoneTitle =
                              t.translate(report.zones[index].title);

                              /// كل كلمة تحت التانية
                              final formattedTitle =
                              zoneTitle.replaceAll(' ', '\n');

                              return Padding(
                                padding: const EdgeInsets.only(top: 12),

                                child: Text(
                                  formattedTitle,

                                  textAlign: TextAlign.center,

                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      barGroups: List.generate(
                        report.zones.length,

                            (index) {

                          final zone = report.zones[index];

                          final avg = zone.average;

                          return BarChartGroupData(

                            x: index,

                            barRods: [

                              BarChartRodData(

                                toY: avg,

                                width: 26,

                                borderRadius: BorderRadius.circular(8),

                                gradient: LinearGradient(
                                  colors: [
                                    getColor(avg).withOpacity(0.7),
                                    getColor(avg),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),

                              ),
                            ],

                            showingTooltipIndicators: [0],
                          );
                        },
                      ),

                      barTouchData: BarTouchData(

                        enabled: true,

                        touchTooltipData: BarTouchTooltipData(

                          getTooltipItem:
                              (group, groupIndex, rod, rodIndex) {

                            final zone =
                            report.zones[group.x];

                            return BarTooltipItem(

                              "${t.translate(zone.title)}\n${zone.average.toStringAsFixed(1)}",

                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          AppPrimaryButton(
            text: 'pdf', // أو "تحميل PDF"
            onTap: () {
              ReportCubit.get(context).generatePdf(context);
            }, isLoading: false,
          ),
          const SizedBox(height: 20),

          Row(
            children: [

              /// 🗑️ DELETE
              Expanded(
                child: AppPrimaryButton(
                  text: t.delete,
                  onTap: () {
                    ReportCubit.get(context).resetReport();
                    Navigator.pop(context);
                  },
                  isLoading: false,
                ),
              ),

              const SizedBox(width: 10),


              Expanded(
                child:  /// 💾 SAVE LOCAL
                AppPrimaryButton(
                  text: t.save,
                  onTap: () async {
                    await ReportCubit.get(context).saveReportLocally();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("تم الحفظ بنجاح")),
                    );
                  },
                  isLoading: false,
                ),
                // child: AppPrimaryButton(
                //   text: "تعديل",
                //   onTap: () {
                //     Navigator.pop(context); // يرجع يعدل
                //   },
                //   isLoading: false,
                // ),
              ),
            ],
          ),

          const SizedBox(height: 10),


        ],
      ),
    );
  }
  Widget _buildHeaderRow({
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            flex: 2,
            child: AppText(
              title: title,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            flex: 3,
            child: AppText(
              title: value,
            ),
          ),
        ],
      ),
    );
  }
}