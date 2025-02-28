import 'package:african_interview/presentation/bloc/country_bloc.dart';
import 'package:african_interview/presentation/pages/country/countries_details_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

late RefreshController _refreshController;

class CountriesListPage extends StatefulWidget {
  const CountriesListPage({super.key});

  @override
  CountriesListPageState createState() => CountriesListPageState();
}

class CountriesListPageState extends State<CountriesListPage> {
  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    //** */ Fetch African countries when the page loads
    context.read<CountriesBloc>().add(FetchAfricanCountriesEvent());
  }

  Future<void> _onRefresh() async {
    context.read<CountriesBloc>().add(RefreshCountriesEvent());
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('African Countries'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<CountriesBloc, CountriesState>(
          builder: (context, state) {
            return SmartRefresher(
                header: const WaterDropHeader(),
                enablePullDown: true,
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: state is CountriesLoadingState
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.3),
                        highlightColor: Colors.grey.withOpacity(0.1),
                        child: _CountryPageShimmer())
                    : state is CountriesLoadedState
                        ? ListView.builder(
                            itemCount: state.countries.length,
                            itemBuilder: (context, index) {
                              final country = state.countries[index];
                              return ListTile(
                                leading: CachedNetworkImage(
                                  imageUrl: country.flagUrl,
                                  width: 50,
                                  height: 30,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.3),
                                      highlightColor:
                                          Colors.grey.withOpacity(0.1),
                                      child: Image.network(
                                          'https://api.dicebear.com/5.x/big-ears-neutral/png?seed')),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                title: Text(country.name),
                                subtitle: Text(country.capital ?? 'N/A'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CountryDetailsPage(
                                        countryName: country.name,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Something went wrong',
                                  style: const TextStyle(color: Colors.red),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Pull to refresh',
                                ),
                              ],
                            ),
                          ));

            // return const Center(child: Text('No countries found'));
          },
        ),
      ),
    );
  }
}

class _CountryPageShimmer extends StatelessWidget {
  const _CountryPageShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CachedNetworkImage(
            imageUrl: 'https://api.dicebear.com/5.x/big-ears-neutral/png?seed',
            width: 50,
            height: 30,
            fit: BoxFit.cover,
            placeholder: (context, url) => Image.network(
                'https://api.dicebear.com/5.x/big-ears-neutral/png?seed'),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          title: Text('Nigeria'),
          subtitle: Text('Abuja'),
        );
      },
    );
  }
}
