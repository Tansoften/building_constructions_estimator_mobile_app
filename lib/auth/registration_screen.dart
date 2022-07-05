import 'dart:convert';
import 'package:building_construction_estimator/constants/files.dart';
import 'package:building_construction_estimator/constants/validators.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/connection.dart';
import '../constants/constraints.dart';
import '../constants/regex.dart';
import '../constants/uris.dart';
import '../models/user.dart';
import '../widgets/loading_screen.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key, required this.title, required this.toggleAuth, required this.toggleSystem}) : super(key: key);
  final regKey = GlobalKey<FormState>();
  final String title;
  final Function toggleAuth;
  final Function toggleSystem;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _firstName = "";
  String _lastName = "";
  String _phone = "";
  String _email = "";
  String _password = "";
  String _gender = "M";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return (_isLoading)?const LoadingScreen(msg: "Creating an account...",):Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Container(
        padding: const EdgeInsets.all(bodyPadding),
        child: Form(
          key: widget.regKey,

          child: ListView(
            children: <Widget>[
              const Center(
                child: Text(
                  "Registration",
                  style: TextStyle(
                    fontSize: heading,
                  ),
                ),
              ),

              const SizedBox(height: vGap30,),

              TextFormField(
                initialValue: "Yona",
                  decoration: const InputDecoration(
                    hintText: "John",
                    labelText: "First name",
                  ),

                keyboardType: TextInputType.name,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [
                  nameFilter
                ],

                validator: firstNameValidator,

                onSaved: (val){
                    _firstName = val!;
                },
              ),

              const SizedBox(height: vGap10,),

              TextFormField(
                initialValue: "Yona",
                decoration: const InputDecoration(
                  hintText: "Doe",
                  labelText: "Last name",
                ),

                keyboardType: TextInputType.name,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [
                  nameFilter,
                ],

                validator: lastNameValidator,

                onSaved: (val){
                  _lastName = val!;
                },
              ),

              const SizedBox(height: vGap10,),

              TextFormField(
                initialValue: "0700000000",
                decoration: const InputDecoration(
                  hintText: "0712000111",
                  labelText: "Phone",
                ),

                keyboardType: TextInputType.phone,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [
                  positiveNumbersFilter,
                ],

                validator: phoneValidator,

                onSaved: (val){
                  _phone = val!;
                },
              ),

              const SizedBox(height: vGap10,),

              TextFormField(
                initialValue: "yona@gmail.com",
                decoration: const InputDecoration(
                  hintText: "account@example.com",
                  labelText: "Email",
                ),

                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: emailFilter,

                validator: (val){
                  if(val!.isEmpty){
                    return "Email is required.";
                  }
                  else if(!RegExp(emailRegex).hasMatch(val)){
                    return "Please enter a valid email.";
                  }

                  return null;
                },

                onSaved: (val){
                  _email = val!;
                },
              ),

              const SizedBox(height: vGap10,),

              TextFormField(
                decoration: const InputDecoration(
                  hintText: "4ront/INE#",
                  labelText: "Enter password",
                ),

                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                inputFormatters: [
                  passwordFilter,
                ],

                validator: (val){
                  if(val!.isEmpty){
                    return "Password is required.";
                  }
                  else if(val.length < 6){
                    return "Password should be minimum 6 characters long.";
                  }
                  else if(RegExp(passwordRegex).hasMatch(val)){
                    return "\$ % \\0 \\Z \\ \\r \\b \\n \\% \\_ are not allowed.";
                  }

                  return null;
                },

                onChanged: (val){
                  _password = val;
                },
              ),

              const SizedBox(height: vGap10,),

              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Repeat password.",
                  labelText: "Confirm password",
                ),

                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,

                validator: (val){
                  if(!(val == _password)){
                    return "Passwords must match!";
                  }

                  return null;
                },
              ),

              const SizedBox(height: vGap10,),

              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: const Text("Male"),
                       value: "M",
                       groupValue: _gender,

                       onChanged: (val){
                        setState((){_gender = val.toString();});
                       },
                    ),
                   ),

                    Expanded(
                      child: RadioListTile(
                        title: const Text("Female"),
                        value: "F",
                        groupValue: _gender,

                        onChanged: (val){
                          setState((){_gender = val.toString();});
                        },
                      ),
                    ),
                 ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: const Text(
                      "Login"
                    ),

                    onPressed: (){
                      widget.toggleAuth();
                    },
                  ),

                  ElevatedButton(
                    child: const Text(
                      "Register"
                    ),

                    onPressed: () async {
                      if(widget.regKey.currentState!.validate()){
                        widget.regKey.currentState!.save();
                        setState((){_isLoading = true;});

                        Map<String, dynamic> data = {
                          "first_name": _firstName,
                          "last_name": _lastName,
                          "gender": _gender,
                          "phone": _phone,
                          "email": _email,
                          "password": _password,
                        };

                        var url = Uri.parse(registerUri);

                        var response = await http.post(url, body: json.encode(data), headers: headers,);

                        if(response.statusCode == 200){
                          Files fileOperation = Files();
                          var returnedData = json.decode(response.body);
                          var token = returnedData["token"];
                          var user = returnedData["user"];
                          fileOperation.writeFile("token.dat", token);
                          user = User(
                            user["id"],
                            _firstName,
                            _lastName,
                            _gender,
                            _phone,
                            _email,
                            token
                          );

                          headers["Authorization"] = "Bearer $token";

                          widget.toggleSystem();
                        }

                        setState((){_isLoading = false;});
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
