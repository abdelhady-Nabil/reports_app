import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reports_app/features/report/view_model/cubit/report_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:reports_app/helper/localization_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/master_report.dart';
import '../../model/rating_item_model.dart';
import '../../model/zone_report.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

class ReportCubit extends Cubit<ReportStates> {
  ReportCubit() : super(ReportInitial());

  static ReportCubit get(context) => BlocProvider.of(context);

  String selectedZone = "";

  Map<String, List<RatingItemModel>> zoneQuestions = {

    // ================= MAIN ZONES =================
    "receivingArea": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "tools"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "maintenance"),
      RatingItemModel(key: "personalHygiene"),
    ],

    "salesArea": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "tools"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "maintenance"),
      RatingItemModel(key: "personalHygiene"),
      RatingItemModel(key: "cashierArea"),
      RatingItemModel(key: "drainage"),
      RatingItemModel(key: "customerService"),
    ],

    // ================= STORAGE =================
    "rawMeatStorage": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "tools"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "maintenance"),
      RatingItemModel(key: "ventilation"),
    ],

    "spicesStorage": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "tools"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "maintenance"),
      RatingItemModel(key: "ventilation"),
    ],

    "packagingMaterials": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "tools"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "maintenance"),
      RatingItemModel(key: "ventilation"),
    ],

    "sanitizationMaterials": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "tools"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "maintenance"),
      RatingItemModel(key: "ventilation"),
    ],

    // ================= OPERATION =================
    "meatProcessing": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "tools"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "maintenance"),
      RatingItemModel(key: "personalHygiene"),
      RatingItemModel(key: "workflowDivision"),
    ],

    "poultryProcessing": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "tools"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "maintenance"),
      RatingItemModel(key: "personalHygiene"),
      RatingItemModel(key: "workflowDivision"),
    ],

    "manufacturingProcessing": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "tools"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "maintenance"),
      RatingItemModel(key: "personalHygiene"),
      RatingItemModel(key: "workflowDivision"),
    ],

    "smokedMeatProcessing": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "tools"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "maintenance"),
      RatingItemModel(key: "personalHygiene"),
      RatingItemModel(key: "workflowDivision"),
    ],

    "fishProcessing": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "tools"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "maintenance"),
      RatingItemModel(key: "personalHygiene"),
      RatingItemModel(key: "workflowDivision"),
    ],
  };


  List<RatingItemModel> getCurrentQuestions() {
    return zoneQuestions[selectedZone] ?? [];
  }

  List<ZoneReport> finalReports = [];

  bool isLoading = false;

  Future<void> generateFinalReport() async {
    isLoading = true;
    emit(ReportLoadingState());

    await Future.delayed(const Duration(seconds: 2));

    if (masterReport.zones.isEmpty) {
      isLoading = false; // 🔥 مهم
      emit(ReportErrorState("لا يوجد بيانات"));
      return;
    }

    isLoading = false;
    emit(ReportSuccessState());
  }

  String factoryName = "";
  DateTime reportDate = DateTime.now();
  String generalNotes = "";

  void setReportInfo({
    required String name,
    required DateTime date,
    required String notes,
  }) {
    factoryName = name;
    reportDate = date;
    generalNotes = notes;

    masterReport = masterReport.copyWith(
      factoryName: name,
      date: date,
      generalNotes: notes,
    );

    emit(ReportUpdated());
  }

  MasterReport masterReport = MasterReport(
    factoryName: "",
    date: DateTime.now(), // ✅ الحل هنا
    zones: [],
    generalNotes: '',

  );


  void addZoneReport(ZoneReport report) {
    final updatedZones = List<ZoneReport>.from(masterReport.zones);

    updatedZones.removeWhere((e) => e.title == report.title);
    updatedZones.add(report);

    masterReport = masterReport.copyWith(zones: updatedZones);

    emit(ReportUpdated());
  }

  Future<pw.Font> loadFont() async {
    final fontData = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    return pw.Font.ttf(fontData);
  }

  Future<void> generatePdf(BuildContext context) async {
    final report = masterReport;
    final pdf = pw.Document();
    final font = await loadFont();

    final t = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(base: font),
        build: (context) => [
          pw.Directionality(
            textDirection: isArabic ? pw.TextDirection.rtl : pw.TextDirection.ltr,
            child: pw.Column(
              crossAxisAlignment: isArabic
                  ? pw.CrossAxisAlignment.start
                  : pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [

                // ================= HEADER =================
                pw.Text(
                    t.showFinalReport,
                    style: pw.TextStyle(fontSize: 24),
                  textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left,
                ),

                pw.SizedBox(height: 10),

                pw.Text("${t.place_name}: ${report.factoryName}",textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left,),
                pw.Text("${t.report_date}: ${report.date.toString().split(' ')[0]}",textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left,),

                pw.SizedBox(height: 10),

                pw.Text(
                  "${t.generalEvaluation}: ${(report.totalAverage * 10).toStringAsFixed(0)}%",
                  textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left,

                ),

                pw.Divider(),

                // ================= ZONES =================
                ...report.zones.map((zone) {
                  final avg = zone.average;
                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [

                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,

                          children: [

                          pw.Text(
                            t.translate(zone.title),
                            style: pw.TextStyle(fontSize: 18),
                            textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left,
                          ),

                          pw.Text(
                            avg.toStringAsFixed(1),
                            style: pw.TextStyle(fontSize: 18),
                            textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left,
                          ),

                        ]
                      ),


                      pw.SizedBox(height: 5),

                      ...zone.ratings.entries.map((e) {
                        return pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            // 🔥 ترجمة السؤال
                            pw.Text(t.translate(e.key),textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left,),
                            pw.Text(e.value.toStringAsFixed(1),textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left,),

                          ],
                        );
                      }),
                      if (zone.notes.isNotEmpty)
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 6),
                          child: pw.Text(
                            "${t.notes}: ${zone.notes}",
                            style: pw.TextStyle(fontSize: 12),
                            textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left,
                          ),
                        ),


                      pw.SizedBox(height: 10),
                      pw.Divider(),
                    ],
                  );
                }),

                if (report.generalNotes.isNotEmpty)
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 5),
                    child: pw.Text("${t.general_notes}  :  ${report.generalNotes}",textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left,),
                  ),

                pw.SizedBox(height: 10),
                pw.Divider(),
                // ================= GENERAL NOTES =================
                // if (report.generalNotes.isNotEmpty)
                //   pw.Column(
                //     //crossAxisAlignment: pw.CrossAxisAlignment.start,
                //     children: [
                //       pw.Text('notes',textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left,),
                //       pw.Text(report.generalNotes,textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left,),
                //     ],
                //   ),
              ],
            ),
          ),
        ],
      ),
    );
    final bytes = await pdf.save();
    if (Platform.isAndroid || Platform.isIOS) {
      // ✅ موبايل حقيقي
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/report_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(bytes);
      await OpenFilex.open(file.path);
    } else {
      // ✅ إميلاتور أو Desktop
      await Printing.layoutPdf(
        onLayout: (format) async => bytes,
      );}
  }

  void resetReport() {
    masterReport = MasterReport(
      factoryName: "",
      date: DateTime.now(),
      zones: [],
      generalNotes: "",
    );

    emit(ReportUpdated());
  }
  Future<void> saveReportLocally() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = jsonEncode(masterReport.toJson());

    await prefs.setString("saved_report", jsonString);
  }
  Future<void> loadReport() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString("saved_report");

    if (jsonString != null) {
      masterReport = MasterReport.fromJson(jsonDecode(jsonString));
      emit(ReportUpdated());
    }
  }
}