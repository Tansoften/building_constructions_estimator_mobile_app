import 'package:building_construction_estimator/wrapper.dart';
import 'package:building_construction_estimator/constants/colors.dart';
import 'package:building_construction_estimator/constants/decorations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BuildingEstimator());
}

class BuildingEstimator extends StatelessWidget {
  const BuildingEstimator({Key? key}) : super(key: key);
  static const _title = 'Building Estimator';
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: primaryColor,
        scaffoldBackgroundColor: primaryColor.shade600,
        bottomSheetTheme: bottomSheetTheme,
        inputDecorationTheme: inputDecorationTheme,
        textButtonTheme: textButtonTheme,
        textTheme: textTheme,
        cardTheme: cardTheme,
        iconTheme: iconTheme,
        radioTheme: radioTheme,
        listTileTheme: listTileTheme,
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
        ),
      ),
      home: const Wrapper(title: _title,),
    );
  }
}