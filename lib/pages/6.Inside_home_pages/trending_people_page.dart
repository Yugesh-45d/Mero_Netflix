import 'package:flutter/material.dart';

import '../../cubit/trending_section_cubit.dart';
import '../../models/others/movie_carousel_model.dart';

class TrendingPeoplePage extends StatelessWidget {
  final TrendingSectionLoadedState loadedState;

  const TrendingPeoplePage({super.key, required this.loadedState});

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    Size mySize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trending Celebrities",
          style: myTextTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 32,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 16,
          right: 8,
          bottom: 8,
        ),
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              for (var movie in loadedState.trendingPeopleModel.results!)
                MovieCarouselModel(
                  width: mySize.width / 2.25,
                  height: mySize.height / 3.2,
                  image: movie.profilePath.toString(),
                  rating: movie.popularity!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
