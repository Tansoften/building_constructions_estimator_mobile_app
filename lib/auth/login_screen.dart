import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/connection.dart';
import '../constants/constraints.dart';
import '../constants/decorations.dart';
import '../constants/files.dart';
import '../models/stores.dart';
import '../models/user.dart';
import '../widgets/loading_screen.dart';

class LoginScreen extends StatefulWidget {
  final String title;
  final Function toggleAuth;
  final Function toggleSystem;
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  LoginScreen({Key? key, required this.title, required this.toggleAuth, required this.toggleSystem}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _userName = "";
  String _password = "";
  bool _isLoading = false;
  String _error = "";

  @override
  Widget build(BuildContext context) {
    var loginHeight = MediaQuery.of(context).size.height*0.6;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: (_isLoading)?const LoadingScreen(msg: 'Logging in.',):Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(bodyPadding),
          height: loginHeight,
          child: Form(
            key: widget.loginKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Text(
                    "Login",
                  style: TextStyle(
                    fontSize: heading,
                  ),
                ),

                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                        Icons.account_box_rounded
                    ),

                    hintText: "account@tansoften.com",
                    labelText: "Username",
                  ),

                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                  validator: (val){
                    if(val!.isEmpty){
                      return "Username is required.";
                    }

                    return null;
                  },

                  onChanged: (val){
                    _userName = val;
                  },
                ),

                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.key_rounded
                    ),

                    labelText: "Password",
                    hintText: "123456",
                  ),

                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,

                  validator: (val){
                    if(val!.isEmpty){
                      return "Password is required.";
                    }
                  },
                  onChanged: (val){
                    _password = val;
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: (){
                          widget.toggleAuth();
                        },
                        child: const Text(
                            "Register"
                        )
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        if(widget.loginKey.currentState!.validate()){
                          var url = Uri.parse("$host:$port/api/login");

                          Map<String, String> loginCredentials = {
                            "email":    _userName,
                            "password": _password
                          };

                          setState((){_isLoading = true;});

                          var response = await http.post(url,headers: headers,body: json.encode(loginCredentials));
                          
                          var data = json.decode(response.body);

                          if(response.statusCode == 200){
                            var returnedUser = data["user"];

                            user = User(
                              returnedUser["id"],
                              returnedUser["first_name"],
                              returnedUser["last_name"],
                              returnedUser["gender"],
                              returnedUser["phone"],
                              returnedUser["email"],
                              data["token"]
                            );

                            headers["Authorization"] = "Bearer ${user.getToken()}";

                            Files fileOperation = Files();
                            fileOperation.writeFile("token.dat", data["token"]);

                            setState((){widget.toggleSystem();});
                          }
                          else{
                            setState((){
                              _error = data["message"];
                              _isLoading = false;
                            });
                          }
                        }
                      },

                      child: const Text(
                          "Login"
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _error,
                      style: const TextStyle(
                        color: errorColor,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
