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
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        AppText(title: t.generalEvaluation),
                        const SizedBox(width: 40),
                        Expanded(
                          child: AppText(
                            title: "${(report.totalAverage * 10).toStringAsFixed(0)}%",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        AppText(title: t.place_name),
                        const SizedBox(width: 40),
                        Expanded(
                          child: AppText(
                            title: report.factoryName,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        AppText(title: t.report_date),
                        const SizedBox(width: 40),
                        Expanded(
                          child: AppText(
                            title: report.date.toString().split(' ')[0],
                          ),
                        ),
                      ],
                    ),

                  ],
                ),

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


                    ],
                  ),
                );
              },
            );
          }),

          const SizedBox(height: 20),

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
}