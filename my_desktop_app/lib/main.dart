import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/wallpaper_provider.dart';
import 'providers/favorites_provider.dart';
import 'utils/colors.dart';

void main() {
  runApp(const WallpaperStudioApp());
}

class WallpaperStudioApp extends StatelessWidget {
  const WallpaperStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WallpaperProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: MaterialApp(
        title: 'Wallpaper Studio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryOrange,
            primary: AppColors.primaryOrange,
          ),
          scaffoldBackgroundColor: AppColors.background,
          fontFamily: 'Inter',
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
