import 'package:flutter/material.dart';

class AddAccountWidget extends StatelessWidget {
  const AddAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 380, // Set the width you want
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), // Set the radius you want
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFdce8e8), // Set the background color you want
          ),
          onPressed: () {
            // Add functionality here
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.add, size: 34, color: Colors.black),
              SizedBox(width: 10),
              Text('Add new account', style: TextStyle(fontSize: 21, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}