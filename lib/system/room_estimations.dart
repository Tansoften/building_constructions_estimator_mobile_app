import 'dart:async';
import 'dart:convert';
import 'package:building_construction_estimator/widgets/loading_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:building_construction_estimator/constants/constraints.dart';
import 'package:flutter/material.dart';

import '../constants/connection.dart';
import '../constants/uris.dart';
import 'material_costs.dart';

class RoomEstimations extends StatefulWidget {
  const RoomEstimations({Key? key, required this.toggleEstimations, required this.length, required this.width, required this.height, required this.roomId}) : super(key: key);

  final Function toggleEstimations;
  final double length;
  final double width;
  final double height;
  final int roomId;

  @override
  State<RoomEstimations> createState() => _RoomEstimationsState();
}

class _RoomEstimationsState extends State<RoomEstimations> {
  bool _isLoading = true;
  Map<String, dynamic> estimations = {
    "blocks":0,
  };

  Future<void> _getEstimations() async {
    var url = Uri.parse("$estimationUri/${widget.roomId}");
    var response = await http.get(url, headers: headers,);
    var data = json.decode(response.body);
    estimations = data["body"];
    setState((){_isLoading = false;});
  }

  @override
  void initState(){
    super.initState();
    _getEstimations();
  }

  @override
  Widget build(BuildContext context) {
    if(_isLoading){
      _getEstimations();
    }

    return (_isLoading)?const SpinKitDualRing(color: Colors.white):Card(
      margin: const EdgeInsets.all(cardMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: (){
              widget.toggleEstimations();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),

          Column(
            children: [
              Text(
                "Building Estimations for room no ${widget.roomId}",
                style: const TextStyle(
                  fontSize: subHeading,
                ),
              ),

              Text(
                "Dimensions: \n${widget.length} m Urefu, ${widget.width} m Upana, ${widget.height} m Kimo"
              )
            ],
          ),

          Column(
            children: [
              const Text(
                "Building Materials",
                style: TextStyle(
                  fontSize: subHeading,
                ),
              ),
              Text(
                "Matofali: ${estimations["blocks"]}",
              ),
              Text(
                "Mifuko ya simenti: ${estimations["cement_bags"]}",
              ),
              Text(
                "Ndoo za mchanga: ${estimations["sand_buckets"]}",
              ),
            ],
          ),

          Column(
            children: [
              const Text(
                "Roofing Materials",
                style: TextStyle(
                  fontSize: subHeading,
                ),
              ),
              Text(
                "Papi: ${estimations["total_papies"]}",
              ),
              Text(
                "Mbao: ${estimations["woods"]}",
              ),
              Text(
                "Mabati: ${estimations["sheets"]}",
              ),
            ],
          ),

          ElevatedButton(
            child: const Text(
              "Calculate budget"
            ),

            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context)=>MaterialCosts(
                        blocks: estimations['blocks'],
                        cementBags: estimations['cement_bags'],
                        sandBuckets: estimations['sand_buckets'],
                        sheets: estimations['sheets'],
                        woods: estimations['woods'],
                      )
                  )
              );
            },
          ),
        ],
      ),
    );
  }
}
