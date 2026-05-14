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

    "productDelivery": [
      RatingItemModel(key: "areaOrganization"),
      RatingItemModel(key: "colorCoding"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "cleanliness"),
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

    //shops
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

    //factory
    // ================= STORAGE =================
    "rawMaterialsStorageZone": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "toolsEquipmentCondition"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "ventilation"),
    ],

    "finishedProductStorageZone": [
      RatingItemModel(key: "productInformation"),
      RatingItemModel(key: "colorCoding"),
      RatingItemModel(key: "storageOrganization"),
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "generalCondition"),
    ],

    "packagingMaterialsStorageZone": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "organizationData"),

    ],

    "spicesStorageZone": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "organizationData"),
      RatingItemModel(key: "cleanliness"),

    ],

    "cleaningAndSanitizingMaterialsStorageZone": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "organizationData"),
      RatingItemModel(key: "cleanliness"),
    ],

    "staffRestArea": [
      RatingItemModel(key: "tables"),
      RatingItemModel(key: "chairs"),
      RatingItemModel(key: "lockers"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "ventilation"),
      RatingItemModel(key: "smokingArea"),
    ],
    "packagingArea": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "toolsEquipmentCondition"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "personalHygiene"),
    ],

    // ================= OPERATION =================
    "meatFProcessing": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "tools"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "operationalDocsCycle"),
      RatingItemModel(key: "personalHygiene"),
      RatingItemModel(key: "workflowDivision"),
    ],

    "poultryFProcessing": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "tools"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "operationalDocsCycle"),
      RatingItemModel(key: "personalHygiene"),
      RatingItemModel(key: "workflowDivision"),
    ],

    "manufacturingFProcessing": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "tools"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "operationalDocsCycle"),
      RatingItemModel(key: "personalHygiene"),
      RatingItemModel(key: "workflowDivision"),
    ],

    "smokedMeatFProcessing": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "tools"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "operationalDocsCycle"),
      RatingItemModel(key: "personalHygiene"),
      RatingItemModel(key: "workflowDivision"),
    ],

    "fishFProcessing": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "tools"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "operationalDocsCycle"),
      RatingItemModel(key: "personalHygiene"),
      RatingItemModel(key: "workflowDivision"),
    ],

    //slaughterhouse
    "veterinaryVisualInspectionArea": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "toolsEquipmentCondition"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "ventilation"),
    ],

    "restAndQuarantineArea": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "toolsEquipmentCondition"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "personalHygiene"),
    ],
    //operation slaughterhouse
    "slaughterBarrel": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "toolsEquipmentCondition"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "personalHygiene"),
    ],
    "bleedingArea": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "toolsEquipmentCondition"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "personalHygiene"),
    ],
    "skinningArea": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "toolsEquipmentCondition"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "personalHygiene"),
    ],
    "eviscerationArea": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "toolsEquipmentCondition"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "personalHygiene"),
    ],
    "splittingArea": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "toolsEquipmentCondition"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "personalHygiene"),
    ],


    "internalVeterinaryInspectionArea": [
      RatingItemModel(key: "personalHygiene"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "toolsEquipmentCondition"),
    ],

    "meatWashingAndSanitizationCorridor": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "toolsEquipmentCondition"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "personalHygiene"),
    ],

    "rapidCoolingCorridor": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "organizationData"),
    ],

    "waxingArea": [
      RatingItemModel(key: "areaOrganization"),
      RatingItemModel(key: "colorCoding"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "personalHygiene"),
    ],

    "rawDeliveryArea": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "organizationData"),
      RatingItemModel(key: "cleanliness"),
    ],

    "deboningAndCuttingArea": [
      RatingItemModel(key: "temperature"),
      RatingItemModel(key: "pestControl"),
      RatingItemModel(key: "toolsEquipmentCondition"),
      RatingItemModel(key: "cleanliness"),
      RatingItemModel(key: "personalHygiene"),
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
    required String address,
    required String phone,

    required TimeOfDay time,
    required String inspectorName,
    required String escortName,
    required String jobTitle,
    required String officialDocument,
  }) {
    factoryName = name;
    reportDate = date;
    generalNotes = notes;

    masterReport = masterReport.copyWith(
      factoryName: name,
      date: date,
      generalNotes: notes,
      address: address,
      phone: phone,

      reportTime: time,

      inspectorName: inspectorName,
      escortName: escortName,
      jobTitle: jobTitle,
      officialDocument: officialDocument,

    );

    emit(ReportUpdated());
  }

  MasterReport masterReport = MasterReport(
    factoryName: "",
    date: DateTime.now(), // ✅ الحل هنا
    zones: [],
    generalNotes: '',
    address: '',
    phone: '',
    inspectorName: '',
    escortName: '',
    jobTitle: '',
    officialDocument: '',
    reportTime: null,


  );


  void addZoneReport(ZoneReport report) {
    final updatedZones = List<ZoneReport>.from(masterReport.zones);

    updatedZones.removeWhere((e) => e.title == report.title);
    updatedZones.add(report);

    masterReport = masterReport.copyWith(zones: updatedZones);

    emit(ReportUpdated());
  }

  Future<pw.Font> loadFont() async {
    final fontData = await rootBundle.load("assets/fonts/Amiri-Bold.ttf");
    return pw.Font.ttf(fontData);
  }

  Future<void> generatePdf(BuildContext context) async {
    final report = masterReport;
    final pdf = pw.Document();
    final font = await loadFont();
    /// ================= LOAD LOGO =================

    final logo = pw.MemoryImage(
      (await rootBundle.load('assets/images/logo2.png'))
          .buffer
          .asUint8List(),
    );

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

                /// LOGO
                pw.Center(
                  child: pw.Image(
                    logo,
                    width: 120,
                    height: 120,
                  ),
                ),

                pw.SizedBox(height: 15),

                // ================= HEADER =================
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children:
                    [
                      pw.Text(
                        t.showFinalReport,
                        style: pw.TextStyle(fontSize: 24),
                        textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left,
                      ),
                    ]
                ),


                pw.SizedBox(height: 10),

                // ================= HEADER =================
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [

                    pw.SizedBox(height: 24),

                    /// NAME
                    pw.Text(
                      "${t.name} : ${report.factoryName}",
                      style: pw.TextStyle(fontSize: 24),
                    ),

                    pw.SizedBox(height: 8),

                    /// ADDRESS
                    pw.Text(
                      "${t.address} : ${report.address}",
                      style: pw.TextStyle(fontSize: 24),
                    ),

                    pw.SizedBox(height: 8),
                    /// ADDRESS
                    pw.Text(
                      "${t.mobileNumber} : ${report.phone}",
                      style: pw.TextStyle(fontSize: 24),
                    ),

                    pw.SizedBox(height: 8),

                    /// DATE
                    pw.Text(
                      "${t.date} : ${report.date.toString().split(' ')[0]}",
                      style: pw.TextStyle(fontSize: 24),
                    ),

                    pw.SizedBox(height: 8),

                    pw.Text(
                      "${t.time} : ${report.reportTime!.hour % 12 == 0 ? 12 : report.reportTime!.hour % 12}:${report.reportTime?.minute.toString().padLeft(2, '0')}",
                      style: pw.TextStyle(fontSize: 24),
                    ),

                    pw.SizedBox(height: 8),

                    /// INSPECTOR
                    pw.Text(
                      "${t.inspectorName} : ${report.inspectorName}",
                      style: pw.TextStyle(fontSize: 24),
                    ),

                    pw.SizedBox(height: 8),

                    /// ESCORT
                    pw.Text(
                      "${t.escortName} : ${report.escortName}",
                      style: pw.TextStyle(fontSize: 24),
                    ),

                    pw.SizedBox(height: 8),

                    /// JOB TITLE
                    pw.Text(
                      "${t.jobTitle} : ${t.translate(report.jobTitle)}",
                      style: pw.TextStyle(fontSize: 24),
                    ),

                    pw.SizedBox(height: 8),

                    /// OFFICIAL DOCUMENT
                    pw.Text(
                      "${t.officialDocument} : ${report.officialDocument}",
                      style: pw.TextStyle(fontSize: 24),
                    ),

                    pw.SizedBox(height: 15),

                    /// GENERAL EVALUATION
                    pw.Text( "${t.generalEvaluation} : ${(report.totalAverage * 10).toStringAsFixed(0)}%", textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left, style: pw.TextStyle(fontSize:24), ),
                  ],
                ),

                pw.SizedBox(height: 20),

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
                            style: pw.TextStyle(fontSize: 24),
                            textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left,
                          ),

                          pw.Text(
                            avg.toStringAsFixed(1),
                            style: pw.TextStyle(fontSize: 24),
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
                            pw.Text(t.translate(e.key),style: pw.TextStyle(fontSize: 22),
                              textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left,),
                            pw.Text(e.value.toStringAsFixed(1),style: pw.TextStyle(fontSize: 22),
                              textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left,),

                          ],
                        );
                      }),
                      if (zone.notes.isNotEmpty)
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 6),
                          child: pw.Text(
                            "${t.notes}: ${zone.notes}",
                            style: pw.TextStyle(fontSize: 22),
                            textAlign: isArabic ? pw.TextAlign.right : pw.TextAlign.left,
                          ),
                        ),


                      pw.SizedBox(height: 10),
                      if (zone.images.isNotEmpty)
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                            pw.Text("${t.photos}",),
                            pw.SizedBox(height: 10),
                            pw.Wrap(
                              spacing: 10,
                              children: zone.images.map((path) {
                                final image = pw.MemoryImage(File(path).readAsBytesSync());

                                return pw.Image(image, width: 200, height: 200);
                              }).toList(),
                            ),
                          ]
                        ),

                      pw.SizedBox(height: 10),
                      pw.Divider(),
                    ],
                  );
                }),
                pw.SizedBox(height: 25),

                /// ================= ANALYTICS CHART =================

                pw.Container(
                  padding: const pw.EdgeInsets.all(20),

                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      color: PdfColors.grey300,
                    ),

                    borderRadius: pw.BorderRadius.circular(16),
                  ),

                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,

                    children: [

                      pw.Text(
                        "${t.generalEvaluation}",
                        style: pw.TextStyle(
                          fontSize: 22,
                          fontWeight: pw.FontWeight.bold,
                          font: font
                        ),
                      ),

                      pw.SizedBox(height: 25),

                      pw.Container(
                        height: 320,

                        child: pw.Chart(

                          grid: pw.CartesianGrid(

                            xAxis: pw.FixedAxis.fromStrings(

                              List.generate(
                                report.zones.length,
                                    (index) {

                                  /// كل كلمة تحت التانية
                                  return t
                                      .translate(report.zones[index].title)
                                      .replaceAll(' ', '\n');
                                },
                              ),

                              marginStart: 30,
                              marginEnd: 30,
                              ticks: true,
                            ),

                            yAxis: pw.FixedAxis(
                              [0, 2, 4, 6, 8, 10],
                              divisions: true,
                            ),
                          ),

                          datasets: [

                            /// ================= BAR DATA =================

                            pw.BarDataSet(

                              width: 22,

                              color: PdfColors.red,

                              data: List.generate(
                                report.zones.length,

                                    (index) {

                                  return pw.PointChartValue(
                                    index.toDouble(),
                                    report.zones[index].average,
                                  );
                                },
                              ),
                            ),

                            /// ================= LINE DATA =================

                            pw.LineDataSet(

                              isCurved: true,

                              drawSurface: false,

                              color: PdfColors.blue,

                              lineWidth: 2,

                              data: List.generate(
                                report.zones.length,

                                    (index) {

                                  return pw.PointChartValue(
                                    index.toDouble(),
                                    report.zones[index].average,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

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

  Future<void> resetReport() async {
    // 1. امسح الصور من الجهاز
    for (var zone in masterReport.zones) {
      for (var path in zone.images) {
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
        }
      }
    }

    // 2. امسح من SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("saved_report");

    // 3. صفّر الموديل
    masterReport = MasterReport(
      factoryName: "",
      date: DateTime.now(),
      zones: [],
      generalNotes: "",
      address: '',
      phone: '',

      inspectorName: '',
      escortName: '',
      jobTitle: '',
      officialDocument: '',
      reportTime: null,
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

  Future<void> deleteImages(List<String> paths) async {
    for (var path in paths) {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    }
  }

}