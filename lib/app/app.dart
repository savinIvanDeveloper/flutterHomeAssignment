import 'package:flutter/material.dart';
import 'package:home_assignment/app/provider/app_provider.dart';
import 'package:home_assignment/core/app_theme.dart';
import 'package:home_assignment/features/contacts/provider/contacts_provider.dart';
import 'package:home_assignment/features/contacts/screens/search_contacts_screen.dart';
import 'package:home_assignment/features/contacts/screens/search_history_screen.dart';
import 'package:home_assignment/features/weather/provider/weather_provider.dart';
import 'package:home_assignment/features/weather/screens/weather_screen.dart';
import 'package:provider/provider.dart';

class HomeAssignmentApp extends StatelessWidget {
  const HomeAssignmentApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().fetchWeather();
      context.read<ContactsProvider>().loadSearchHistory();
    });
    return MaterialApp(
      title: 'Home Assignment App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: MainTabView(),
    );
  }
}

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<StatefulWidget> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  final _screens = [
    SearchContactScreen(),
    WeatherScreen(),
    SearchHistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final selectedIndex = provider.currentTabIndex;

    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _screens[selectedIndex]),
          if (selectedIndex != 1) _weatherLine,
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.person), label: 'Contacts'),
          NavigationDestination(icon: Icon(Icons.sunny), label: 'Weather'),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'Search history',
          ),
        ],
        onDestinationSelected: (index) {
          provider.setCurrentTabBy(index);
        },
      ),
    );
  }

  Widget get _weatherLine {
    final provider = context.watch<WeatherProvider>();
    final weather = provider.weather;
    if (weather != null) {
      return Container(
        color: Colors.blue.shade50,
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            '${weather.cityName}: ${weather.main}, ${weather.temp.toStringAsFixed(1)}°C',
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
