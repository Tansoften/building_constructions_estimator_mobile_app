import 'dart:convert';
import 'package:building_construction_estimator/auth/login_screen.dart';
import 'package:building_construction_estimator/constants/connection.dart';
import 'package:building_construction_estimator/constants/uris.dart';
import 'package:building_construction_estimator/system/dashboard.dart';
import 'package:building_construction_estimator/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'auth/registration_screen.dart';
import 'constants/files.dart';
import 'package:http/http.dart' as http;
import 'models/stores.dart';
import 'models/user.dart';

class Wrapper extends StatefulWidget {
  //Constants
  const Wrapper({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  //Dynamics
  bool _isLogin     = true;
  bool _hasLoggedIn = false;
  bool _isLoading   = true;

  void toggleAuth(){
    setState((){_isLogin = !_isLogin;});
  }

  void toggleSystem(){
    setState((){_hasLoggedIn = !_hasLoggedIn;});
  }

  Future<bool> _checkAccess() async {
    Files fileOperation = Files();
    String token = await fileOperation.readFile("token.dat");
    Uri uri = Uri.parse(userUri);
    headers["Authorization"] = "Bearer $token";

    var response = await http.get(uri, headers: headers);

    if(response.statusCode == 200){
      var data = json.decode(response.body);
      var returnedUser = data["body"];
      user = User(
        returnedUser["id"],
        returnedUser["first_name"],
        returnedUser["last_name"],
        returnedUser["gender"],
        returnedUser["phone"],
        returnedUser["email"],
        token
      );
      return true;
    }

    return false;
  }
  
  @override
  Widget build(BuildContext context) {
    if(_isLoading){
      _checkAccess().then((value) => setState((){_hasLoggedIn = value; _isLoading = false;}));
      return const LoadingScreen( msg: "Initializing System.",);
    }

    if(_hasLoggedIn){
      return Dashboard(toggleSystem: toggleSystem,);
    }
    else if(_isLogin){
      return LoginScreen(title: widget.title, toggleAuth: toggleAuth, toggleSystem: toggleSystem,);
    }

    return RegistrationScreen(title: widget.title, toggleAuth: toggleAuth, toggleSystem: toggleSystem,);
  }
}
