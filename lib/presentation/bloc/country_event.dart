part of 'country_bloc.dart';

abstract class CountriesEvent extends Equatable {
  const CountriesEvent();

  @override
  List<Object> get props => [];
}

class FetchAfricanCountriesEvent extends CountriesEvent {}

class FetchCountryDetailsEvent extends CountriesEvent {
  final String countryName;

  const FetchCountryDetailsEvent(this.countryName);

  @override
  List<Object> get props => [countryName];
}
class RefreshCountriesEvent extends CountriesEvent {}