import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/cubit/movie_details_cubit.dart';
import 'package:netflix/models/others/readmore_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../models/others/movie_listtile_model.dart';
import '../../routes/app_route_constant.dart';

class MoviePlayingScreen extends StatefulWidget {
  final String name;
  final String movieKey;
  final MovieDetailsLoadedState loadedState;
  const MoviePlayingScreen({
    super.key,
    required this.movieKey,
    required this.loadedState,
    required this.name,
  });

  @override
  State<MoviePlayingScreen> createState() => _MoviePlayingScreenState();
}

class _MoviePlayingScreenState extends State<MoviePlayingScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.movieKey,
      flags: const YoutubePlayerFlags(
        enableCaption: false,
        controlsVisibleAtStart: true,
        forceHD: true,
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    _controller.pause();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    TextTheme myTextTheme = Theme.of(context).textTheme;
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        // thumbnail: ,
        aspectRatio: 16 / 9,
        topActions: [
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              // _controller.metadata.title,
              widget.name.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const PlaybackSpeedButton(),
          const SizedBox(width: 12.0),
        ],
        bottomActions: [
          CurrentPosition(),
          const SizedBox(width: 10.0),
          ProgressBar(
            isExpanded: true,
            colors: ProgressBarColors(
              playedColor: myColorScheme.onTertiary,
              handleColor: myColorScheme.onTertiary,
            ),
          ),
          const SizedBox(width: 10.0),
          RemainingDuration(),
          FullScreenButton(),
        ],
        controller: _controller,
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.loadedState.movieDetailsModel.title!),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                player,
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 16,
                    right: 16,
                  ),
                  child: Text(
                    widget.name,
                    style: myTextTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    bottom: 8,
                    right: 16,
                    top: 8,
                  ),
                  child: ReadMoreModel(
                    text: widget.loadedState.movieDetailsModel.overview!,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "More Videos",
                      style: myTextTheme.headlineSmall,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: List.generate(
                        widget.loadedState.movieDetailsModel.videos!.results!
                            .length, (index) {
                      final movieVidoes =
                          widget.loadedState.movieDetailsModel.videos!;
                      return GestureDetector(
                        onTap: () {
                          GoRouter.of(context).pushNamed(
                            MyAppRouteConstants.moviePlayingPage,
                            extra: widget.loadedState,
                            pathParameters: {
                              'movieKey': movieVidoes.results![index].key!,
                              'name': movieVidoes.results![index].name!,
                            },
                          );
                        },
                        child: MovieListTileModel(
                          image: widget
                              .loadedState.movieDetailsModel.backdropPath!,
                          name: movieVidoes.results![index].name!,
                          description:
                              movieVidoes.results![index].size.toString(),
                          date: movieVidoes.results![index].publishedAt!.year
                              .toString(),
                          tag: movieVidoes.results![index].type!,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
