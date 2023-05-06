import 'package:agri_hack/models/measures.dart';
import 'package:agri_hack/screens/home_screen.dart';
import 'package:agri_hack/services/blynk_services.dart';
import 'package:agri_hack/widgets/discover_card.dart';
import 'package:agri_hack/widgets/discover_small_card.dart';
import 'package:agri_hack/widgets/icons.dart';
import 'package:agri_hack/widgets/svg_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenScan extends StatefulWidget {
  const ScreenScan({super.key});

  @override
  State<ScreenScan> createState() => _ScreenScanState();
}

class _ScreenScanState extends State<ScreenScan> {
  Measures _measures = Measures();
  bool _isLoading = false;

  @override
  initState() {
    super.initState();
    _refresh();
  }

  _refresh() async {
    print("Starting refresh");
    setState(() {
      _isLoading = true;
    });
    final valuesNew = await BlynkServices.getValues();

    setState(() {
      _measures.temperature = valuesNew.measures.temperature;
      _measures.CO = valuesNew.measures.CO;

      _isLoading = false;
    });
  }

  _refreshSingle(int pin) async {
    final valuesNew = await BlynkServices.getSingleValue(pin);
    setState(() {
      switch (pin) {
        case 0:
          _measures.temperature = valuesNew[1];
          break;
        case 1:
          _measures.CO = valuesNew[1];
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      //backgroundColor: Color.fromARGB(255, 7, 36, 6),
      //backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff121421),
      ),
      body: SafeArea(
          child: !_isLoading
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 28.w,
                        ),
                        child: Text("Air Quality Test",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 32.w,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 30.w,
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28.w),
                        child: SizedBox(
                          width: 500.w,
                          child: ElevatedButton(
                            onPressed: () {
                              _refresh();
                            },
                            child: Text(AppLocalizations.of(context)!.sa),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28.w),
                        child: Center(
                          child: GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 19.w,
                                    mainAxisExtent: 125.w,
                                    mainAxisSpacing: 19.w),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              DiscoverSmallCard(
                                onTap: () {
                                  _refreshSingle(3);
                                },
                                title: "Temperature",
                                subtitle: "${_measures.temperature}",
                                gradientStartColor: const Color(0xff13DEA0),
                                gradientEndColor: const Color(0xff06B782),
                              ),
                              DiscoverSmallCard(
                                onTap: () {
                                  _refreshSingle(4);
                                },
                                title: "CO",
                                subtitle: "${_measures.CO}",
                                gradientStartColor: const Color(0xffFC67A7),
                                gradientEndColor: const Color(0xffF6815B),
                                icon: SvgAsset(
                                  assetName: AssetName.tape,
                                  height: 24.w,
                                  width: 24.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator())),
    );
  }
}
