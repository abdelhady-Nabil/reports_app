import 'package:reports_app/features/report/model/report_category_model.dart';

class ReportModel {
  final String title;

  final String factoryName;
  final DateTime date;
  final Map<String, double> ratings;
  final String notes;
   ReportCategory? category;

  ReportModel({
    required this.title,

    required this.factoryName,
    required this.date,
    required this.ratings,
    required this.notes,
     this.category,
  });

  double get average {
    if (ratings.isEmpty) return 0;
    return ratings.values.reduce((a, b) => a + b) / ratings.length;
  }
}