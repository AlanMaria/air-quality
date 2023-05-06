import 'package:agri_hack/providers/locale_provider.dart';
import 'package:agri_hack/screens/scan_screen.dart';
import 'package:agri_hack/services/firestore_services.dart';
import 'package:agri_hack/services/weather_service.dart';
import 'package:agri_hack/widgets/discover_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../models/language_model.dart';
import '../models/weather/weather.dart';
import '../widgets/discover_small_card.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  String krishibhavan = "Loading";
  String temperature = "Loading";
  String _location = "8.524139,76.936638";

  LanguageModel? _chosenValue;
  List<LanguageModel> _languages = List.empty(growable: true);

  _getWeather() async {
    Weather weather = await WeatherServices.getWeather(_location);

    if (!mounted) return;
    setState(() {
      temperature = "${((weather.temp - 32) * 5 / 9).toStringAsFixed(1)} °C";
    });
  }

  _getLocation() async {
    final temp = await FirestoreServices()
        .getKrishibhavan(FirebaseAuth.instance.currentUser!.uid);

    setState(() {
      krishibhavan = temp;
    });

    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    setState(() {
      _location = "${_locationData.latitude},${_locationData.longitude}";
    });
    _getWeather();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _languages.add(LanguageModel(code: 'en', name: 'English'));
    _languages.add(LanguageModel(code: 'ml', name: 'Malayalam'));
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      appBar: AppBar(
        backgroundColor: const Color(0xff121421),
        elevation: 0,
        actions: [
          DropdownButton<LanguageModel>(
              value: _chosenValue,
              dropdownColor: Colors.black,
              items: _languages
                  .map<DropdownMenuItem<LanguageModel>>((LanguageModel value) {
                return DropdownMenuItem<LanguageModel>(
                  value: value,
                  child:
                      Text(value.name!, style: TextStyle(color: Colors.white)),
                );
              }).toList(),
              hint: Text(
                "English",
                style: TextStyle(color: Colors.white),
              ),
              onChanged: (LanguageModel? newValue) {
                if (newValue == null) {
                  return;
                }
                setState(() {
                  _chosenValue = newValue;
                  Provider.of<LocaleProvider>(context, listen: false)
                      .setLocale(Locale(newValue.code!));
                });
              })
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 30.w,
              ),
              child: Text("${AppLocalizations.of(context)!.hey_there} 👋",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 34.w,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 30.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DiscoverCard(
                      tag: "scan card",
                      gradientStartColor: const Color(0xffff512f),
                      gradientEndColor: const Color(0xffdd2476),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ScreenScan()));
                      },
                      title: AppLocalizations.of(context)!.scan_soil,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      AppLocalizations.of(context)!.reser,
                      style: TextStyle(
                          color: Color(0xff515979),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.w),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 120.h,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          DiscoverSmallCard(
                            gradientStartColor: const Color(0xff13DEA0),
                            gradientEndColor: const Color(0xff06B782),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ScreenHome()));
                            },
                            title: AppLocalizations.of(context)!.krishibhavan,
                            subtitle: "${krishibhavan}",
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          DiscoverSmallCard(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ScreenHome()));
                            },
                            title: AppLocalizations.of(context)!.weather,
                            subtitle: "${temperature}",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      AppLocalizations.of(context)!.market,
                      style: TextStyle(
                          color: Color(0xff515979),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.w),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                        height: 200.h,
                        width: 300.w,
                        child: ListView.separated(
                            itemBuilder: (context, index) => const Text(
                                  "Some Fertilizer : ₹100",
                                  style: TextStyle(color: Colors.white),
                                ),
                            separatorBuilder: (context, index) => const Divider(
                                  color: Colors.blueGrey,
                                ),
                            itemCount: 10))
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
