import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constants/constraints.dart';

class LoadingScreen extends StatefulWidget {
  final String msg;

  const LoadingScreen({Key? key, required this.msg}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitFadingCircle(
              color: Colors.white,
            ),

            const SizedBox(height: vGap10,),

            Text(widget.msg),
          ],
        ),
      ),
    );

  }
}
