import 'package:building_construction_estimator/constants/constraints.dart';
import 'package:building_construction_estimator/constants/regex.dart';
import 'package:flutter/material.dart';
import 'budget.dart';

class MaterialCosts extends StatefulWidget {
  MaterialCosts(
      {
        Key? key,
        required this.blocks,
        required this.cementBags,
        required this.sandBuckets,
        required this.sheets,
        required this.woods
      }
      ) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final int blocks;
  final int cementBags;
  final int sandBuckets;
  final int woods;
  final int sheets;

  @override
  State<MaterialCosts> createState() => _MaterialCostsState();
}

class _MaterialCostsState extends State<MaterialCosts> {
  int _blockCost = 0;
  int _cementCost = 0;
  int _sandCost   = 0;
  int _sheetCost = 0;
  int _timberCost = 0;

  void _closeBottonSheet(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        title: const Text("Enter Materials Cost"),
      ),
      body: Container(
        padding: const EdgeInsets.all(bodyPadding),
        child: Form(
          key: widget._formKey,
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(bodyPadding),
              child: ListView(
                children: [
                  //Blocks
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "1000",
                      labelText: "Blocks cost",
                    ),

                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      positiveNumbersFilter
                    ],

                    validator: (val){
                      if(val!.isEmpty){
                        return "Required";
                      }

                      return null;
                    },

                    onSaved: (val){
                      _blockCost = int.parse(val!);
                    },
                  ),

                  const SizedBox(height: vGap10,),

                  //Cement
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "18000",
                      labelText: "Cement cost",
                    ),

                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      positiveNumbersFilter
                    ],

                    validator: (val){
                      if(val!.isEmpty){
                        return "Required";
                      }

                      return null;
                    },

                    onSaved: (val){
                      _cementCost = int.parse(val!);
                    },
                  ),

                  const SizedBox(height: vGap10,),

                  //Sheets
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "2000",
                      labelText: "Sheets cost",
                    ),

                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      positiveNumbersFilter
                    ],

                    validator: (val){
                      if(val!.isEmpty){
                        return "Required";
                      }

                      return null;
                    },

                    onSaved: (val){
                      _sheetCost = int.parse(val!);
                    },
                  ),

                  const SizedBox(height: vGap10,),

                  //Timber
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "3000",
                      labelText: "Timber cost",
                    ),

                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      positiveNumbersFilter
                    ],

                    validator: (val){
                      if(val!.isEmpty){
                        return "Required";
                      }

                      return null;
                    },

                    onSaved: (val){
                      _timberCost = int.parse(val!);
                    },
                  ),

                  const SizedBox(height: vGap10,),

                  //Sand
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "4000",
                      labelText: "Sand cost",
                    ),

                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      positiveNumbersFilter
                    ],

                    validator: (val){
                      if(val!.isEmpty){
                        return "Required";
                      }

                      return null;
                    },

                    onSaved: (val){
                      _sandCost = int.parse(val!);
                    },
                  ),

                  const SizedBox(height: vGap10,),

                  ElevatedButton(
                      onPressed: (){
                        if(widget._formKey.currentState!.validate()){
                          widget._formKey.currentState!.save();
                          widget._scaffoldKey.currentState!.showBottomSheet(
                                  (context) => Budget(
                                blocks: widget.blocks,
                                blocksCost: _blockCost*widget.blocks,
                                cementBags: widget.cementBags,
                                cementCost: _cementCost*widget.cementBags,
                                sandBuckets: widget.sandBuckets,
                                sandCost: _sandCost*widget.sandBuckets,
                                sheets: widget.sheets,
                                sheetsCost: _sheetCost*widget.sheets,
                                timber: widget.woods,
                                timberCost: _timberCost*widget.woods,
                              )
                          );
                        }
                      },
                      child: const Text(
                        "Calculate"
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
