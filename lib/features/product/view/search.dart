import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcost/features/product/bloc/search_bloc.dart';
import 'package:rentcost/features/product/bloc/search_event.dart';
import 'package:rentcost/features/product/bloc/search_state.dart';
import 'package:rentcost/features/product/model/product.dart';
import 'package:rentcost/features/widget/card_costum_search.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    // Reset SearchBloc state
    context.read<SearchBloc>().add(SearchResetEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<SearchBloc>().add(SearchProductEvent(search: ''));
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            scrolledUnderElevation: 0.0,
            backgroundColor: Colors.white,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.go("/");
                  },
                  child: const SizedBox(
                    child: Icon(
                      FontAwesome.chevron_left_solid,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF881FFF)),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: const InputDecoration(
                              hintText: "Cari Kostum...",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 8.0,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            final query = searchController.text.trim();
                            if (query.isNotEmpty) {
                              context
                                  .read<SearchBloc>()
                                  .add(SearchProductEvent(search: query));
                            }
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFF881FFF),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(6.0),
                                bottomRight: Radius.circular(6.0),
                              ),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: const Icon(
                              Bootstrap.search,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchInitial) {
              return const Center(
                  child: Text("Masukkan kata kunci pencarian."));
            } else if (state is SearchLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SearchProductState) {
              List<ProductData> products = state.search;
              if (products.isEmpty) {
                return const Center(child: Text("Tidak ada hasil ditemukan."));
              }
              return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CardCostumSearch(costum: products));
            } else if (state is SearchFailure) {
              return Center(child: Text(state.error));
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
