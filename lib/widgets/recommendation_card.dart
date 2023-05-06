import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.isProblem,
    required this.title,
    this.recommendation,
  });
  final String title;
  final String? recommendation;
  final bool isProblem;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        //side: BorderSide(color: isProblem ? Colors.red : Colors.green,)
      ),
      color: const Color(0xff121421),
      shadowColor: isProblem ? Colors.redAccent : Colors.lightGreenAccent,
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          children: [
            Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.w,
                    fontWeight: FontWeight.bold)),
            recommendation != null ? Divider() : const SizedBox(),
            recommendation != null
                ? Text(
                    recommendation!,
                    style: TextStyle(color: Colors.white),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
