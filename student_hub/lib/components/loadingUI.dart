import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.5),
      child: const Center(
        child: SpinKitThreeInOut(
          color: Colors.lightBlueAccent,
          size: 30.0,
        ),
      ),
    );
  }
}
