import 'package:flutter/material.dart';
import 'package:reports_app/helper/localization_helper.dart';

import '../../../core/widgets/app_button.dart';
import '../model/report_model.dart';
import '../widget/rating_item_widget.dart';
import '../../butcher_shops/view/butcher_shops_report_screen.dart';
import '../model/zone_report.dart';
import '../view_model/cubit/report_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateReportScreen extends StatefulWidget {
  const CreateReportScreen({super.key});

  @override
  State<CreateReportScreen> createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {

  String notes = "";

  @override
  Widget build(BuildContext context) {
    final cubit = ReportCubit.get(context);
    final questions = cubit.getCurrentQuestions();
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title:  Text(
            t.translate(cubit.selectedZone),
          style: TextStyle(color: Colors.black),
        ),
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const SizedBox(height: 20),

            // ================= RATINGS CARD =================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Column(
                children: questions.map((item) {
                  return RatingItem(
                    title: t.translate(item.key), // 👈 الحل الصح
                    value: item.value,
                    onChanged: (v) {
                      setState(() {
                        item.value = v;
                      });
                    },
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // // ================= NOTES CARD =================
            // Container(
            //   padding: const EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(16),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.05),
            //         blurRadius: 10,
            //         offset: const Offset(0, 5),
            //       )
            //     ],
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Text(
            //         "الملاحظات",
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //
            //       const SizedBox(height: 10),
            //
            //       NotesField(
            //         value: notes,
            //         onChanged: (v) => setState(() => notes = v),
            //       ),
            //     ],
            //   ),
            // ),

            const SizedBox(height: 30),

            AppPrimaryButton(
              onTap: () {

                final cubit = ReportCubit.get(context);

                final report = ZoneReport(
                  title: cubit.selectedZone,
                  ratings: {
                    for (var item in cubit.getCurrentQuestions())
                      item.key: item.value,
                  },
                  notes: notes,
                );

                cubit.addZoneReport(report);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ButcherShopsReportScreen())); // يرجع للداشبورد
              },
              isLoading: false,
              text: t.saveReport,

            )
          ],
        ),
      ),
    );
  }

}

// class NotesField extends StatelessWidget {
//   final String value;
//   final Function(String) onChanged;
//
//   const NotesField({
//     super.key,
//     required this.value,
//     required this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       onChanged: onChanged,
//       maxLines: 4,
//       decoration: InputDecoration(
//         hintText: "الملاحظات",
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }
// }