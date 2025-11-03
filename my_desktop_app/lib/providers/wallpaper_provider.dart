import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/wallpaper.dart';
import '../models/category.dart';
import '../utils/dummy_data.dart';

class WallpaperProvider with ChangeNotifier {
  List<Category> _categories = [];
  List<Wallpaper> _wallpapers = [];
  Wallpaper? _activeWallpaper;
  String _displayMode = 'Fit';
  bool _autoRotation = false;
  bool _lockWallpaper = false;
  bool _syncAcrossDevices = false;
  String _imageQuality = 'High ( Best Quality )';
  bool _notificationsEnabled = true;

  List<Category> get categories => _categories;
  List<Wallpaper> get wallpapers => _wallpapers;
  Wallpaper? get activeWallpaper => _activeWallpaper;
  String get displayMode => _displayMode;
  bool get autoRotation => _autoRotation;
  bool get lockWallpaper => _lockWallpaper;
  bool get syncAcrossDevices => _syncAcrossDevices;
  String get imageQuality => _imageQuality;
  bool get notificationsEnabled => _notificationsEnabled;

  WallpaperProvider() {
    loadData();
    loadSettings();
  }

  void loadData() {
    _categories = DummyData.categories;
    _wallpapers = DummyData.wallpapers;

    // Set default active wallpaper
    if (_wallpapers.isNotEmpty && _activeWallpaper == null) {
      _activeWallpaper = _wallpapers.firstWhere(
        (w) => w.id == 'n1',
        orElse: () => _wallpapers.first,
      );
    }
    notifyListeners();
  }

  List<Wallpaper> getWallpapersByCategory(String category) {
    return _wallpapers.where((w) => w.category == category).toList();
  }

  void setActiveWallpaper(Wallpaper wallpaper) async {
    _activeWallpaper = wallpaper;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('activeWallpaperId', wallpaper.id);
  }

  void setDisplayMode(String mode) {
    _displayMode = mode;
    notifyListeners();
  }

  void toggleAutoRotation(bool value) {
    _autoRotation = value;
    notifyListeners();
  }

  void toggleLockWallpaper(bool value) {
    _lockWallpaper = value;
    notifyListeners();
  }

  void toggleSyncAcrossDevices(bool value) {
    _syncAcrossDevices = value;
    notifyListeners();
  }

  void setImageQuality(String quality) {
    _imageQuality = quality;
    notifyListeners();
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('displayMode', _displayMode);
    await prefs.setBool('autoRotation', _autoRotation);
    await prefs.setBool('lockWallpaper', _lockWallpaper);
    await prefs.setBool('syncAcrossDevices', _syncAcrossDevices);
    await prefs.setString('imageQuality', _imageQuality);
    await prefs.setBool('notificationsEnabled', _notificationsEnabled);
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _displayMode = prefs.getString('displayMode') ?? 'Fit';
    _autoRotation = prefs.getBool('autoRotation') ?? false;
    _lockWallpaper = prefs.getBool('lockWallpaper') ?? false;
    _syncAcrossDevices = prefs.getBool('syncAcrossDevices') ?? false;
    _imageQuality = prefs.getString('imageQuality') ?? 'High ( Best Quality )';
    _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;

    final activeWallpaperId = prefs.getString('activeWallpaperId');
    if (activeWallpaperId != null) {
      _activeWallpaper = _wallpapers.firstWhere(
        (w) => w.id == activeWallpaperId,
        orElse: () => _wallpapers.first,
      );
    }

    notifyListeners();
  }
}
