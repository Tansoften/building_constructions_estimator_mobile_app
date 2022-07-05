import 'package:building_construction_estimator/constants/constraints.dart';
import 'package:building_construction_estimator/constants/uris.dart';
import 'package:building_construction_estimator/system/rooms.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/connection.dart';
import '../widgets/loading_screen.dart';
import 'build.dart';

class Dashboard extends StatefulWidget {
  final Function toggleSystem;
  const Dashboard({Key? key, required this.toggleSystem}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var globalKey = GlobalKey();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
              "Home"
          ),

          actions: [
            IconButton(
                onPressed: () async {
                  setState((){_isLoading = true;});
                  var uri = Uri.parse(logoutUri);
                  var response = await http.get(uri, headers: headers,);

                  if(response.statusCode == 200){
                    widget.toggleSystem();
                  }
                  else{
                    setState((){_isLoading = false;});
                  }
                },
                icon: const Icon(
                  Icons.logout_rounded,
                )
            )
          ],

          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.construction_rounded
                ),
                text: "Build",
              ),

              Tab(
                icon: Icon(
                    Icons.house_rounded
                ),
                text: "Rooms",
              ),

              Tab(
                icon: Icon(
                    Icons.account_box_rounded
                ),
                text: "Profile",
              )
            ],
          ),
        ),

        body: (_isLoading)?const LoadingScreen(msg: 'Logging out.',):
        TabBarView(
            children: [
              Container(
                margin: const EdgeInsets.all(bodyPadding),
                child: Build(),
              ),

              Container(
                margin: const EdgeInsets.all(bodyPadding),
                child: const Rooms(),
              ),

              Text(
                  "Profile"
              )
            ],
        ),
      ),
    );
  }
}
