import 'package:advicer/0_data/datasources/advice_remote_datasources.dart';
import 'package:advicer/0_data/repositories/advice_repo_impl.dart';
import 'package:advicer/1_domain/repositories/advice_repo.dart';
import 'package:advicer/1_domain/usecases/advice_usecases.dart';
import 'package:advicer/2_application/pages/advice/cubit/advice_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.I;

Future<void> init() async {

  sl.registerFactory(() => AdviceCubit(adviceUsecases: sl()));

  sl.registerFactory(() => AdviceUsecases(adviceRepo: sl()));

  sl.registerFactory<AdviceRepo>(
      () => AdviceRepoImpl(adviceRemoteDataSourceImpl: sl()));
  sl.registerFactory<AdviceRemoteDataSource>(
      () => AdviceRemoteDataSourceImpl(client: sl()));

  sl.registerFactory(() => http.Client());
}
