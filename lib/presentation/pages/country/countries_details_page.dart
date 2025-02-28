import 'package:african_interview/presentation/bloc/country_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CountryDetailsPage extends StatefulWidget {
  final String countryName;

  const CountryDetailsPage({super.key, required this.countryName});

  @override
  CountryDetailsPageState createState() => CountryDetailsPageState();
}

class CountryDetailsPageState extends State<CountryDetailsPage> {
  @override
  void initState() {
    super.initState();
    //** Fetch country details when the page loads
    context.read<CountriesBloc>().add(
          FetchCountryDetailsEvent(widget.countryName),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.countryName),
        centerTitle: true,
      ),
      body: BlocBuilder<CountriesBloc, CountriesState>(
        builder: (context, state) {
          if (state is CountryDetailsLoadingState) {
            return Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(0.3),
                highlightColor: Colors.grey.withOpacity(0.1),
                child: _DetailsPageSimmer());
          } else if (state is CountryDetailsLoadedState) {
            final country = state.countryDetails;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: country.flagUrl,
                      width: 200,
                      height: 120,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildDetailRow(
                      'Official Name', country.officialName ?? 'N/A'),
                  _buildDetailRow('Capital', country.capital ?? 'N/A'),
                  _buildDetailRow('Region', country.region ?? 'N/A'),
                  _buildDetailRow('Subregion', country.subregion ?? 'N/A'),
                  _buildDetailRow(
                      'Population',
                      country.population != null
                          ? _formatPopulation(country.population!)
                          : 'N/A'),

                  // Languages
                  if (country.languages != null)
                    _buildLanguagesSection(country.languages!),

                  // Currencies
                  if (country.currencies != null)
                    _buildCurrenciesSection(country.currencies!),

                  // Borders
                  if (country.borders != null && country.borders!.isNotEmpty)
                    _buildBordersSection(country.borders!),
                ],
              ),
            );
          } else if (state is CountriesErrorState) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.3),
              highlightColor: Colors.grey.withOpacity(0.1),
              child: _DetailsPageSimmer());
        },
      ),
    );
  }
}

Widget _buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLanguagesSection(Map<String, dynamic> languages) {
  final languagesList = languages.values.toList();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
        child: Text(
          'Languages:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: languagesList
            .map((language) => Chip(
                  label: Text(language),
                  backgroundColor: Colors.green.shade100,
                ))
            .toList(),
      ),
    ],
  );
}

Widget _buildCurrenciesSection(Map<String, dynamic> currencies) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
        child: Text(
          'Currencies:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: currencies.entries.map((entry) {
          final currencyName = entry.value['name'] ?? 'N/A';
          final currencySymbol = entry.value['symbol'] ?? 'N/A';
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              '$currencyName ($currencySymbol)',
              style: const TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
      ),
    ],
  );
}

Widget _buildBordersSection(List<String> borders) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
        child: Text(
          'Bordering Countries:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: borders
            .map((border) => Chip(
                  label: Text(border),
                  backgroundColor: Colors.blue.shade100,
                ))
            .toList(),
      ),
    ],
  );
}

// Helper method to format population with commas
String _formatPopulation(int population) {
  return population.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
}

class _DetailsPageSimmer extends StatelessWidget {
  const _DetailsPageSimmer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CachedNetworkImage(
              imageUrl:
                  'https://api.dicebear.com/5.x/big-ears-neutral/png?seed',
              width: 200,
              height: 120,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 20),
          _buildDetailRow('Official Name', 'N/A'),
          _buildDetailRow('Capital', 'N/A'),
          _buildDetailRow('Region', 'N/A'),
          _buildDetailRow('Subregion', 'N/A'),
          _buildDetailRow('Population', 'N/A'),
        ],
      ),
    );
  }
}
