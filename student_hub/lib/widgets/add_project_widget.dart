//
// import 'package:flutter/material.dart';
// import 'package:student_hub/models/student_user.dart';
//
// class AddProjectWidget extends StatefulWidget {
//   @override
//   _AddProjectWidgetState createState() => _AddProjectWidgetState();
// }
//
// class _AddProjectWidgetState extends State<AddProjectWidget> {
//   final _formKey = GlobalKey<FormState>();
//   String _projectName = '';
//   StudentUser studentUser;
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Add Project'),
//       content: Form(
//         key: _formKey,
//         child: TextFormField(
//           decoration: InputDecoration(labelText: 'Project Name'),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter project name';
//             }
//             return null;
//           },
//           onSaved: (value) {
//             _projectName = value!;
//           },
//         ),
//       ),
//       actions: <Widget>[
//         TextButton(
//           child: Text('Cancel'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         TextButton(
//           child: Text('Add'),
//           onPressed: () {
//             if (_formKey.currentState!.validate()) {
//               _formKey.currentState!.save();
//               // Call the function to add the project to the student user
//               StudentUser.addProject(_projectName);
//               Navigator.of(context).pop();
//             }
//           },
//         ),
//       ],
//     );
//   }
// }