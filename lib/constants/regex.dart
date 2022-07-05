import 'package:flutter/services.dart';

const passwordRegex = "\\0\\Z\\t\\n\\b\\r\\\$\\%\\_";
const emailRegex = "^[a-z][a-z0-9.-]+@[a-z0-9]+([-]{0,1}[a-z0-9])+([.][a-z0-9]+([-]{0,1}[a-z0-9])+)*[.][a-z]{2,}\$";
const phoneReg = "^(0)[1-9][0-9]{8}\$";
const nameRegex = "^[A-Z][a-z]{2,}\$";

var emailFilter = [
  FilteringTextInputFormatter(RegExp(r"[\w@.-]"), allow: true),
];
var passwordFilter = FilteringTextInputFormatter(RegExp(r"[\\0\\Z\\t\\n\\b\\r\\\\$\\%\\_]"), allow: false);
var nameFilter = FilteringTextInputFormatter(RegExp("[A-Za-z]"), allow: true);
var positiveNumbersFilter = FilteringTextInputFormatter(RegExp(r"[\d.]"), allow: true);