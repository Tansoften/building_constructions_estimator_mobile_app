import 'package:building_construction_estimator/constants/constraints.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

//Themes
const bottomSheetTheme = BottomSheetThemeData(
  backgroundColor: primaryColor,
  constraints: BoxConstraints(
    minHeight: 100.0,
    minWidth: double.infinity,
  ),
);

const listTileTheme = ListTileThemeData(
  textColor: secondaryColor,
);

var radioTheme = RadioThemeData(
  fillColor: MaterialStateProperty.resolveWith((states) => secondaryColor),
);

var iconTheme = const IconThemeData(
  color: secondaryColor,
);

var cardTheme = CardTheme(
  elevation: 4.0,
  color: primaryColor.shade50,
  margin: const EdgeInsets.all(20.0),
);

const textTheme = TextTheme(
  bodyText1: TextStyle(
    color: Colors.white,
  ),
  bodyText2: TextStyle(
    color: Colors.white,
  ),
);
const inputDecorationTheme = InputDecorationTheme(
  floatingLabelStyle: TextStyle(
    backgroundColor: Colors.white,
  ),
  filled: true,

  fillColor: Colors.white,

  errorStyle: TextStyle(
    color: errorColor,
  ),
  
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(borderRadius)),

    borderSide: BorderSide(
      width: 0.0,
    )
  ),

  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(borderRadius)),

    borderSide: BorderSide(
      color: errorColor,
    ),
  ),

  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(borderRadius)),

    borderSide: BorderSide(
      color: errorColor,
    ),
  )
);

var textButtonTheme = TextButtonThemeData(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all(Colors.white),
  ),
);

const inputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(borderRadius)),

    borderSide: BorderSide(
      color: primaryColor,
    ),
  ),


);