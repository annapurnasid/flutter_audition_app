import 'package:flutter/material.dart';
import 'package:flutter_audition_app/details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Audition Data'),
          ),
          body: const MyCustomForm(),
        ));
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  late String _nameData;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            _nameData = value;
            return null;
          },
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Details(value: _nameData)));
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber, foregroundColor: Colors.black),
          child: const Text('Send Data'),
        ),
      ]),
    );
  }
}
