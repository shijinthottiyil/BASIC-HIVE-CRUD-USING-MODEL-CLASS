import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../model/model.dart';

class ScreenAdd extends StatefulWidget {
  const ScreenAdd({super.key});

  @override
  State<ScreenAdd> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAdd> {
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late final Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('box');
  }

  void addFunction() async {
    Model model = Model(name: nameController.text);
    await box.add(model.name);
    print(box.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              maxLength: 10,
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'NAME',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter a Name';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  addFunction();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${nameController.text} Added'),
                    ),
                  );
                  nameController.clear();
                }
              },
              child: const Text('ADD'),
            ),
          ],
        ),
      ),
    );
  }
}
