import 'package:demo/constants/color_resources.dart';
import 'package:demo/utils/styles.dart';
import 'package:demo/widgets/custom_methods.dart';
import 'package:flutter/material.dart';



class CustomButton extends StatelessWidget {
  final Function? onTap;
  final String? btnTxt;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double borderRadius;
  final double? width;
  final double iconWidth;
  final double iconHeight;
  final Color iconColor;
  final String icon;
  final bool transparent;
  final EdgeInsets? margin;

  const CustomButton({
    super.key,
    this.onTap,
    required this.btnTxt,
    this.backgroundColor,
    this.textStyle,
    this.borderRadius = 21,
    this.width,
    this.transparent = false,
    this.margin,
    this.icon = "",
    this.iconWidth = 0.0,
    this.iconHeight = 0.0,
    this.iconColor = ColorResources.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      minimumSize: Size(width != null ? width! : getWidth(context), getHeight(context, height: 0.068)),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
    return Center(
      child: SizedBox(
        width: width ?? getWidth(context),
        child: Padding(
          padding: margin == null ? const EdgeInsets.all(0) : margin!,
          child: TextButton(
            onPressed: onTap as void Function()?,
            style: flatButtonStyle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  btnTxt ?? '',
                  style: textStyle ?? textXB.copyWith(color: ColorResources.whiteColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonIcon extends StatelessWidget {
  final Function? onTap;
  final String? btnTxt;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double borderRadius;
  final double? width;
  final double iconWidth;
  final double iconHeight;
  final Color iconColor;
  final String icon;
  final bool transparent;
  final EdgeInsets? margin;

  const CustomButtonIcon({
    super.key,
    this.onTap,
    required this.btnTxt,
    this.backgroundColor,
    this.textStyle,
    this.borderRadius = 10,
    this.width,
    this.transparent = false,
    this.margin,
    this.icon = "",
    this.iconWidth = 0.0,
    this.iconHeight = 0.0,
    this.iconColor = ColorResources.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      minimumSize: Size(width != null ? width! : getWidth(context), getHeight(context, height: 0.068)),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21),
      ),
    );
    return Center(
      child: SizedBox(
        width: width ?? getWidth(context),
        child: Padding(
          padding: margin == null ? const EdgeInsets.all(0) : margin!,
          child: TextButton(
            onPressed: onTap as void Function()?,
            style: flatButtonStyle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  btnTxt ?? '',
                  style: textStyle ?? textXB.copyWith(color: ColorResources.whiteColor),
                ),
                widthSizedBox(15),
                icon == '' ? Icon(Icons.arrow_forward) : getImage(icon, height: iconHeight, width: iconWidth, boxFit: BoxFit.fill,color: iconColor)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
