import 'dart:async';

import 'package:agri_hack/models/measures.dart';
import 'package:agri_hack/screens/login_screen.dart';
import 'package:agri_hack/services/auth_services.dart';
import 'package:agri_hack/services/blynk_services.dart';
import 'package:agri_hack/services/showSnackbar.dart';
import 'package:agri_hack/widgets/discover_card.dart';
import 'package:agri_hack/widgets/discover_small_card.dart';
import 'package:agri_hack/widgets/icons.dart';
import 'package:agri_hack/widgets/svg_asset.dart';
import 'package:audioplayers/audioplayers.dart';
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
  static const double TEMP_THRESHOLD = 35;
  static const double CO_THRESHOLD = 5;
  static const double SMOKE_THRESHOLD = 10000;
  static const alarmAudioPath = "sound_alarm.mp3";

  Measures _measures = Measures();

  bool _isLoggingOut = false;
  bool _isLoading = false;

  final player = AudioPlayer();

  @override
  initState() {
    super.initState();
    _refresh();
    // timer = Timer.periodic(Duration(seconds: 15), (Timer t) => _refresh());
  }

  @override
  void dispose() {
    super.dispose();
  }

  _refresh() async {
    print("Starting refresh");
    setState(() {
      _isLoading = true;
    });
    final valuesNew = await BlynkServices.getValues();

    if (!mounted) return;
    setState(() {
      _measures.temperature = valuesNew.measures.temperature;
      _measures.CO = valuesNew.measures.CO;
      _measures.smoke = valuesNew.measures.smoke;

      _isLoading = false;
    });

    bool tempTooHigh = _measures.temperature >= TEMP_THRESHOLD;
    bool coTooHigh = _measures.CO >= CO_THRESHOLD;
    bool smokeTooHigh = _measures.CO >= SMOKE_THRESHOLD;

    if (tempTooHigh || coTooHigh || smokeTooHigh) {
      await player.play(AssetSource(alarmAudioPath));
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shadowColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(32.0)),
                title: const Text(
                  "THRESHOLDS EXCEEDED",
                  style: TextStyle(color: Colors.red),
                ),
                content: SizedBox(
                  height: 80,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        tempTooHigh
                            ? Text(
                                "Temperature too high! ${_measures.temperature}° C. (Maximum $TEMP_THRESHOLD)",
                                style: const TextStyle(color: Colors.white),
                              )
                            : const SizedBox(),
                        coTooHigh
                            ? Text(
                                "CO too high! ${_measures.CO} ppm. (Maximum $CO_THRESHOLD ppm)",
                                style: const TextStyle(color: Colors.white),
                              )
                            : const SizedBox(),
                        smokeTooHigh
                            ? Text(
                                "Smoke too high! ${_measures.smoke} ppm. (Maximum $SMOKE_THRESHOLD ppm)",
                                style: const TextStyle(color: Colors.white),
                              )
                            : const SizedBox(),
                      ]),
                ),
                backgroundColor: const Color(0xff121421),
              ));
    }
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
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 28.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Vaayu 🍃",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.w,
                            fontWeight: FontWeight.bold)),
                    _isLoggingOut
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : IconButton(
                            onPressed: () async {
                              setState(() {
                                _isLoggingOut = true;
                              });
                              final res = await AuthServices().signoutUser();
                              setState(() {
                                _isLoggingOut = false;
                              });
                              if (res == "success") {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ScreenLogin()));
                              }
                            },
                            icon: const Icon(Icons.logout),
                            color: Colors.white,
                          )
                  ],
                ),
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
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: Center(
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 19.w,
                        mainAxisExtent: 125.w,
                        mainAxisSpacing: 19.w),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      DiscoverSmallCard(
                        onTap: () {
                          _refresh();
                        },
                        title: "Temperature",
                        subtitle: "${_measures.temperature}",
                        gradientStartColor: const Color(0xff13DEA0),
                        gradientEndColor: const Color(0xff06B782),
                      ),
                      DiscoverSmallCard(
                        onTap: () {
                          _refresh();
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
                      DiscoverSmallCard(
                        onTap: () {
                          _refresh();
                        },
                        title: "Smoke",
                        subtitle: "${_measures.smoke}",
                        gradientStartColor: Color.fromARGB(255, 103, 118, 252),
                        gradientEndColor: Color.fromARGB(255, 91, 94, 246),
                        icon: SvgAsset(
                          assetName: AssetName.tape,
                          height: 24.w,
                          width: 24.w,
                        ),
                      ),
                      DiscoverSmallCard(
                        onTap: () {
                          _refresh();
                        },
                        title: "Scan Now",
                        subtitle: "Refresh Values",
                        gradientStartColor: Color(0xFFFDC830),
                        gradientEndColor: Color(0xFFF37335),
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
                height: 30,
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 28.w),
              //   child: SizedBox(
              //     width: 500.w,
              //     child: ElevatedButton(
              //       onPressed: () {
              //         _refresh();
              //       },
              //       child: Text("Scan Now"),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 20.w,
              // ),
              _isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        )));
  }
}
