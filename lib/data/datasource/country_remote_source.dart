import 'dart:convert';

import 'package:african_interview/core/error/failures.dart';
import 'package:african_interview/data/model/country_model.dart';
import 'package:http/http.dart' as http;

abstract class CountriesRemoteDataSource {
  Future<List<CountryModel>> getAfricanCountries();
  Future<CountryDetailsModel> getCountryDetails(String name);
}

class CountriesRemoteDataSourceImpl implements CountriesRemoteDataSource {
  final http.Client client;

  CountriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CountryModel>> getAfricanCountries() async {
    final response = await client.get(
      Uri.parse(
          'https://restcountries.com/v3.1/region/africa?fields=name,languages,capital,flags'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> parsedList = json.decode(response.body);
      return parsedList
          .map((countryJson) => CountryModel.fromJson(countryJson))
          .toList();
    } else {
      throw ServerFailure('Failed to load African countries');
    }
  }

  @override
  Future<CountryDetailsModel> getCountryDetails(String name) async {
    final response = await client.get(
      Uri.parse('https://restcountries.com/v3.1/name/$name'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> parsedList = json.decode(response.body);
      return CountryDetailsModel.fromJson(parsedList.first);
    } else {
      throw ServerFailure('Failed to load country details');
    }
  }
}
