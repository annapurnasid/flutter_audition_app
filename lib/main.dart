import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // fetch data from shared pref and populate the app on launch
    populateDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audition Data'),
      ),
      body: Column(children: <Widget>[
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        TextField(
          keyboardType: TextInputType.number,
          controller: _ageController,
          decoration: const InputDecoration(labelText: 'Your Age'),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            setDetails();
            // getDetails();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber, foregroundColor: Colors.black),
          child: const Text('Save Data'),
        ),
        ElevatedButton(
          // Example to remove data from shared pref
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            // Removes the value as well as key
            await prefs.remove('age');

            // to show that age is removed.
            populateDetails();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber, foregroundColor: Colors.black),
          // Example to remove data from shared pref
          child: const Text('Remove age'),
        ),
      ]),
    );
  }

  // Save data to shared preferences
  Future setDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('name', _nameController.text);
    prefs.setInt('age', int.parse(_ageController.text));
  }

  // fetch data from shared pref and populate the fields
  void populateDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name')!;
      _ageController.text =
          prefs.getInt('age') != null ? prefs.getInt('age').toString() : '0';
    });
  }
}
