

 import 'package:demo/constants/color_resources.dart';
import 'package:demo/service/navigation.dart';
import 'package:demo/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


SizedBox heightSizedBox([double height = 5]) => SizedBox(height: height);

 SizedBox widthSizedBox([double width = 5]) => SizedBox(width: width);

EdgeInsets customPadding([double padding = 15.0]) => EdgeInsets.all(padding);

EdgeInsets customPaddingOnly({double left = 0.0, double top = 0.0, double right = 0.0, double bottom = 0.0,}) {
  return EdgeInsets.only(left: left, top: top, right: right, bottom: bottom,);}

 getImage(String imagePath, {BoxFit boxFit = BoxFit.cover, double height = 40, double width = 40, Color? color}) => Image.asset(imagePath, fit: boxFit, height: height, width: width, color: color);

Widget getImageAvtar(String icon) {
  return Container(padding: const EdgeInsets.all(15), decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorResources.blue80), child: getImage(icon, height: 20, width: 20));
}

double getHeight(BuildContext context, {double? height}) =>
    MediaQuery.of(context).size.height * (height ?? 1.0);

double getWidth(BuildContext context, {double? width}) =>
    MediaQuery.of(context).size.width * (width ?? 1.0);


BorderRadius getBorderRadius({double radius = 12.0,}) => BorderRadius.circular(radius);

List<BoxShadow> customBoxShadow({
  Color? color,
  double blurRadius = 20.0,
  Offset offset = const Offset(0.0, 4.0),
}) => [BoxShadow(color: color ?? ColorResources.blackColor.withOpacity(0.2), blurRadius: blurRadius, offset: offset,),];





BorderRadius customBorderRadius({
  double topLeft = 0.0,
  double topRight = 0.0,
  double bottomLeft = 0.0,
  double bottomRight = 0.0,
}) =>
    BorderRadius.only(
      topLeft: Radius.circular(topLeft),
      topRight: Radius.circular(topRight),
      bottomLeft: Radius.circular(bottomLeft),
      bottomRight: Radius.circular(bottomRight),
    );

 buildCustomIcon(String imagePath, {void Function()? onTap, Color? color, double height = 55, double width = 55}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(50),
        shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          )),
    ),
  );
}


Widget inProgressTask(){
   return const Center(
     child: Text("In Progress",style: TextStyle(
       fontSize: 30,
       color: ColorResources.primaryColor
     ),),
   );
}

void getServerError(DioException e, BuildContext context , {bool isShow = false} ) {
  if (e.response != null) {
    switch (e.response!.statusCode) {
      case 400:
        customSnackBar(context, 'Bad request. Please check your input.');
        break;
      case 401:
        customSnackBar(context, 'Session Expired. Please log in again.');
        break;
      case 403:
        customSnackBar(context, 'Session Expired. Please log in again.');
        break;
      case 404:
        if(isShow) {
          customSnackBar(context, 'No data found.');
        }
        break;
      case 500:
        customSnackBar(context, 'Internal Server error. Please try again later.', iSError: true);
        break;
      default:
        customSnackBar(context, 'Error: ${e.response!.statusMessage}');
    }
  } else {
    customSnackBar(context, 'Network error: ${e.message}');
  }
}


Future<Object?> pushNamed(String routeName) => NavigationService.instance.pushNamed(routeName);
Future<Object?> pushNamedAndRemoveUntil(String routeName) => NavigationService.instance.pushNamedAndRemoveUntil(routeName);
