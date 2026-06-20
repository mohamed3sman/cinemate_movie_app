import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/features/movie_detail/presentation/blocs/trailer_cubit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPlayerView extends StatelessWidget {
  final String videoKey;

  const TrailerPlayerView({super.key, required this.videoKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrailerCubit, TrailerState>(
      builder: (context, state) {
        if (state.controller == null) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return PopScope(
          onPopInvokedWithResult: (didPop, result) {
            // We only close the trailer if it's not already set to minimized
            // and the user is actually popping the view (back button/gesture)
            if (didPop && !context.read<TrailerCubit>().state.isMinimized) {
              context.read<TrailerCubit>().closeTrailer();
            }
          },
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              key: ValueKey(state.videoKey),
              controller: state.controller!,
              showVideoProgressIndicator: true,
              progressIndicatorColor: AppColors.cardBackground,
              onReady: () {
                if (state.lastPosition != Duration.zero) {
                  state.controller!.seekTo(state.lastPosition);
                }
              },
              onEnded: (data) {
                context.read<TrailerCubit>().closeTrailer();
                Navigator.pop(context);
              },
            ),
            builder: (context, player) {
              return Scaffold(
                backgroundColor: Colors.black,
                body: Stack(
                  children: [
                    Center(
                      child: Hero(
                        tag: 'trailer_player',
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width * 9 / 16,
                          decoration: const BoxDecoration(color: Colors.black),
                          child: player,
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 10,
                      left: 10,
                      right: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 35,
                            ),
                            onPressed: () {
                              context.read<TrailerCubit>().minimizeTrailer();
                              Navigator.pop(context);
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              context.read<TrailerCubit>().closeTrailer();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
