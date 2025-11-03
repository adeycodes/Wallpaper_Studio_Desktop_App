class Wallpaper {
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  final List<String> tags;
  final String description;

  Wallpaper({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.tags,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'category': category,
      'tags': tags,
      'description': description,
    };
  }

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    return Wallpaper(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      tags: List<String>.from(json['tags'] as List),
      description: json['description'] as String,
    );
  }

  Wallpaper copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? category,
    List<String>? tags,
    String? description,
  }) {
    return Wallpaper(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      description: description ?? this.description,
    );
  }
}
