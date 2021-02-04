import 'package:flutter/material.dart';

class Soundboard extends StatefulWidget {
  Soundboard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SoundboardState createState() => _SoundboardState();
}

class _SoundboardState extends State<Soundboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Soundboard"),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        itemCount: 9,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green[400],
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Center(
              child: Text('${index + 1}'),
            ),
          ),
          onTap: () {
            if (mounted) {
              setState(() {
                print(index +1);
              });
            }
          },
        ),
        primary: false,
        padding: const EdgeInsets.all(30),
      ),
    );
  }
}