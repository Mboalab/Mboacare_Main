import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../global/styles/colors.dart';
import '../utils/constants.dart';

class ShimmerTop extends StatelessWidget {
  const ShimmerTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var hieght = MediaQuery.of(context).size.height;
    return Shimmer.fromColors(
      baseColor: AppColors.cardbg,
      highlightColor: Colors.yellow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: hieght * 0.2,
              width: width * 0.92,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.04),
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    Skeleton(
                      width: width * 0.7,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Skeleton(
                          width: width * 0.2,
                        ),
                        SizedBox(width: width * 0.02),
                        Skeleton(
                          width: width * 0.4,
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class CustomRounded extends StatelessWidget {
  final double? topPadding;
  final Color? cardColor;

  final double? elevation;

  const CustomRounded({
    super.key,
    this.topPadding,
    this.cardColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding ?? 0.0),
      child: Card(
        elevation: elevation ?? 1.0,
        color: cardColor,
        child: const Padding(
          padding:
              EdgeInsets.only(left: 15.0, right: 15.0, bottom: 7.0, top: 7.0),
        ),
      ),
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius:
              const BorderRadius.all(Radius.circular(defaultPadding))),
    );
  }
}
