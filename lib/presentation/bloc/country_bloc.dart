import 'package:african_interview/core/usecase/country_usecase.dart';
import 'package:african_interview/domain/entities/country.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final GetAfricanCountries getAfricanCountries;
  final GetCountryDetails getCountryDetails;

  // Cache the last successfully loaded countries
  List<Country> _cachedCountries = [];

  CountriesBloc({
    required this.getAfricanCountries,
    required this.getCountryDetails,
  }) : super(CountriesInitialState()) {
    on<FetchAfricanCountriesEvent>(_onFetchAfricanCountries);
    on<FetchCountryDetailsEvent>(_onFetchCountryDetails);
    on<RefreshCountriesEvent>(_onRefreshCountries);
  }

  void _onFetchAfricanCountries(
      FetchAfricanCountriesEvent event, Emitter<CountriesState> emit) async {
    // If we have cached countries, emit them first
    if (_cachedCountries.isNotEmpty) {
      emit(CountriesLoadedState(_cachedCountries));
    } else {
      emit(CountriesLoadingState());
    }

    final result = await getAfricanCountries(NoParams());

    result.fold(
      (failure) {
        // If we have cached countries, keep them
        if (_cachedCountries.isNotEmpty) {
          emit(CountriesLoadedState(_cachedCountries));
        } else {
          emit(CountriesErrorState(failure.toString()));
        }
      },
      (countries) {
        _cachedCountries = countries;
        emit(CountriesLoadedState(countries));
      },
    );
  }

  void _onRefreshCountries(
      RefreshCountriesEvent event, Emitter<CountriesState> emit) async {
    emit(CountriesLoadingState());

    final result = await getAfricanCountries(NoParams());

    result.fold(
      (failure) => emit(CountriesErrorState(failure.toString())),
      (countries) {
        _cachedCountries = countries;
        emit(CountriesLoadedState(countries));
      },
    );
  }

  void _onFetchCountryDetails(
      FetchCountryDetailsEvent event, Emitter<CountriesState> emit) async {
    // If we have cached countries, keep the state
    if (state is CountriesLoadedState) {
      emit(state);
    } else {
      emit(CountryDetailsLoadingState());
    }

    final result = await getCountryDetails(event.countryName);

    result.fold(
      (failure) => emit(CountriesErrorState(failure.toString())),
      (countryDetails) => emit(CountryDetailsLoadedState(countryDetails)),
    );
  }
}
