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

        //factory
      case "meatFProcessing":
        return meatProcessing;

      case "poultryFProcessing":
        return poultryProcessing;

      case "manufacturingFProcessing":
        return manufacturingProcessing;

      case "smokedMeatFProcessing":
        return smokedMeatProcessing;

      case "fishFProcessing":
        return fishProcessing;

      case "productInformation":
        return productInformation;

      case "receivingAreaExtended":
        return receivingAreaExtended;

      case "staffRestArea":
        return staffRestArea;

      case "packagingArea":
        return packagingArea;

      case "toolsEquipmentCondition":
        return toolsEquipmentCondition;

      case "storageOrganization":
        return storageOrganization;

      case "generalCondition":
        return generalCondition;

      case "organizationData":
        return organizationData;

      case "smokingArea":
        return smokingArea;
      case "tables":
        return tables;
      case "chairs":
        return chairs;
      case "lockers":
        return lockers;
      case "photos":
        return photos;


      case "notes":
        return notes;
      case "areaOrganization":
        return areaOrganization;
      case "colorCoding":
        return colorCoding;
      case "productDelivery":
        return productDelivery;
      case "operationalDocsCycle":
        return operationalDocsCycle;
    // ================= FACTORY Storage ZONES (NEW) =================
      case "rawMaterialsStorageZone":
        return rawMaterialsStorageZone;

      case "finishedProductStorageZone":
        return finishedProductStorageZone;

      case "packagingMaterialsStorageZone":
        return packagingMaterialsStorageZone;

      case "spicesStorageZone":
        return spicesStorageZone;

      case "cleaningAndSanitizingMaterialsStorageZone":
        return cleaningAndSanitizingMaterialsStorageZone;


        //slaughterhouse

      case "veterinaryVisualInspectionArea":
        return veterinaryVisualInspectionArea;

      case "restAndQuarantineArea":
        return restAndQuarantineArea;

      case "internalVeterinaryInspectionArea":
        return internalVeterinaryInspectionArea;

      case "meatWashingAndSanitizationCorridor":
        return meatWashingAndSanitizationCorridor;

      case "rapidCoolingCorridor":
        return rapidCoolingCorridor;

      case "waxingArea":
        return waxingArea;

      case "rawDeliveryArea":
        return rawDeliveryArea;

      case "deboningAndCuttingArea":
        return deboningAndCuttingArea;

      case "packagingArea":
        return packagingArea;

      case "slaughterBarrel":
        return slaughterBarrel;

      case "bleedingArea":
        return bleedingArea;

      case "skinningArea":
        return skinningArea;

      case "eviscerationArea":
        return eviscerationArea;

      case "splittingArea":
        return splittingArea;
      case "name":
        return name;

      case "address":
        return address;

      case "date":
        return date;

      case "time":
        return time;

      case "inspectorName":
        return inspectorName;

      case "escortName":
        return escortName;

      case "jobTitle":
        return jobTitle;

      case "officialDocument":
        return officialDocument;

      case "notes":
        return notes;


      default:
        return key;
    }
  }
}