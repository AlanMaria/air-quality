import 'package:agri_hack/widgets/recommendation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/measures.dart';

class RecommendationSystem extends StatefulWidget {
  const RecommendationSystem(
      {super.key,
      required this.currentMeasures,
      required this.minMeasures,
      required this.maxMeasures});
  final Measures currentMeasures;
  final Measures minMeasures;
  final Measures maxMeasures;

  static const ok = "✅";
  static const warn = "⚠️";
  static const problem = "🛑";

  @override
  State<RecommendationSystem> createState() => _RecommendationSystemState();
}

class _RecommendationSystemState extends State<RecommendationSystem> {
  Map<String, String> remedy = {
    "Nitrogen": "Urea or Ammonium nitrate",
    "Phosphorous": "Rock phosphate or Diammonium phosphate",
    "Pottassium": "Sulfate of potash or Potassium nitrate",
    "Moisture": "Water",
    "pH": "Compost or Well-rotten manure",
  };

  Widget compareParam(param, current, min, max) {
    if (current < min) {
      return RecommendationCard(
        isProblem: true,
        title: "$param is less than the required value.",
        recommendation: "Add ${min - current} kg/ha ${remedy[param]}",
      );
    } else if (current > max) {
      return RecommendationCard(
          isProblem: true,
          title: "$param is higher than the ideal value.",
          recommendation: "Remove ${current - max} kg/ha of $param.");
    }
    return RecommendationCard(
        isProblem: false, title: "$param is within the ideal range of values.");
  }

  String comparePH(param, current, min, max) {
    if (current < min) {
      return "${RecommendationSystem.problem} $param is less than the required value.";
    } else if (current > max) {
      return "${RecommendationSystem.problem} $param is higher than ideal value. ";
    }
    return "${RecommendationSystem.ok} $param is within the required value.";
  }

  @override
  Widget build(BuildContext context) {
    //Return a ListView with text widgets giving info

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        /*Text("Fertilizer Stocks: ",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.w,
                fontWeight: FontWeight.bold)),
        Text("Work in Progress ⚠️"),*/
      ]),
    );
  }
}
