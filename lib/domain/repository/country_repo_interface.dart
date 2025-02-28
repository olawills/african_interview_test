import 'package:african_interview/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/country.dart';

abstract class CountriesRepository {
  Future<Either<Failure, List<Country>>> getAfricanCountries();
  Future<Either<Failure, CountryDetails>> getCountryDetails(String name);
}