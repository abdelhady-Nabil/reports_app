import 'package:flutter/material.dart';
import 'package:reports_app/features/butcher_shops/view/storage_zone_screen.dart';

import '../../../core/widgets/app_menu_card.dart';
import '../../report/model/report_category_model.dart';
import '../../report/view/create_report_screen.dart';
import '../../report/view_model/cubit/report_cubit.dart';
import 'opreation_selughterhpouse_zone_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OperationSlaughterhouseZoneScreen extends StatelessWidget {
  const OperationSlaughterhouseZoneScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xff0D0D0D),
      appBar: AppBar(

        backgroundColor: Colors.black,
        title:  Text(t.operationArea,style: TextStyle(

        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// MENU
              AppMenuCard(
                title: t.slaughterBarrel,
                icon: 'Meat Processing.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "slaughterBarrel";
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReportScreen()));

                },
              ),

              AppMenuCard(
                title: t.bleedingArea,
                icon: 'bleedingArea.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "bleedingArea";
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReportScreen()));

                },
              ),

              AppMenuCard(
                title: t.skinningArea,
                icon: 'veterinaryVisualInspectionArea.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "skinningArea";
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReportScreen()));

                },
              ),
              AppMenuCard(
                title: t.eviscerationArea,
                icon: 'eviscerationArea.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "eviscerationArea";
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReportScreen()));

                },
              ),
              AppMenuCard(
                title: t.splittingArea,
                icon: 'splittingArea.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "splittingArea";
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReportScreen()));
                },
              ),

              AppMenuCard(
                title: t.meatWashingAndSanitizationCorridor,
                icon: 'meatWashingAndSanitizationCorridor.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "meatWashingAndSanitizationCorridor";
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReportScreen()));

                },
              ),
              AppMenuCard(
                title: t.rapidCoolingCorridor,
                icon: 'rapidCoolingCorridor.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "rapidCoolingCorridor";
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReportScreen()));

                },
              ),
              AppMenuCard(
                title: t.waxingArea,
                icon: 'waxingArea.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "waxingArea";
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReportScreen()));

                },
              ),
              AppMenuCard(
                title: t.deboningAndCuttingArea,
                icon: 'deboningAndCuttingArea.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "deboningAndCuttingArea";
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReportScreen()));

                },
              ),
              AppMenuCard(
                title: t.packagingArea,
                icon: 'Packaging Materials.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "packagingArea";
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