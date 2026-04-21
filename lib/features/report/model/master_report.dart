import 'package:reports_app/features/report/model/zone_report.dart';

class MasterReport {
  final String factoryName;
  final DateTime date;
  final List<ZoneReport> zones;
  final String generalNotes;

  MasterReport({
    required this.factoryName,
    required this.date,
    required this.zones,
    required this.generalNotes,
  });

  MasterReport copyWith({
    String? factoryName,
    DateTime? date,
    List<ZoneReport>? zones,
    String? generalNotes,
  }) {
    return MasterReport(
      factoryName: factoryName ?? this.factoryName,
      date: date ?? this.date,
      zones: zones ?? this.zones,
      generalNotes: generalNotes ?? this.generalNotes,
    );
  }


  double get totalAverage {
    if (zones.isEmpty) return 0;
    return zones.map((e) => e.average).reduce((a, b) => a + b) / zones.length;
  }

  Map<String, dynamic> toJson() {
    return {
      "factoryName": factoryName,
      "date": date.toIso8601String(),
      "generalNotes": generalNotes,
      "zones": zones.map((e) => e.toJson()).toList(),
    };
  }

  factory MasterReport.fromJson(Map<String, dynamic> json) {
    return MasterReport(
      factoryName: json["factoryName"],
      date: DateTime.parse(json["date"]),
      generalNotes: json["generalNotes"],
      zones: (json["zones"] as List)
          .map((e) => ZoneReport.fromJson(e))
          .toList(),
    );
  }
}