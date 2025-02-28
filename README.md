# African Countries Information App
##Overview
This Flutter application provides comprehensive information about African countries, offering users an interactive and informative experience to explore various details about different nations across the African continent.

```
lib/
│
├── core/
│   ├── error/
│   │   └── failures.dart
│   └── usecase/
│       └── country_usecase.dart
│
├── data/
│   ├── datasources/
│   │   ├── country_local_datasource.dart
│   │   └── country_remote_datasource.dart
│   ├── models/
│   │   ├── country_model.dart
│   │   └── country_details_model.dart
│   └── repositories/
│       └── country_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   ├── country.dart
│   │   └── country_details.dart
│   ├── repositories/
│   │   └── country_repository.dart
│   └── usecases/
│       ├── get_african_countries.dart
│       └── get_country_details.dart
│
├── presentation/
│   ├── bloc/
│   │   ├── country_bloc.dart
│   │   ├── country_event.dart
│   │   └── country_state.dart
│   ├── pages/
│   │   ├── splash/
│   │   │   └── splash_screen.dart
│   │   ├── country/
│   │   │   ├── countries_list_page.dart
│   │   │   └── countries_details_page.dart
│   │   └── ...
│   └── widgets/
│       └── ...
│
└── main.dart

```

Architecture
The project follows Clean Architecture principles, divided into three main layers:
1. Presentation Layer

Manages UI and user interactions
Uses BLoC (Business Logic Component) for state management
Contains:

Pages
Widgets
Bloc (State Management)



2. Domain Layer

Contains core business logic
Defines entities and use cases
Independent of UI and data sources

3. Data Layer

Handles data retrieval and caching
Implements repository interfaces
Contains:

Remote data sources
Local data sources
Repository implementations



Features

List of African Countries
Detailed Country Information
Pull-to-Refresh Functionality
Shimmer Loading Effect
Cached Network Images
Error Handling

State Management
Uses Flutter BLoC for state management with the following states:

CountriesInitialState
CountriesLoadingState
CountriesLoadedState
CountryDetailsLoadingState
CountryDetailsLoadedState
CountriesErrorState

Dependencies
Key dependencies:

flutter_bloc: State management
cached_network_image: Image caching
pull_to_refresh: Pull-to-refresh functionality
shimmer: Loading state animations
equatable: Equality comparisons

Setup and Installation
Prerequisites

Flutter SDK
Dart SDK
Android Studio or VS Code

Steps

1. Clone the repository
bash

```
git clone https://github.com/yourusername/african-countries-app.git
```
2. Install dependencies
bash
```
git clone https://github.com/yourusername/african-countries-app.git
```

3. Run the app
bash

```
flutter pub get
```

Error Handling
The app implements comprehensive error handling:

Network errors
Data parsing errors
Fallback UI for error states

Performance Optimizations

Cached network images
Efficient state management
Shimmer loading effects
Minimal rebuild strategies