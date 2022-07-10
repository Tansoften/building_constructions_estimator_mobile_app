import 'package:building_construction_estimator/constants/constraints.dart';
import 'package:flutter/material.dart';

class Budget extends StatelessWidget {
  const Budget(
      {
        Key? key,
        required this.blocks,
        required this.cementBags,
        required this.sandBuckets,
        required this.timber,
        required this.sheets,
        required this.blocksCost,
        required this.cementCost,
        required this.sandCost,
        required this.sheetsCost,
        required this.timberCost
      }
      ) : super(key: key);

  final int blocks;
  final int cementBags;
  final int sandBuckets;
  final int timber;
  final int sheets;

  final int blocksCost;
  final int cementCost;
  final int sandCost;
  final int timberCost;
  final int sheetsCost;

  @override
  Widget build(BuildContext context) {
    int totalCost = blocksCost + sandCost + cementCost + sheetsCost + timberCost;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              child: const Text(
                "CLOSE"
              ),

              onPressed: (){
                Navigator.of(context).pop(true);
              },
            ),
          ),

          const Text(
            "Gharama za ujenzi",
            style: TextStyle(
              fontSize: subHeading,
            ),
          ),

          Text(
            "Matofali $blocks \t => $blocksCost TZS"
          ),

          Text(
              "Cement mifuko $cementBags \t => $cementCost TZS"
          ),

          Text(
              "Ndoo za mchanga $sandBuckets \t => $sandCost TZS"
          ),

          Text(
              "Mabati $sheets \t => $sheetsCost TZS"
          ),

          Text(
              "Mbao $timber \t => $timberCost TZS"
          ),

          Text(
              "Jumla $totalCost TZS"
          )
        ],
      ),
    );
  }
}
