import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reports_app/features/butcher_shops/view/storage_zone_screen.dart';
import 'package:reports_app/features/factories/view/reciveing_zone_screen.dart';
import 'package:reports_app/features/factories/view/storage_factory_zone_screen.dart';
import 'package:reports_app/features/start_screen/view/start_screen.dart';

import '../../../core/utils/responsive.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_menu_card.dart';
import '../../report/model/report_category_model.dart';
import '../../report/view/create_report_screen.dart';
import '../../report/view/final_report_screen.dart';
import '../../report/view/report_info_screen.dart';
import '../../report/view_model/cubit/report_cubit.dart';
import '../../report/view_model/cubit/report_states.dart';
import 'opreation_factory_zone_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class FactoriesReportScreen extends StatelessWidget {
  const FactoriesReportScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xff0D0D0D),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:  Text(t.factories,style: TextStyle(
        ),),
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StartScreen()));
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// MENU
              AppMenuCard(
                title: t.receivingAreaExtended,
                icon: 'Receiving_Area.png',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ReceivingZoneScreen()));
                },
              ),

              AppMenuCard(
                title: t.operationArea,
                icon: 'Operation Area.png',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OperationFactoryZoneScreen()));

                },
              ),
              AppMenuCard(
                title: t.storageArea,
                icon: 'Storage_Area.png',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StorageFactoryZoneScreen()));
                },
              ),

              AppMenuCard(
                title: t.staffRestArea,
                icon: 'restroom.png',
                onTap: () {
                  ReportCubit.get(context).selectedZone = "staffRestArea";
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

              // AppMenuCard(
              //   title: t.add_report_info,
              //   icon: 'add_shope.png',
              //   onTap: () {
              //     ReportCubit.get(context).selectedZone = "salesArea";
              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportInfoScreen()));
              //
              //   },
              // ),

              SizedBox(
                height: 100,
              ),

              BlocConsumer<ReportCubit, ReportStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  final cubit = ReportCubit.get(context);

                  return AppPrimaryButton(
                    text: t.showFinalReport,
                    isLoading: cubit.isLoading,
                      onTap: () async {
                        await cubit.generateFinalReport();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const FinalReportScreen(),
                          ),
                        );
                      }
                  );
                },
              )  ,
              SizedBox(
                height: 20,
              ),

            ],
          ),
        ),
      ),
    );
  }
}