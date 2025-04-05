import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/data/api/api_service.dart';
import 'package:tourism_app/provider/detail/bookmark_list_provider.dart';
import 'package:tourism_app/provider/home/tourism_list_provider.dart';
import 'package:tourism_app/provider/main/index_nav_provider.dart';
import 'package:tourism_app/screen/detail/detail_screen.dart';
import 'package:tourism_app/screen/main/main_screen.dart';
import 'package:tourism_app/screen/navigation_route.dart';
import 'package:tourism_app/style/theme/tourism_theme.dart';

import 'provider/detail/tourism_detail_provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => IndexNavProvider(),
          ),
          ChangeNotifierProvider(
              create: (context) => BookmarkListProvider()),
          Provider(
            create: (context) => ApiService(),
          ),
          ChangeNotifierProvider(
            create: (context) => TourismListProvider(
              context.read<ApiService>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => TourismDetailProvider(
              context.read<ApiService>(),
            ),
          ),
        ],
        child: const MainApp(),
      ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: TourismTheme.lightTheme,
      darkTheme: TourismTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
          tourismId: ModalRoute.of(context)!.settings.arguments as int,
        ),
      },
    );
  }
}
