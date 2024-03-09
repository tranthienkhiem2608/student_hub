// show_languages_widget.dart
import 'package:flutter/material.dart';

class ShowLanguagesWidget extends StatelessWidget {
  final List<Map<String, dynamic>> languages;

  ShowLanguagesWidget({required this.languages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: languages.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                languages[index]['name'],
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  value: languages[index]['level'] == 'Native'
                      ? 1.0
                      : languages[index]['level'] == 'Advanced'
                          ? 0.75
                          : languages[index]['level'] == 'Intermediate'
                              ? 0.5
                              : 0.25,
                  //Intermediate/Basic/Advanced/Native
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}