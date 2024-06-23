import 'package:feedback_demo/di/service_locator.dart';
import 'package:feedback_demo/feature/product/presentation/product_list_screen.dart';
import 'package:feedback_demo/feature/product/presentation/products_cubit.dart';
import 'package:feedback_demo/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_installations/firebase_installations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiredash/wiredash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  registerDependencies();

  FirebaseMessaging.instance
      .getToken()
      .then((value) => debugPrint("Firebase token: $value"));

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: const String.fromEnvironment('PROJECT_ID'),
      secret: const String.fromEnvironment('SECRET'),
      child: MaterialApp(
        title: 'Shopping App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        home: BlocProvider(
          create: (_) => getIt.get<ProductsCubit>()..loadProducts(),
          child: const ProductListScreen(),
        ),
      ),
    );
  }
}
