import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../global/styles/colors.dart';
import '../utils/constants.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.cardbg,
      highlightColor: Colors.yellow,
      child: const Row(
        children: [
          Skeleton(height: 120, width: 120),
          SizedBox(width: defaultPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(width: 80),
                SizedBox(height: defaultPadding / 2),
                Skeleton(),
                SizedBox(height: defaultPadding / 2),
                Skeleton(),
                SizedBox(height: defaultPadding / 2),
                Row(
                  children: [
                    Expanded(
                      child: Skeleton(),
                    ),
                    SizedBox(width: defaultPadding),
                    Expanded(
                      child: Skeleton(),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
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

