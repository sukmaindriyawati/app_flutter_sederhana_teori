class Item {
  final int id; // Pastikan ada ID
  String name;
  String description;

  Item({required this.id, required this.name, required this.description});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['title'] ?? 'No Title',
      description: json['body'] ?? 'No Description',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'body': description,
    };
  }
}
