import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './screen_add.dart';
import 'screen_update.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  late final Box box;

  @override
  void initState() {
    box = Hive.box('box');
    super.initState();
  }

  void delete(int index) async {
    await box.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, value, child) {
          if (box.isEmpty) {
            return const Text('Box is Empty');
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                var name = box.getAt(index);
                return ListTile(
                  title: Text(box.getAt(index)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      delete(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('!Deleted'),
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ScreenUpdate(
                            index: index,
                            name: name,
                          );
                        },
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const ScreenAdd();
            }),
          );
        },
      ),
    );
  }
}
