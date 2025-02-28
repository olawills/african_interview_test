part of 'country_bloc.dart';

abstract class CountriesState extends Equatable {
  const CountriesState();

  @override
  List<Object> get props => [];
}

class CountriesInitialState extends CountriesState {}

class CountriesLoadingState extends CountriesState {}

class CountriesLoadedState extends CountriesState {
  final List<Country> countries;

  const CountriesLoadedState(this.countries);

  @override
  List<Object> get props => [countries];
}

class CountryDetailsLoadingState extends CountriesState {}

class CountryDetailsLoadedState extends CountriesState {
  final CountryDetails countryDetails;

  const CountryDetailsLoadedState(this.countryDetails);

  @override
  List<Object> get props => [countryDetails];
}

class CountriesErrorState extends CountriesState {
  final String message;

  const CountriesErrorState(this.message);

  @override
  List<Object> get props => [message];
}
