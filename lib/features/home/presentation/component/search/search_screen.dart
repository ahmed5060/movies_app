import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/utils/config_size.dart';
import 'package:movie/features/home/presentation/manager/search_manager/search_bloc.dart';
import 'package:movie/features/home/presentation/manager/search_manager/search_event.dart';
import 'package:movie/features/home/presentation/manager/search_manager/search_state.dart';
import 'package:movie/features/home/presentation/widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: ConfigSize.defaultSize! * 6.5,
              width: ConfigSize.screenWidth,
              child: Padding(
                padding: EdgeInsets.all(ConfigSize.defaultSize!),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: ConfigSize.defaultSize! * 3,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: ConfigSize.defaultSize! * 3,
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          BlocProvider.of<SearchBloc>(context).add(
                              SearchEvent(
                                  query: searchController.text));
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          hintText: 'Search...',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchSuccessState) {
                    if(state.allMoviesModel.results!.isEmpty){
                      return Center(child: Text('No Data Found', style: TextStyle(fontSize: ConfigSize.defaultSize! * 2, color: Colors.white, fontWeight: FontWeight.bold),),);
                    }else {
                      return GridView.builder(
                        itemCount: state.allMoviesModel.results!.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of cards in a row
                          childAspectRatio: 0.49, // Adjust the height of the cards
                          crossAxisSpacing: 10, // Horizontal spacing between cards
                          mainAxisSpacing: 10, // Vertical spacing between cards
                        ),
                        itemBuilder: (context, index) {
                          return MovieCard(results: state.allMoviesModel.results![index]);
                        },
                      );
                    }
                  } else if (state is SearchLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  } else {
                    return Center(child: Text('No Data Found', style: TextStyle(fontSize: ConfigSize.defaultSize! * 2, color: Colors.white, fontWeight: FontWeight.bold),),);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
