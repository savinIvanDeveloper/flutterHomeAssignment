import 'package:home_assignment/app/provider/app_provider.dart';
import 'package:home_assignment/features/contacts/data/contacts_repo.dart';
import 'package:home_assignment/features/contacts/data/contacts_service.dart';
import 'package:home_assignment/features/contacts/provider/contacts_provider.dart';
import 'package:home_assignment/features/weather/data/weather_repo.dart';
import 'package:home_assignment/features/weather/data/weather_service.dart';
import 'package:home_assignment/features/weather/provider/weather_provider.dart';

import 'package:home_assignment/app/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(
          create: (_) =>
              ContactsProvider(repo: ContactsRepo(service: ContactsService())),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              WeatherProvider(repo: WeatherRepo(service: WeatherService())),
        ),
      ],
      child: const HomeAssignmentApp(),
    ),
  );
}
