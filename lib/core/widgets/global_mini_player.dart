import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/features/movie_detail/presentation/blocs/trailer_cubit.dart';
import 'package:movie_app/features/movie_detail/presentation/views/trailer_player_view.dart';
import 'package:movie_app/main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GlobalMiniPlayer extends StatefulWidget {
  final Widget child;

  const GlobalMiniPlayer({super.key, required this.child});

  @override
  State<GlobalMiniPlayer> createState() => _GlobalMiniPlayerState();
}

class _GlobalMiniPlayerState extends State<GlobalMiniPlayer> {
  double _xOffset = 0;
  double _yOffset = 0;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrailerCubit, TrailerState>(
      builder: (context, state) {
        final bool showPlayer =
            state.isVisible && state.isMinimized && state.controller != null;

        return Stack(
          children: [
            widget.child,
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              bottom: showPlayer ? (20 - _yOffset) : -250,
              right: 20 - _xOffset,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: showPlayer ? 1.0 : 0.0,
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 300),
                  scale: showPlayer ? 1.0 : 0.8,
                  curve: Curves.easeOutBack,
                  child: SizedBox(
                    width: 220,
                    height: 124,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Overlay(
                        initialEntries: [
                          OverlayEntry(
                            builder: (overlayContext) {
                              // BlocBuilder inside the OverlayEntry is required
                              // because Overlay only reads initialEntries once
                              // (in initState). Without this, the entry keeps
                              // the stale state/controller from the first build.
                              return BlocBuilder<TrailerCubit, TrailerState>(
                                builder: (ctx, overlayState) {
                                  return GestureDetector(
                                    onPanUpdate: (details) {
                                      setState(() {
                                        _xOffset += details.delta.dx;
                                        _yOffset += details.delta.dy;
                                        _isDragging = true;
                                      });
                                    },
                                    onPanEnd: (details) {
                                      setState(() {
                                        _isDragging = false;
                                      });
                                    },
                                    onTap: () {
                                      if (!_isDragging &&
                                          overlayState.videoKey != null) {
                                        ctx
                                            .read<TrailerCubit>()
                                            .maximizeTrailer();
                                        MovieApp.navigatorKey.currentState
                                            ?.push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TrailerPlayerView(
                                              videoKey:
                                                  overlayState.videoKey!,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Hero(
                                      tag: 'trailer_player',
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color:
                                                AppColors.primary.withValues(
                                              alpha: 0.3,
                                            ),
                                            width: 1,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.6,
                                              ),
                                              blurRadius: 20,
                                              spreadRadius: 4,
                                              offset: const Offset(0, 8),
                                            ),
                                          ],
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: Stack(
                                          children: [
                                            if (overlayState.controller !=
                                                    null &&
                                                overlayState.isMinimized)
                                              YoutubePlayer(
                                                key: ValueKey(
                                                    overlayState.videoKey),
                                                controller: overlayState
                                                    .controller!,
                                                showVideoProgressIndicator:
                                                    false,
                                                onReady: () {
                                                  if (overlayState
                                                          .lastPosition !=
                                                      Duration.zero) {
                                                    overlayState.controller!
                                                        .seekTo(
                                                      overlayState
                                                          .lastPosition,
                                                    );
                                                  }
                                                  overlayState.controller!
                                                      .play();
                                                },
                                              ),
                                            Container(
                                                color: Colors.transparent),
                                            Positioned(
                                              top: 6,
                                              right: 6,
                                              child: GestureDetector(
                                                onTap: () => ctx
                                                    .read<TrailerCubit>()
                                                    .closeTrailer(),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withValues(
                                                      alpha: 0.7,
                                                    ),
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.white24,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
