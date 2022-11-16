import 'package:flutter/material.dart';

class Dalle extends StatefulWidget {
  const Dalle({Key? key}) : super(key: key);

  @override
  State<Dalle> createState() => _DalleState();
}

class _DalleState extends State<Dalle> {
  final TextEditingController _imageDescriptionController =
      TextEditingController();
  String? imgUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _imageDescriptionController,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {},
              child: const Text("Sorgula"),
            ),
            const SizedBox(height: 50),
            imgUrl != null ? Image.network(imgUrl!) : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
