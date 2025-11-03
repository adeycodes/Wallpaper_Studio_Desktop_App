import '../models/category.dart';
import '../models/wallpaper.dart';

class DummyData {
  // Placeholder image path - will be used if actual images don't exist
  static const String placeholderImage = 'assets/images/placeholder.png';

  static final List<Category> categories = [
    Category(
      id: '1',
      name: 'Nature',
      description: 'Mountains, Forest and Landscapes',
      wallpaperCount: 6,
      // point to a real asset or use the placeholder if you don't have a specific thumb
      thumbnail: 'assets/images/categories/nature/nature1.jpg',
    ),
    Category(
      id: '2',
      name: 'Abstract',
      description: 'Modern Geomentric and artistic designs',
      wallpaperCount: 4,
      thumbnail: 'assets/images/categories/abstract/abstract1.jpg',
    ),
    Category(
      id: '3',
      name: 'Urban',
      description: 'Cities, architecture and street',
      wallpaperCount: 6,
      thumbnail: 'assets/images/categories/urban/urban1.jpg',
    ),
    Category(
      id: '4',
      name: 'Space',
      description: 'Cosmos, planets, and galaxies',
      wallpaperCount: 3,
      thumbnail: 'assets/images/categories/space/space1.jpg',
    ),
    Category(
      id: '5',
      name: 'Minimalist',
      description: 'Clean, simple, and elegant',
      wallpaperCount: 6,
      thumbnail: 'assets/images/categories/minimalist/minimalist1.jpg',
    ),
    Category(
      id: '6',
      name: 'Animals',
      description: 'Wildlife and nature photography',
      wallpaperCount: 4,
      thumbnail: 'assets/images/categories/animals/animals1.jpg',
    ),
  ];

