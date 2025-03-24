import 'package:demo/utils/styles.dart';
import 'package:flutter/material.dart';


AppBar customTitleAppBar(BuildContext context, String title,) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    leading: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios_new_sharp,
          color: Colors.black,
        )
    ),
    title: Text(title, style: textXB),
  );
}


