import '../../domain/entities/country.dart';

class CountryModel extends Country {
  const CountryModel({
    required super.name,
    super.officialName,
    super.capital,
    required super.flagUrl,
    super.languages,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name']['common'] ?? '',
      officialName: json['name']['official'] ?? '',
      capital: json['capital'] != null ? json['capital'][0] : null,
      flagUrl: json['flags']['png'] ?? '',
      languages: json['languages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': {
        'common': name,
        'official': officialName,
      },
      'capital': capital != null ? [capital] : null,
      'flags': {'png': flagUrl},
      'languages': languages,
    };
  }
}

class CountryDetailsModel extends CountryDetails {
  const CountryDetailsModel({
    required super.name,
    super.officialName,
    super.capital,
    required super.flagUrl,
    super.languages,
    super.region,
    super.subregion,
    super.population,
    super.currencies,
    super.borders,
  });

  factory CountryDetailsModel.fromJson(Map<String, dynamic> json) {
    return CountryDetailsModel(
      name: json['name']['common'] ?? '',
      officialName: json['name']['official'] ?? '',
      capital: json['capital'] != null ? json['capital'][0] : null,
      flagUrl: json['flags']['png'] ?? '',
      languages: json['languages'],
      region: json['region'],
      subregion: json['subregion'],
      population: json['population'],
      currencies: json['currencies'],
      borders: json['borders'] != null 
        ? List<String>.from(json['borders'])
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': {
        'common': name,
        'official': officialName,
      },
      'capital': capital != null ? [capital] : null,
      'flags': {'png': flagUrl},
      'languages': languages,
      'region': region,
      'subregion': subregion,
      'population': population,
      'currencies': currencies,
      'borders': borders,
    };
  }}