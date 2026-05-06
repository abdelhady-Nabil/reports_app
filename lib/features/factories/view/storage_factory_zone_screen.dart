import 'package:flutter/material.dart';
import 'package:reports_app/features/butcher_shops/view/storage_zone_screen.dart';

import '../../../core/widgets/app_menu_card.dart';
import '../../report/model/report_category_model.dart';
import '../../report/view/create_report_screen.dart';
import '../../report/view_model/cubit/report_cubit.dart';
import 'opreation_factory_zone_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class StorageFactoryZoneScreen extends StatelessWidget {
  const StorageFactoryZoneScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xff0D0D0D),
      appBar: AppBar(

        backgroundColor: Colors.black,
        title:  Text(t.storageArea,style: TextStyle(

        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// MENU
              AppMenuCard(
                title: t.rawMaterialsStorageZone,
                icon: 'Raw Meat Storage.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "rawMaterialsStorageZone";
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReportScreen()));

                },
              ),

              AppMenuCard(
                title: t.finishedProductStorageZone,
                icon: 'finishedProduct.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "finishedProductStorageZone";
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReportScreen()));

                },
              ),

              AppMenuCard(
                title: t.packagingMaterialsStorageZone,
                icon: 'Packaging Materials.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "packagingMaterialsStorageZone";
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReportScreen()));

                },
              ),
              AppMenuCard(
                title: t.spicesStorageZone,
                icon: 'Spices Storage.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "spicesStorageZone";
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReportScreen()));

                },
              ),
              AppMenuCard(
                title: t.cleaningAndSanitizingMaterialsStorageZone,
                icon: 'Sanitization Materials.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "cleaningAndSanitizingMaterialsStorageZone";
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReportScreen()));

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}