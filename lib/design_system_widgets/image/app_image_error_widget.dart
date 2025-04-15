import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class AppImageErrorWidget extends StatelessWidget {
  const AppImageErrorWidget({super.key, this.width = 54, this.height = 54});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        Assets.icons.imgNotFound.path,
        height: height,
        fit: BoxFit.fill,
      ),
    );
  }
}
