import 'package:african_interview/core/usecase/country_usecase.dart';
import 'package:african_interview/data/datasource/country_remote_source.dart';
import 'package:african_interview/data/repository/country_repo.dart';
import 'package:african_interview/domain/repository/country_repo_interface.dart';
import 'package:african_interview/presentation/bloc/country_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

void init() {
  // Bloc
  sl.registerFactory(
    () => CountriesBloc(
      getAfricanCountries: sl(),
      getCountryDetails: sl(),
    ),
  );

  //** Use cases
  sl.registerLazySingleton(() => GetAfricanCountries(sl()));
  sl.registerLazySingleton(() => GetCountryDetails(sl()));

  //** Repository
  sl.registerLazySingleton<CountriesRepository>(
    () => CountriesRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  //** Data sources
  sl.registerLazySingleton<CountriesRemoteDataSource>(
    () => CountriesRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}
