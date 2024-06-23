import 'package:feedback_demo/feature/ab_testing/data/ab_test_repository.dart';
import 'package:feedback_demo/feature/ab_testing/data/experiment_config.dart';
import 'package:feedback_demo/feature/ab_testing/data/remote_config_remote_value_data_source.dart';
import 'package:feedback_demo/feature/ab_testing/data/remote_value_data_source.dart';
import 'package:feedback_demo/feature/ab_testing/presentation/ab_test_cubit.dart';
import 'package:feedback_demo/feature/analytics/analytics_service.dart';
import 'package:feedback_demo/feature/analytics/firebase_anaytics_service.dart';
import 'package:feedback_demo/feature/product/data/products_repository.dart';
import 'package:feedback_demo/feature/product/presentation/products_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registerDependencies() {
  getIt.registerLazySingleton<ProductsRepository>(
    () => ProductsRepository(),
  );
  getIt.registerFactory<ProductsCubit>(
    () => ProductsCubit(
      repository: getIt<ProductsRepository>(),
    ),
  );
  getIt.registerSingleton<RemoteValueDataSource>(
    RemoteConfigRemoteValueDataSource()..initialize(),
  );
  getIt.registerLazySingleton<ABTestRepository>(
    () => ABTestRepository(
      dataSource: getIt<RemoteValueDataSource>(),
    ),
  );
  getIt.registerLazySingleton<ABTestCubit>(
    () => ABTestCubit(
      repository: getIt<ABTestRepository>(),
      config: ExperimentConfig(),
    ),
  );
  getIt.registerLazySingleton<AnalyticsService>(
    () => FirebaseAnalyticsService(),
  );
}
