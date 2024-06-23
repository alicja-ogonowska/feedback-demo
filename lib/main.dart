import 'package:feedback_demo/di/service_locator.dart';
import 'package:feedback_demo/feature/ab_testing/presentation/ab_test_cubit.dart';
import 'package:feedback_demo/feature/product/presentation/product_list_screen.dart';
import 'package:feedback_demo/feature/product/presentation/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiredash/wiredash.dart';

void main() {
  registerDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: const String.fromEnvironment('PROJECT_ID'),
      secret: const String.fromEnvironment('SECRET'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt.get<ProductsCubit>()..loadProducts(),
          ),
          BlocProvider(
            create: (_) => getIt.get<ABTestCubit>()..loadExperiments(),
            lazy: false,
          )
        ],
        child: MaterialApp(
          title: 'Shopping App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
            useMaterial3: true,
          ),
          home: const ProductListScreen(),
        ),
      ),
    );
  }
}
