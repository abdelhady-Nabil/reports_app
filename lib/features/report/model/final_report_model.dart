import 'report_model.dart';

class FinalReportModel {
  final String factoryName;
  final double average;

  // كل الأقسام + متوسط كل قسم
  final Map<String, double> sectionAverages;

  // كل التقارير جوه كل قسم
  final Map<String, List<ReportModel>> sectionReports;

  FinalReportModel({
    required this.factoryName,
    required this.average,
    required this.sectionAverages,
    required this.sectionReports,
  });
}