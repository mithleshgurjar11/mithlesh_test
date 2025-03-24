import 'package:demo/constants/color_resources.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



void customSnackBar(BuildContext context, String message, {bool iSError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds:700 ),
      content: Text(message),
      backgroundColor: iSError ? Colors.redAccent :  ColorResources.primaryColor,
    ),
  );
}

void customRecordsSnackBar(BuildContext context, String message, {bool iSError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds:3000 ),
      content: Text(message),
      behavior: SnackBarBehavior.floating, // Makes the SnackBar floating
      backgroundColor: iSError ? Colors.redAccent :  ColorResources.primaryColor,
      margin: EdgeInsets.only(
        left: 20,
        right: 20,

        bottom: MediaQuery.of(context).size.height * 0.2, // Ensure symmetry
      ),
    ),
  );
}

Widget customLoader(BuildContext context, {Color? color, double? size}){
  return SpinKitFadingCircle(
    color: color ?? ColorResources.primaryColor,
    size: size ?? 85.0,
  );
}
