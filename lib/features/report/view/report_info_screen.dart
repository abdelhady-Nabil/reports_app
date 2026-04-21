import 'package:flutter/material.dart';
import 'package:reports_app/core/widgets/app_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reports_app/core/widgets/text_wedget.dart';

import '../view_model/cubit/report_cubit.dart';

class ReportInfoScreen extends StatefulWidget {
  const ReportInfoScreen({super.key});

  @override
  State<ReportInfoScreen> createState() => _ReportInfoScreenState();
}

class _ReportInfoScreenState extends State<ReportInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final cubit = ReportCubit.get(context);
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xff0D0D0D),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          t.report_info,
          style: const TextStyle(color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// ================= NAME =================
              _buildSectionTitle(t.place_name),
              _buildCard(
                child: TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.black,fontSize: 30),
                  decoration: InputDecoration(
                    hintText: t.place_name,
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// ================= DATE =================
              _buildSectionTitle(t.report_date),
              _buildCard(
                child: InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );

                    if (picked != null) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedDate.toString().split(' ')[0],
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                        ),
                      ),
                      const Icon(Icons.calendar_today, color: Colors.red,size: 30,),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// ================= NOTES =================
              _buildSectionTitle(t.general_notes),
              _buildCard(
                child: TextField(
                  controller: notesController,
                  maxLines: 4,
                  style: const TextStyle(color: Colors.black,fontSize: 30),
                  decoration: InputDecoration(
                    hintText: t.general_notes,
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              /// ================= BUTTON =================
              AppPrimaryButton(
                text: t.save,
                onTap: () {
                  cubit.setReportInfo(
                    name: nameController.text,
                    date: selectedDate,
                    notes: notesController.text,
                  );

                  Navigator.pop(context);
                },
                isLoading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔥 Section Title (Modern)
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4, right: 4),
      child: AppText(
        title:  title,
      ),
    );
  }

  /// 🔥 Card
  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: child,
    );
  }
}