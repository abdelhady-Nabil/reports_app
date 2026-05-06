class ZoneReport {
  final String title;
  final Map<String, double> ratings;
  final String notes;
  final List<String> images; // paths


  ZoneReport({
    required this.title,
    required this.ratings,
    required this.notes,
    required this.images,

  });

  /// 🔥 average
  double get average {
    if (ratings.isEmpty) return 0;
    return ratings.values.reduce((a, b) => a + b) / ratings.length;
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "ratings": ratings,
      "notes": notes,
      "images": images,
    };
  }

  // 🔥 استرجاع
  factory ZoneReport.fromJson(Map<String, dynamic> json) {
    return ZoneReport(
      title: json["title"],
      ratings: Map<String, double>.from(json["ratings"]),
      notes: json["notes"],
      images: List<String>.from(json["images"] ?? []),
    );
  }
}