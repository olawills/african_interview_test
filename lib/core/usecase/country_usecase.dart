import 'package:african_interview/core/error/failures.dart';
import 'package:african_interview/domain/entities/country.dart';
import 'package:african_interview/domain/repository/country_repo_interface.dart';
import 'package:dartz/dartz.dart';

class GetAfricanCountries implements UseCase<List<Country>, NoParams> {
  final CountriesRepository repository;

  GetAfricanCountries(this.repository);

  @override
  Future<Either<Failure, List<Country>>> call(NoParams params) async {
    return await repository.getAfricanCountries();
  }
}

class GetCountryDetails implements UseCase<CountryDetails, String> {
  final CountriesRepository repository;

  GetCountryDetails(this.repository);

  @override
  Future<Either<Failure, CountryDetails>> call(String name) async {
    return await repository.getCountryDetails(name);
  }
}

// Base UseCase abstract class
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}