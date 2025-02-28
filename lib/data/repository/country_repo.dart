import 'package:african_interview/data/datasource/country_remote_source.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/country.dart';
import '../../domain/repository/country_repo_interface.dart';

class CountriesRepositoryImpl implements CountriesRepository {
  final CountriesRemoteDataSource remoteDataSource;

  CountriesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Country>>> getAfricanCountries() async {
    try {
      final countries = await remoteDataSource.getAfricanCountries();
      return Right(countries);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch African countries: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, CountryDetails>> getCountryDetails(String name) async {
    try {
      final countryDetails = await remoteDataSource.getCountryDetails(name);
      return Right(countryDetails);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch country details: ${e.toString()}'));
    }
  }
}