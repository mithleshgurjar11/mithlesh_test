import 'package:demo/constants/color_resources.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';


class CustomDropDown extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;
  final double buttonHeight;
  final double buttonWidth;
  final BorderRadius borderRadius;
  final BorderRadius borderRadiusItem;
  final TextStyle hintTextStyle;
  final TextStyle itemTextStyle;
  final Color iconColor;
  final Color borderColor;



  const CustomDropDown({
    super.key,
    required this.items,
    required this.hintText,
    this.iconColor = ColorResources.primaryColor,


    this.selectedValue,
    this.onChanged,
    this.buttonHeight = 50.0,
    this.buttonWidth = 150.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    required this.hintTextStyle,
    required this.itemTextStyle,
    this.borderRadiusItem = const BorderRadius.all(Radius.circular(10)),
    this.borderColor = ColorResources.borderColor,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Text(
          widget.hintText,
          style: widget.hintTextStyle,
          overflow: TextOverflow.ellipsis,
        ),
        items: widget.items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: widget.itemTextStyle,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },

        buttonStyleData: ButtonStyleData(
          height: widget.buttonHeight,
          width: widget.buttonWidth,
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            border: Border.all(
              color: widget.borderColor,
              width: 1,
            ),
            color: ColorResources.whiteColor,
          ),
        ),

        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadiusItem,
            color: ColorResources.whiteColor,
            border: Border.all(
              color: ColorResources.primaryColor,
              width: 1,
            ),
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(10),
            trackVisibility: WidgetStateProperty.all<bool>(false),
            trackColor: WidgetStateProperty.all(ColorResources.primaryColor),
            thickness: WidgetStateProperty.all<double>(0),
            thumbVisibility: WidgetStateProperty.all<bool>(false),
          ),
        ),
      ),
    );
  }
}




class CustomDropDownTwo extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;
  final double buttonHeight;
  final double buttonWidth;
  final BorderRadius borderRadius;
  final BorderRadius borderRadiusItem;
  final TextStyle hintTextStyle;
  final TextStyle itemTextStyle;
  final Color iconColor;
  final Color borderColor;

  const CustomDropDownTwo({
    Key? key,
    required this.items,
    required this.hintText,
    this.selectedValue,
    this.onChanged,
    this.buttonHeight = 50.0,
    this.buttonWidth = 150.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    required this.hintTextStyle,
    required this.itemTextStyle,
    this.borderRadiusItem = const BorderRadius.all(Radius.circular(10)),
    this.borderColor = Colors.grey, // Changed to prevent missing reference
    this.iconColor = Colors.black,  // Changed to prevent missing reference
  }) : super(key: key);

  @override
  State<CustomDropDownTwo> createState() => _CustomDropDownTwoState();
}

class _CustomDropDownTwoState extends State<CustomDropDownTwo> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Text(
          widget.hintText,
          style: widget.hintTextStyle,
          overflow: TextOverflow.ellipsis,
        ),
        items: widget.items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: widget.itemTextStyle,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        buttonStyleData: ButtonStyleData(
          height: widget.buttonHeight,
          width: widget.buttonWidth,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            border: Border.all(
              color: widget.borderColor,
              width: 1,
            ),
            color: Colors.white, // Changed for a clear button background
          ),
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down, // Changed to a default icon
            color: widget.iconColor,
            size: 25,
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadiusItem,
            color: Colors.white, // Background for dropdown
            border: Border.all(
              color: widget.borderColor,
              width: 1,
            ),
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(10),
            trackVisibility: MaterialStateProperty.all(false),
            thickness: MaterialStateProperty.all(5),
            thumbVisibility: MaterialStateProperty.all(false),
          ),
        ),
      ),
    );
  }
}

