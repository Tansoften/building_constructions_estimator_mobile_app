import 'dart:async';
import 'dart:convert';
import 'package:building_construction_estimator/system/room_estimations.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:building_construction_estimator/constants/uris.dart';
import 'package:flutter/material.dart';

import '../constants/connection.dart';
import '../constants/constraints.dart';

class Rooms extends StatefulWidget {
  const Rooms({Key? key}) : super(key: key);

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  StreamController<List> rooms = StreamController<List>.broadcast();
  bool _isEstimations = false;
  var roomId = 0;
  var length = 0.0;
  var width = 0.0;
  var height = 0.0;

  void _toggleEstimations(){
    setState((){_isEstimations = !_isEstimations;});
  }

  Future<void> _getRooms() async {
    var roomsUrl = Uri.parse(roomsUri);
    var response = await http.get(roomsUrl, headers: headers,);
    var data = json.decode(response.body);
    try{
      rooms.add(data["body"]);
    }catch($exc){
      print($exc);
    }

  }

  // @override
  // void initState(){
  //   super.initState();
  //    _getRooms();
  // }

  @override
  Widget build(BuildContext context) {
    var roomsHeight = MediaQuery.of(context).size.height*0.7;
    _getRooms();
    return (_isEstimations)?RoomEstimations(toggleEstimations: _toggleEstimations,length: length, width: width, height: height, roomId: roomId,):ListView(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search_rounded),
            labelText: "Search",
            hintText: "12",
          ),
        ),

        SizedBox(
          height: roomsHeight,
          child: StreamBuilder<dynamic>(
            stream: rooms.stream,
            builder: (context, snapshot) {
              if(snapshot.hasData){

                return ListView.builder(
                  dragStartBehavior: DragStartBehavior.start,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()
                    ),

                    itemCount: snapshot.requireData.length,
                    reverse: true,

                    itemBuilder: (context, index){
                      var room = snapshot.data![index];
                      return Card(
                        child: Column(
                          children: [
                            Text(
                                "Building ID ${room["id"]}"
                            ),

                            const SizedBox(height: vGap10,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                    "Length: ${room["length"]} m"
                                ),
                                Text(
                                    "Width: ${room["width"]} m"
                                ),
                                Text(
                                    "Height: ${room["height"]} m"
                                ),
                              ],
                            ),

                            ElevatedButton(
                                onPressed: (){
                                  var l = room["length"];
                                  var w = room["width"];
                                  var h = room["height"];

                                  roomId  = room["id"];
                                  length  = double.parse(l.toString());
                                  width   = double.parse(w.toString());
                                  height  = double.parse(h.toString());

                                  setState((){_isEstimations = true;});
                                },
                                child: const Text(
                                  "Open Estimations"
                                )
                            )
                          ],
                        ),
                      );
                    }
                );
              }

              return const Center(
                child: Text(
                  "No Rooms"
                ),
              );
            }
          ),
        )
      ],
    );
  }
}
