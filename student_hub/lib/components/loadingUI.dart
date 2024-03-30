import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: const Center(
        child: SpinKitThreeInOut(
          color: Colors.lightBlueAccent,
          size: 50.0,
        ),
      ),
    );
  }
}