  static final List<Wallpaper> wallpapers = [
    // Nature - 6 wallpapers
    Wallpaper(
      id: 'n1',
      name: 'Autumn Forest Path',
      imageUrl: 'assets/images/categories/nature/nature1.jpg',
      category: 'Nature',
      tags: ['Nature', 'Forest', 'Autumn'],
      description:
          'Magical autumn forest path with fallen leaves and morning light.',
    ),
    Wallpaper(
      id: 'n2',
      name: 'Mountain Sunset',
      imageUrl: 'assets/images/categories/nature/nature2.jpg',
      category: 'Nature',
      tags: ['Nature', 'Mountains', 'Sunset'],
      description:
          'Dramatic mountain landscape with misty cliffs and sunset sky.',
    ),
    Wallpaper(
      id: 'n3',
      name: 'Nature 3',
      imageUrl: 'assets/images/categories/nature/nature3.jpg',
      category: 'Nature',
      tags: ['Nature', 'Forest', 'Autumn'],
      description: 'Stunning autumn forest path with vibrant fall colors.',
    ),
    Wallpaper(
      id: 'n4',
      name: 'Nature 4',
      imageUrl: 'assets/images/categories/nature/nature4.jpg',
      category: 'Nature',
      tags: ['Nature', 'Sunset', 'Lake'],
      description: 'Peaceful sunset reflection over a calm mountain lake.',
    ),
    Wallpaper(
      id: 'n5',
      name: 'Nature 5',
      imageUrl: 'assets/images/categories/nature/nature5.jpg',
      category: 'Nature',
      tags: ['Nature', 'Night', 'Stars'],
      description: 'Starry night sky over majestic mountain peaks.',
    ),
    Wallpaper(
      id: 'n6',
      name: 'Nature 6',
      imageUrl: 'assets/images/categories/nature/nature6.jpg',
      category: 'Nature',
      tags: ['Nature', 'Waterfall', 'Bridge'],
      description: 'Mystical waterfall with ancient stone bridge architecture.',
    ),

    // Abstract - 4 wallpapers
    Wallpaper(
      id: 'a1',
      name: 'Abstract 1',
      imageUrl: 'assets/images/categories/abstract/abstract1.jpg',
      category: 'Abstract',
      tags: ['Abstract', 'Colorful', 'Waves'],
      description: 'Vibrant flowing waves in purple and blue gradients.',
    ),
    Wallpaper(
      id: 'a2',
      name: 'Abstract 2',
      imageUrl: 'assets/images/categories/abstract/abstract2.jpg',
      category: 'Abstract',
      tags: ['Abstract', 'Geometric', 'Modern'],
      description: 'Modern geometric patterns with bold color combinations.',
    ),
    Wallpaper(
      id: 'a3',
      name: 'Abstract 3',
      imageUrl: 'assets/images/categories/abstract/abstract3.jpg',
      category: 'Abstract',
      tags: ['Abstract', 'Fluid', 'Art'],
      description: 'Fluid art with organic shapes and transitions.',
    ),
    Wallpaper(
      id: 'a4',
      name: 'Abstract 4',
      imageUrl: 'assets/images/categories/abstract/abstract4.jpg',
      category: 'Abstract',
      tags: ['Abstract', 'Digital', 'Contemporary'],
      description: 'Contemporary digital art with striking visual elements.',
    ),

    // Urban - 6 wallpapers
    Wallpaper(
      id: 'u1',
      name: 'Urban 1',
      imageUrl: 'assets/images/categories/urban/urban1.jpg',
      category: 'Urban',
      tags: ['Urban', 'Architecture', 'Modern'],
      description: 'Modern architectural design with geometric patterns.',
    ),
    Wallpaper(
      id: 'u2',
      name: 'Urban 2',
      imageUrl: 'assets/images/categories/urban/urban2.jpg',
      category: 'Urban',
      tags: ['Urban', 'City', 'Night'],
      description: 'City lights and urban skyline at night.',
    ),
    Wallpaper(
      id: 'u3',
      name: 'Urban 3',
      imageUrl: 'assets/images/categories/urban/urban3.jpg',
      category: 'Urban',
      tags: ['Urban', 'Street', 'Photography'],
      description: 'Street photography capturing urban life.',
    ),
    Wallpaper(
      id: 'u4',
      name: 'Urban 4',
      imageUrl: 'assets/images/categories/urban/urban4.jpg',
      category: 'Urban',
      tags: ['Urban', 'Building', 'Design'],
      description: 'Innovative building design and structure.',
    ),
    Wallpaper(
      id: 'u5',
      name: 'Urban 5',
      imageUrl: 'assets/images/categories/urban/urban5.jpg',
      category: 'Urban',
      tags: ['Urban', 'Cityscape', 'Aerial'],
      description: 'Aerial view of sprawling city landscape.',
    ),
    Wallpaper(
      id: 'u6',
      name: 'Urban 6',
      imageUrl: 'assets/images/categories/urban/urban6.jpg',
      category: 'Urban',
      tags: ['Urban', 'Metro', 'Infrastructure'],
      description: 'Metropolitan infrastructure and transport systems.',
    ),

    // Space - 3 wallpapers
    Wallpaper(
      id: 's1',
      name: 'Space 1',
      imageUrl: 'assets/images/categories/space/space1.jpg',
      category: 'Space',
      tags: ['Space', 'Galaxy', 'Stars'],
      description: 'Spiral galaxy with billions of stars.',
    ),
    Wallpaper(
      id: 's2',
      name: 'Space 2',
      imageUrl: 'assets/images/categories/space/space2.jpg',
      category: 'Space',
      tags: ['Space', 'Nebula', 'Cosmic'],
      description: 'Colorful nebula clouds in deep space.',
    ),
    Wallpaper(
      id: 's3',
      name: 'Space 3',
      imageUrl: 'assets/images/categories/space/space3.jpg',
      category: 'Space',
      tags: ['Space', 'Planet', 'Universe'],
      description: 'Planetary system and celestial bodies.',
    ),

    // Minimalist - 6 wallpapers
    Wallpaper(
      id: 'm1',
      name: 'Minimalist 1',
      imageUrl: 'assets/images/categories/minimalist/minimalist1.jpg',
      category: 'Minimalist',
      tags: ['Minimalist', 'Simple', 'Clean'],
      description: 'Clean and simple minimalist design.',
    ),
    Wallpaper(
      id: 'm2',
      name: 'Minimalist 2',
      imageUrl: 'assets/images/categories/minimalist/minimalist2.jpg',
      category: 'Minimalist',
      tags: ['Minimalist', 'Zen', 'Calm'],
      description: 'Zen-inspired calming minimalist aesthetic.',
    ),
    Wallpaper(
      id: 'm3',
      name: 'Minimalist 3',
      imageUrl: 'assets/images/categories/minimalist/minimalist3.jpg',
      category: 'Minimalist',
      tags: ['Minimalist', 'Neutral', 'Elegant'],
      description: 'Elegant neutral tones and simple forms.',
    ),
    Wallpaper(
      id: 'm4',
      name: 'Minimalist 4',
      imageUrl: 'assets/images/categories/minimalist/minimalist4.jpg',
      category: 'Minimalist',
      tags: ['Minimalist', 'Monochrome', 'Modern'],
      description: 'Modern monochrome minimalist composition.',
    ),
    Wallpaper(
      id: 'm5',
      name: 'Minimalist 5',
      imageUrl: 'assets/images/categories/minimalist/minimalist5.jpg',
      category: 'Minimalist',
      tags: ['Minimalist', 'Subtle', 'Refined'],
      description: 'Refined and subtle minimalist design.',
    ),
    Wallpaper(
      id: 'm6',
      name: 'Minimalist 6',
      imageUrl: 'assets/images/categories/minimalist/minimalist6.jpg',
      category: 'Minimalist',
      tags: ['Minimalist', 'Pure', 'Essence'],
      description: 'Pure essence of minimalist philosophy.',
    ),

    // Animals - 4 wallpapers
    Wallpaper(
      id: 'an1',
      name: 'Animals 1',
      imageUrl: 'assets/images/categories/animals/animals1.jpg',
      category: 'Animals',
      tags: ['Animals', 'Wildlife', 'Fox'],
      description: 'Beautiful wildlife photography of a red fox.',
    ),
    Wallpaper(
      id: 'an2',
      name: 'Animals 2',
      imageUrl: 'assets/images/categories/animals/animals2.jpg',
      category: 'Animals',
      tags: ['Animals', 'Bird', 'Nature'],
      description: 'Stunning bird photography in natural habitat.',
    ),
    Wallpaper(
      id: 'an3',
      name: 'Animals 3',
      imageUrl: 'assets/images/categories/animals/animals3.jpg',
      category: 'Animals',
      tags: ['Animals', 'Mammal', 'Wild'],
      description: 'Wild mammal in its natural environment.',
    ),
    Wallpaper(
      id: 'an4',
      name: 'Animals 4',
      imageUrl: 'assets/images/categories/animals/animals4.jpg',
      category: 'Animals',
      tags: ['Animals', 'Predator', 'Majestic'],
      description: 'Majestic predator wildlife photography.',
    ),
  ];

  static List<Wallpaper> getWallpapersByCategory(String category) {
    return wallpapers.where((w) => w.category == category).toList();
  }

  static Category? getCategoryByName(String name) {
    try {
      return categories.firstWhere((c) => c.name == name);
    } catch (e) {
      return null;
    }
  }

  static Wallpaper? getWallpaperById(String id) {
    try {
      return wallpapers.firstWhere((w) => w.id == id);
    } catch (e) {
      return null;
    }
  }
}
