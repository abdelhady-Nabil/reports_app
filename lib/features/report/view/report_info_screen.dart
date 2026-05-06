import 'package:flutter/material.dart';
import 'package:reports_app/core/widgets/app_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reports_app/core/widgets/text_wedget.dart';

import '../view_model/cubit/report_cubit.dart';

class ReportInfoScreen extends StatefulWidget {
  final Widget? nextScreen;

  const ReportInfoScreen({
    super.key,
    this.nextScreen,
  });

  @override
  State<ReportInfoScreen> createState() => _ReportInfoScreenState();
}

class _ReportInfoScreenState extends State<ReportInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController inspectorController = TextEditingController();
  final TextEditingController escortController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController officialDocumentController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
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

              _buildInput(
                title: t.name,
                controller: nameController,
              ),

              _buildInput(
                title: t.address,
                controller: addressController,
              ),

              /// ================= DATE =================
              _buildSectionTitle(t.date),

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
                          fontSize: 28,
                        ),
                      ),

                      const Icon(
                        Icons.calendar_today,
                        color: Colors.red,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              //time
              _buildSectionTitle(t.time),

              _buildCard(
                child: InkWell(
                  onTap: () async {

                    final picked = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );

                    if (picked != null) {
                      setState(() {
                        selectedTime = picked;
                      });
                    }
                  },

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        selectedTime.format(context),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),

                      const Icon(
                        Icons.access_time,
                        color: Colors.red,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const SizedBox(height: 20),

              _buildInput(
                title: t.inspectorName,
                controller: inspectorController,
              ),

              _buildInput(
                title: t.escortName,
                controller: escortController,
              ),

              _buildInput(
                title: t.jobTitle,
                controller: jobTitleController,
              ),

              _buildInput(
                title: t.officialDocument,
                controller: officialDocumentController,
                maxLines: 4
              ),

              _buildInput(
                title: t.notes,
                controller: notesController,
                maxLines: 4,
              ),

              const SizedBox(height: 20),

              AppPrimaryButton(
                text: widget.nextScreen != null ? t.next : t.save,
                onTap: () {

                  cubit.setReportInfo(
                    name: nameController.text,
                    date: selectedDate,
                    notes: notesController.text,
                    address: addressController.text,

                    time: selectedTime,

                    inspectorName: inspectorController.text,
                    escortName: escortController.text,
                    jobTitle: jobTitleController.text,
                    officialDocument: officialDocumentController.text,

                  );

                  if (widget.nextScreen != null) {

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => widget.nextScreen!,
                      ),
                    );

                  } else {

                    Navigator.pop(context);

                  }
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
  Widget _buildInput({
    required String title,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        _buildSectionTitle(title),

        _buildCard(
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 26,
            ),
            decoration: InputDecoration(
              hintText: title,
              border: InputBorder.none,
            ),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}