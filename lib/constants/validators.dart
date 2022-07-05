import 'package:building_construction_estimator/constants/regex.dart';

var phoneValidator = (val){
  if(val!.isEmpty){
    return "Phone is required.";
  }
  else if(!RegExp(phoneReg).hasMatch(val)){
    return "Please enter a valid phone.";
  }

  return null;
};

var lastNameValidator = (val){
  if(val!.isEmpty){
    return "Last name is required.";
  }
  else if(!RegExp(nameRegex).hasMatch(val)){
    return "Please enter a valid name.";
  }

  return null;
};

var firstNameValidator = (val){
  if(val!.isEmpty){
    return "First name is required.";
  }
  else if(!RegExp(nameRegex).hasMatch(val)){
    return "Please enter a valid name.";
  }

  return null;
};

var buildNumberValidator = (val){
  if(val!.isEmpty){
    return "Enter valid input.";
  }
  return null;
};