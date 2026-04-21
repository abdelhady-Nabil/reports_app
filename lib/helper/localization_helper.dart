import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocalizationHelper on AppLocalizations {
  String translate(String key) {
    switch (key) {
      case "temperature":
        return temperature;

      case "pestControl":
        return pestControl;

      case "tools":
        return tools;

      case "cleanliness":
        return cleanliness;

      case "maintenance":
        return maintenance;

      case "personalHygiene":
        return personalHygiene;

      case "cashierArea":
        return cashierArea;

      case "drainage":
        return drainage;

      case "customerService":
        return customerService;

      case "ventilation":
        return ventilation;

    // ================= ZONES =================
      case "receivingArea":
        return receivingArea;

      case "salesArea":
        return salesArea;

      case "rawMeatStorage":
        return rawMeatStorage;

      case "spicesStorage":
        return spicesStorage;

      case "packagingMaterials":
        return packagingMaterials;

      case "sanitizationMaterials":
        return sanitizationMaterials;
      case "workflowDivision":
        return workflowDivision;

      case "meatProcessing":
        return meatProcessing;

      case "poultryProcessing":
        return poultryProcessing;

      case "manufacturingProcessing":
        return manufacturingProcessing;

      case "smokedMeatProcessing":
        return smokedMeatProcessing;

      case "fishProcessing":
        return fishProcessing;

      default:
        return key;
    }
  }
}