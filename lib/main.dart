import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:notes_example/models/auth.dart';
import 'package:notes_example/models/notebook.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import './common/theme.dart';

import 'models/note.dart';
import 'screens/login_screen.dart';
import 'screens/note_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Directory _appDocDir = await getApplicationDocumentsDirectory();
  final String _appDocPath = _appDocDir.path;

  // await Hive.initFlutter();
  Hive
    ..init(_appDocPath)
    ..registerAdapter<Note>(NoteAdapter());

  await Hive.openBox('authBox');
  await Hive.openBox('noteBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        ChangeNotifierProvider(create: (context) => AuthState()),
        ChangeNotifierProvider(create: (context) => Notebook()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        /*ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            cart.catalog = catalog;
            return cart;
          },
        ),*/
      ],
      child: Consumer<AuthState>(
        builder: (context, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Notes',
          theme: appTheme,
          initialRoute: auth.authenticated ? '/notes' : '/',
          routes: {
            '/': (context) => LoginScreen(),
            '/register': (context) => LoginScreen(isLoginScreen: false),
            '/notes': (context) => NoteScreen(),
          },
        ),
      ),
    );
  }
}
