
import 'package:flutter/material.dart';
import 'package:videostream/providers/entry.dart';
import 'package:videostream/providers/watchlist.dart';
import 'package:videostream/screens/navigation.dart';
import 'package:videostream/screens/onboarding.dart';
import 'package:provider/provider.dart';

import 'providers/account.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AccountProvider()),
        ChangeNotifierProvider(create: (context) => EntryProvider()),
        ChangeNotifierProvider(create: (context) => WatchListProvider()),
      ],
      child: const Main(),
    )
  );
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VideoStream',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: context.read<AccountProvider>().isValid(),
        builder: (context, snapshot) => context.watch<AccountProvider>().session == null ? 
        const OnboardingScreen() : const NavScreen(),
      )
    );
  }
}