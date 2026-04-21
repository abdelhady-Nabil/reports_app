class ZoneReport {
  final String title;
  final Map<String, double> ratings;
  final String notes;

  ZoneReport({
    required this.title,
    required this.ratings,
    required this.notes,
  });

  /// 🔥 average
  double get average {
    if (ratings.isEmpty) return 0;
    return ratings.values.reduce((a, b) => a + b) / ratings.length;
  }

  /// 🔥 toJson
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "ratings": ratings,
      "notes": notes,
    };
  }

  /// 🔥 fromJson
  factory ZoneReport.fromJson(Map<String, dynamic> json) {
    return ZoneReport(
      title: json["title"],

      /// ⚠️ دي أهم نقطة
      ratings: Map<String, double>.from(
        (json["ratings"] as Map).map(
              (key, value) => MapEntry(key, (value as num).toDouble()),
        ),
      ),

      notes: json["notes"],
    );
  }
}