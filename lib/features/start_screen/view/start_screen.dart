import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/responsive.dart';
import '../../../core/widgets/app_menu_card.dart';
import '../../../core/widgets/text_wedget.dart';
import '../../../cubit/app_cubit.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../cubit/app_states.dart';
import '../../butcher_shops/view/butcher_shops_report_screen.dart';
import '../../report/view_model/cubit/report_cubit.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    ReportCubit.get(context).loadReport();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xff0D0D0D),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [

                BlocConsumer<AppCubit, AppStates>(
                  listener: (context, state) {
                  },
                  builder: (context, state) {

                    final cubit = AppCubit.get(context);

                    return InkWell(
                      onTap: cubit.changeLocale,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.language, color: Colors.white),
                            const SizedBox(width: 6),

                            Text(
                              cubit.locale.languageCode == 'ar'
                                  ? "العربية"
                                  : "English",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                /// LOGO
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.08),
                    border: Border.all(color: Colors.red.withOpacity(0.3)),
                  ),
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: Responsive.isTablet(context) ? 280 : 200,
                  ),
                ),

                const SizedBox(height: 20),

                AppText(title: t.appTitle),

                const SizedBox(height: 40),

                /// MENU
                AppMenuCard(
                  title: t.slaughterhouses,
                  icon: 'shopes.png',
                  onTap: () {},
                ),

                AppMenuCard(
                  title: t.factories,
                  icon: 'factory.png',
                  onTap: () {},
                ),

                AppMenuCard(
                  title: t.butcherShops,
                  icon: 'shope.png',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ButcherShopsReportScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}