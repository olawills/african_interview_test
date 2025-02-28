import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String name;
  final String? officialName;
  final String? capital;
  final String flagUrl;
  final Map<String, dynamic>? languages;

  const Country({
    required this.name,
    this.officialName,
    this.capital,
    required this.flagUrl,
    this.languages,
  });

  @override
  List<Object?> get props => [name, officialName, capital, flagUrl, languages];
}

class CountryDetails extends Country {
  final String? region;
  final String? subregion;
  final int? population;
  final Map<String, dynamic>? currencies;
  final List<String>? borders;

  const CountryDetails({
    required super.name,
    super.officialName,
    super.capital,
    required super.flagUrl,
    super.languages,
    this.region,
    this.subregion,
    this.population,
    this.currencies,
    this.borders,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        region,
        subregion,
        population,
        currencies,
        borders,
      ];
}