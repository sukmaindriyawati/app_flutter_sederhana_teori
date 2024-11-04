import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/item.dart';
import 'add_edit_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=5'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      setState(() {
        items = data.map((json) => Item.fromJson(json)).toList();
      });
    }
  }

  Future<void> addItem(String name, String description) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': name, 'body': description}),
    );
    if (response.statusCode == 201) {
      final newItem = Item.fromJson(json.decode(response.body));
      setState(() {
        items.add(newItem);
      });
    }
  }

  Future<void> editItem(Item item, String name, String description) async {
    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/${item.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': name, 'body': description}),
    );
    if (response.statusCode == 200) {
      setState(() {
        item.name = name;
        item.description = description;
      });
    }
  }

  Future<void> deleteItem(int id) async {
    final response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
    );
    if (response.statusCode == 200) {
      setState(() {
        items.removeWhere((item) => item.id == id);
      });
    }
  }

  void navigateToAddScreen({Item? item}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditScreen(
          item: item,
          onSave: (name, description) {
            if (item != null) {
              editItem(item, name, description);
            } else {
              addItem(name, description);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Knalpot')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    navigateToAddScreen(item: item);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteItem(item.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToAddScreen(),
        child: Icon(Icons.add),
      ),
    );
  }
}
