import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ScreenUpdate extends StatefulWidget {
  final int index;
  final String name;
  const ScreenUpdate({
    super.key,
    required this.index,
    required this.name,
  });

  @override
  State<ScreenUpdate> createState() {
    return _ScreenUpdateState();
  }
}

class _ScreenUpdateState extends State<ScreenUpdate> {
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late final Box box;
  void update() {
    print(nameController.text);
    box.putAt(widget.index, nameController.text);
  }

  @override
  void initState() {
    box = Hive.box('box');
    nameController = TextEditingController(text: widget.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPDATE'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              maxLength: 10,
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter a Name';
                } else if (value == widget.name) {
                  return 'Same Name';
                }
                return null;
              },
            ),
            ElevatedButton(
              child: const Text('Update'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  update();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Name Changed to ${nameController.text}')));
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
