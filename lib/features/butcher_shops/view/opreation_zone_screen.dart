import 'package:flutter/material.dart';
import 'package:reports_app/features/butcher_shops/view/storage_zone_screen.dart';

import '../../../core/widgets/app_menu_card.dart';
import '../../report/model/report_category_model.dart';
import '../../report/view/create_report_screen.dart';
import '../../report/view_model/cubit/report_cubit.dart';
import 'opreation_zone_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OperationZoneScreen extends StatelessWidget {
  const OperationZoneScreen({super.key});

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
                title: t.meatProcessing,
                icon: 'Meat Processing.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "meatProcessing";
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReportScreen()));

                },
              ),

              AppMenuCard(
                title: t.poultryProcessing,
                icon: 'Poultry Processing.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "poultryProcessing";
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReportScreen()));

                },
              ),

              AppMenuCard(
                title: t.manufacturingProcessing,
                icon: 'Processed Foods.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "manufacturingProcessing";
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReportScreen()));

                },
              ),
              AppMenuCard(
                title: t.smokedMeatProcessing,
                icon: 'Smoked Meat Processing.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "smokedMeatProcessing";
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReportScreen()));

                },
              ),
              AppMenuCard(
                title: t.fishProcessing,
                icon: 'Fish Processing.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "fishProcessing";
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