import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/configuration/grid_settings.dart';
import 'package:books_log_migration/models/my_books.dart';
import 'package:books_log_migration/models/my_reading_list.dart';
import 'package:books_log_migration/pages/authentication_pages/login_page.dart';
import 'package:books_log_migration/pages/my_books_page.dart';
import 'package:books_log_migration/services/auth_service.dart';
import 'package:books_log_migration/services/firestore_service.dart';
import 'package:books_log_migration/services/storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return Text('Error');
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Container();
    }

    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<FirestoreService>(create: (_) => FirestoreService()),
        Provider<StorageService>(create: (_) => StorageService()),
        ChangeNotifierProvider<MyBooks>(
            create: (_) => MyBooks(myBooksTitles: [], myBooksAuthors: [])),
        ChangeNotifierProvider<MyReadingList>(
            create: (_) => MyReadingList(
                myReadingListAuthors: [], myReadingListTitles: [])),
        ChangeNotifierProvider<GridSettings>(create: (_) => GridSettings()),
      ],
      builder: (context, child) => MaterialApp(
        title: 'Read Log',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.grey[900],
          scaffoldBackgroundColor: blackBackground,
          indicatorColor: Colors.green,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.green,
          ),
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
            },
          ),
          dividerTheme: DividerThemeData(thickness: 1.5),
        ),
        home: HomeController(),
      ),
    );
  }
}

class HomeController extends StatefulWidget {
  const HomeController({Key? key}) : super(key: key);

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<AuthService>().onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return MyBooksPage();
          } else {
            return LoginPage();
          }
        }
        return LoadingScreen();
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Loading...',
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
