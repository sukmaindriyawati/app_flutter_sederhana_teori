import 'package:flutter/material.dart';
import 'models/item.dart';

class AddEditScreen extends StatelessWidget {
  final Item? item;
  final Function(String, String) onSave;

  AddEditScreen({this.item, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: item?.name);
    final descriptionController = TextEditingController(text: item?.description);

    return Scaffold(
      appBar: AppBar(title: Text(item == null ? 'Add Item' : 'Edit Item')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onSave(nameController.text, descriptionController.text);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
