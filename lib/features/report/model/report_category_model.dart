enum ReportCategory {
  reception,
  storage,
  operation,
  sales,
}
extension ReportCategoryX on ReportCategory {
  String get title {
    switch (this) {
      case ReportCategory.reception:
        return "منطقة الاستلام";
      case ReportCategory.storage:
        return "منطقة التخزين";
      case ReportCategory.operation:
        return "منطقة التشغيل";
      case ReportCategory.sales:
        return "منطقة البيع";
    }
  }
}