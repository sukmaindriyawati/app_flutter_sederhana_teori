import 'package:flutter/material.dart';
import 'models/item.dart';

class DetailScreen extends StatelessWidget {
  final Item item;

  DetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: ${item.name}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Deskripsi: ${item.description}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
