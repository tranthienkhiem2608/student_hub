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
                child: Text(
                  languages[index]['level'],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
