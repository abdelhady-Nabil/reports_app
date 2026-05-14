import 'package:flutter/material.dart';
import 'package:reports_app/core/widgets/app_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reports_app/core/widgets/text_wedget.dart';

import '../view_model/cubit/report_cubit.dart';
import 'package:reports_app/helper/localization_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reports_app/helper/localization_helper.dart';

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
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController inspectorController = TextEditingController();
  final TextEditingController escortController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController officialDocumentController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  final List<String> jobTitleKeys = [
    "job_head_board",
    "job_general_manager",
    "job_facility_manager",
    "job_assistant_manager",
    "job_quality_supervisor",
    "job_production_supervisor",
    "job_quality_manager",
    "job_butcher_manager",
    "job_butcher_supervisor",
    "job_senior_butcher",
    "job_other"
  ];

  Widget _buildJobTitleSelector(AppLocalizations t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(t.jobTitle),

        _buildCard(
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: jobTitleKeys.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final key = jobTitleKeys[index];

                      return ListTile(
                        title: Text(
                          t.translate(key),
                          style: const TextStyle(fontSize: 18),
                        ),
                        onTap: () {
                          Navigator.pop(context);

                          if (key == "job_other") {
                            _showManualJobDialog(t);
                          } else {
                            setState(() {
                              jobTitleController.text = key;
                            });
                          }
                        },
                      );
                    },
                  );
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  jobTitleController.text.isEmpty
                      ? t.jobTitle
                      : jobTitleController.text.startsWith("job_")
                      ? t.translate(jobTitleController.text)
                      : jobTitleController.text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down_circle,
                  color: Colors.red,
                  size: 30,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
  void _showManualJobDialog(AppLocalizations t) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(t.job_other),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: t.job_other,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  setState(() {
                    jobTitleController.text = controller.text.trim();
                  });
                }
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }  @override

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

              _buildInput(
                title: t.mobileNumber,
                controller: phoneController,
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

              _buildJobTitleSelector(t),
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
                    phone: phoneController.text,
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