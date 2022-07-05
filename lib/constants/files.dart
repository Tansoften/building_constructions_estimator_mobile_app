import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Files{
  Future<void> writeFile(String fileName, String contents) async {
    final file = await _localFile(fileName);
    file.writeAsString(contents);
  }

  Future<String> readFile(String fileName) async {
    final file = await _localFile(fileName);
    return file.readAsString();
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File("$path/$fileName");
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}