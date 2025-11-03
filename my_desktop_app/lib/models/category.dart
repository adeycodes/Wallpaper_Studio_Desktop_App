class Category {
  final String id;
  final String name;
  final String description;
  final int wallpaperCount;
  final String thumbnail;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.wallpaperCount,
    required this.thumbnail,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'wallpaperCount': wallpaperCount,
      'thumbnail': thumbnail,
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      wallpaperCount: json['wallpaperCount'] as int,
      thumbnail: json['thumbnail'] as String,
    );
  }
}
