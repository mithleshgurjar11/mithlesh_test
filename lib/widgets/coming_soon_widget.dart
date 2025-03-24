

import 'package:demo/constants/color_resources.dart';
import 'package:demo/utils/styles.dart';
import 'package:flutter/Material.dart';


class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Comming soon..",style: textStyle.copyWith(
            fontSize: 30,
            color: ColorResources.primaryColor
        ),),
      ),
    );
  }
}
