import 'package:flutter/material.dart';
import 'package:reports_app/features/report/model/zone_report.dart';

class MasterReport {
  final String factoryName;
  final DateTime date;
  final List<ZoneReport> zones;
  final String generalNotes;
  final String address;
  final String inspectorName;
  final String escortName;
  final String jobTitle;
  final String officialDocument;
  final TimeOfDay? reportTime;

  MasterReport({
    required this.factoryName,
    required this.date,
    required this.zones,
    required this.generalNotes,
    required this.address,
    required this.inspectorName,
    required this.escortName,
    required this.jobTitle,
    required this.officialDocument,

    this.reportTime,
  });

  MasterReport copyWith({
    String? factoryName,
    DateTime? date,
    List<ZoneReport>? zones,
    String? generalNotes,
    String? address,
    TimeOfDay? reportTime,
    String? inspectorName,
    String? escortName,
    String? jobTitle,
    String? officialDocument,
  }) {
    return MasterReport(
      factoryName: factoryName ?? this.factoryName,
      date: date ?? this.date,
      zones: zones ?? this.zones,
      generalNotes: generalNotes ?? this.generalNotes,
      address: address ?? this.address,
      reportTime: reportTime ?? this.reportTime,

      inspectorName: inspectorName ?? this.inspectorName,
      escortName: escortName ?? this.escortName,
      jobTitle: jobTitle ?? this.jobTitle,
      officialDocument: officialDocument ?? this.officialDocument,

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
      "address": address,
      "inspectorName": inspectorName,
      "escortName": escortName,
      "jobTitle": jobTitle,
      "officialDocument": officialDocument,

      "reportTime": reportTime != null
          ? "${reportTime!.hour}:${reportTime!.minute}"
          : null,
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
      address: json["address"] ?? '',
      inspectorName: json["inspectorName"] ?? '',
      escortName: json["escortName"] ?? '',
      jobTitle: json["jobTitle"] ?? '',
      officialDocument: json["officialDocument"] ?? '',
      reportTime: json["reportTime"] != null
          ? TimeOfDay(
        hour: int.parse(json["reportTime"].split(":")[0]),
        minute: int.parse(json["reportTime"].split(":")[1]),
      )
          : null,
    );
  }
}