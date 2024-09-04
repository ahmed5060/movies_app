import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/utils/config_size.dart';
import 'package:movie/features/home/data/models/all_movies_model.dart';
import 'package:movie/features/home/presentation/component/search/search_screen.dart';
import 'package:movie/features/home/presentation/manager/movie_manager/movie_bloc.dart';
import 'package:movie/features/home/presentation/manager/movie_manager/movie_event.dart';
import 'package:movie/features/home/presentation/manager/movie_manager/movie_state.dart';
import 'package:movie/features/home/presentation/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int page = 1;
  int totalPages = 0;
  final scrollController = ScrollController();

  List<Results> data = [];

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (page < totalPages) {
        page = page + 1;
        BlocProvider.of<MovieBloc>(context).add(GetMoreMoviesEvent(page: page.toString()));
      }
    }
  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(child: Text("Movies", style: TextStyle(color: Colors.white),)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen()));
              },
              child: Container(
                height: ConfigSize.defaultSize! * 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.black,),
                      SizedBox(width: ConfigSize.defaultSize!,),
                      const Text("Search", style: TextStyle(color: Colors.black),),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is GetMoviesLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GetMoviesSuccessState) {
                    data = [];
                    for (final e in state.allMoviesModel.results!) {
                      data.add(e);
                    }
                    totalPages = state.allMoviesModel.totalPages!;
                    return GridView.builder(
                      controller: scrollController,
                      itemCount: data.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of cards in a row
                        childAspectRatio: 0.49, // Adjust the height of the cards
                        crossAxisSpacing: 10, // Horizontal spacing between cards
                        mainAxisSpacing: 10, // Vertical spacing between cards
                      ),
                      itemBuilder: (context, index) {
                        return MovieCard(results: data[index]);
                      },
                    );
                  } else if(state is GetMoreMoviesLoadingState){
                    return GridView.builder(
                      controller: scrollController,
                      itemCount: data.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of cards in a row
                        childAspectRatio: 0.49, // Adjust the height of the cards
                        crossAxisSpacing: 10, // Horizontal spacing between cards
                        mainAxisSpacing: 10, // Vertical spacing between cards
                      ),
                      itemBuilder: (context, index) {
                        return MovieCard(results: data[index]);
                      },
                    );
                  }else if(state is GetMoreMoviesSuccessState){
                    for (final e in state.allMoviesModel.results!) {
                      data.add(e);
                    }
                    return GridView.builder(
                      controller: scrollController,
                      itemCount: data.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of cards in a row
                        childAspectRatio: 0.49, // Adjust the height of the cards
                        crossAxisSpacing: 10, // Horizontal spacing between cards
                        mainAxisSpacing: 10, // Vertical spacing between cards
                      ),
                      itemBuilder: (context, index) {
                        return MovieCard(results: data[index]);
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
