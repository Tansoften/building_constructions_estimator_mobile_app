import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:building_construction_estimator/constants/connection.dart';
import 'package:building_construction_estimator/constants/constraints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../constants/colors.dart';
import '../constants/regex.dart';
import '../constants/uris.dart';
import '../constants/validators.dart';
import '../widgets/loading_screen.dart';
import 'package:http/http.dart' as http;

class Build extends StatefulWidget {
  final GlobalKey<FormState> buildKey = GlobalKey<FormState>();
  final globalKey = GlobalKey();

  Build({Key? key}) : super(key: key);

  @override
  State<Build> createState() => _BuildState();
}

class _BuildState extends State<Build> {
  bool _isLoading = false;

  double _buildLength = 0.0;
  double _buildWidth  = 0.0;
  double _buildHeight = 0.0;

  double _doorLength  = 0.0;
  double _doorWidth   = 0.0;
  int _doorNumbers = 0;

  double _windowLength  = 0.0;
  double _windowWidth   = 0.0;
  int _windowNumbers = 0;

  String _msg = "";

  @override
  void initState(){
    super.initState();

  }

  Future<Response> _createWindow(int buildingId) async {
    var windowUrl = Uri.parse("$windowUri/$buildingId/new");

    Map<String, dynamic> windowDim = {
      "length": _windowLength,
      "width": _windowWidth,
      "count": _windowNumbers,
    };

    var response = await http.post(windowUrl, body: json.encode(windowDim), headers: headers,);

    return response;
  }

  Future<Response> _createDoor(int buildingId) async {
    var doorUrl = Uri.parse("$doorUri/$buildingId/new");

    Map<String, dynamic> doorDim = {
      "length": _doorLength,
      "width": _doorWidth,
      "count": _doorNumbers,
    };

    var response = await http.post(doorUrl, body: json.encode(doorDim), headers: headers);

    return response;
  }

  Future<Response> _createBuilding() async {
    var buildingUrl = Uri.parse(buildingUri);

    Map<String, double> buildingDim = {
      "length":_buildLength,
      "width":_buildWidth,
      "height":_buildHeight,
    };

    var response = await http.post(buildingUrl, body: json.encode(buildingDim), headers: headers,);

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return (_isLoading)?LoadingScreen(msg: _msg,):Form(
      key: widget.buildKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      //Entire column
      child: ListView(
        children: [
          const SizedBox(height: vGap30,),
          
          //Building column
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: const [
                  Text(
                    "Building Dimensions(meters)",
                    style: TextStyle(
                      fontSize: subHeading,
                    ),
                  )
                ],
              ),

              const SizedBox(height: vGap10,),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "5",
                        labelText: "Length",
                      ),

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,

                      inputFormatters: [
                        positiveNumbersFilter,
                      ],

                      validator: buildNumberValidator,

                      onSaved: (val){
                        _buildLength = double.parse(val!);
                      },
                    ),
                  ),

                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "4",
                        labelText: "Width",
                      ),

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        positiveNumbersFilter,
                      ],
                      validator: buildNumberValidator,

                      onSaved: (val){
                        _buildWidth = double.parse(val!);
                      },
                    ),
                  ),

                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "5",
                        labelText: "Height",
                      ),

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        positiveNumbersFilter,
                      ],
                      validator: buildNumberValidator,

                      onSaved: (val){
                        _buildHeight = double.parse(val!);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),

          const SizedBox(height: vGap30,),

          //Door(s) column
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: const [
                  Text(
                    "Door(s) Dimensions(meters)",
                    style: TextStyle(
                      fontSize: subHeading,
                    ),
                  )
                ],
              ),

              const SizedBox(height: vGap10,),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "5",
                        labelText: "Length",
                      ),

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        positiveNumbersFilter,
                      ],
                      validator: buildNumberValidator,

                      onSaved: (val){
                        _doorLength = double.parse(val!);
                      },
                    ),
                  ),

                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "4",
                        labelText: "Width",
                      ),

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        positiveNumbersFilter,
                      ],
                      validator: buildNumberValidator,

                      onSaved: (val){
                        _doorWidth = double.parse(val!);
                      },
                    ),
                  ),

                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "2",
                        labelText: "Numbers",
                      ),

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        positiveNumbersFilter,
                      ],
                      validator: buildNumberValidator,

                      onSaved: (val){
                        _doorNumbers = int.parse(val!);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),

          const SizedBox(height: vGap30,),

          //Window(s) column
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: const [
                  Text(
                    "Window(s) Dimensions(meters)",
                    style: TextStyle(
                      fontSize: subHeading,
                    ),
                  )
                ],
              ),

              const SizedBox(height: vGap10,),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "5",
                        labelText: "Length",
                      ),

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        positiveNumbersFilter,
                      ],
                      validator: buildNumberValidator,

                      onSaved: (val){
                        _windowLength = double.parse(val!);
                      },
                    ),
                  ),

                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "4",
                        labelText: "Width",
                      ),

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        positiveNumbersFilter,
                      ],
                      validator: buildNumberValidator,

                      onSaved: (val){
                        _windowWidth = double.parse(val!);
                      },
                    ),
                  ),

                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "3",
                        labelText: "Numbers",
                      ),

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        positiveNumbersFilter,
                      ],
                      validator: buildNumberValidator,

                      onSaved: (val){
                        _windowNumbers = int.parse(val!);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),

          const SizedBox(height: vGap30,),

          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () async {
                        if(widget.buildKey.currentState!.validate()){
                          widget.buildKey.currentState!.save();
                          _msg = "Working on it.";
                          int tasks = 3;
                          int done = 0;
                          int rateDone = 0;

                          setState((){_isLoading = true;});

                          var response  = await _createBuilding();
                          var data      = json.decode(response.body);
                          var message   = data["message"];
                          var building  = data["body"];

                          if(response.statusCode == 201){
                            var buildingId = building["id"];
                            ++done;
                            rateDone = (done/tasks*100).toInt();

                            setState((){_msg = "Stored building dimensions...$rateDone%";});

                            var response = await _createDoor(buildingId);

                            if(response.statusCode == 201){
                              ++done;
                              rateDone = (done/tasks*100).toInt();
                              setState((){_msg = "Stored door(s) dimensions...$rateDone%";});
                            }

                            response = await _createWindow(buildingId);

                            if(response.statusCode == 201){
                              ++done;
                              rateDone = (done/tasks*100).toInt();
                              setState((){_msg = "Stored window(s) dimensions...$rateDone%";});
                            }

                            showCupertinoDialog(context: context, builder: (context){
                              return CupertinoAlertDialog(
                                title: const Text("Done"),

                                content: Text(
                                    "Room id: $buildingId"
                                ),

                                actions: [
                                  TextButton(
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                        color: cupertinoTxtColor,
                                      ),
                                    ),

                                    onPressed: (){
                                      Navigator.of(context).pop(true);
                                    },
                                  )
                                ],
                              );
                            });
                          }else{

                          }

                          setState((){_isLoading = false;});

                          Fluttertoast.showToast(msg: message);

                        }
                      },

                      child: const Text(
                          "Create"
                      )
                  ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
