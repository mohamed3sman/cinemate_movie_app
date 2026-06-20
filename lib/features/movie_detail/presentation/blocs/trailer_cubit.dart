import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerState extends Equatable {
  final String? videoKey;
  final bool isMinimized;
  final bool isVisible;
  final YoutubePlayerController? controller;
  final Duration lastPosition;

  const TrailerState({
    this.videoKey,
    this.isMinimized = false,
    this.isVisible = false,
    this.controller,
    this.lastPosition = Duration.zero,
  });

  TrailerState copyWith({
    String? videoKey,
    bool? isMinimized,
    bool? isVisible,
    YoutubePlayerController? controller,
    Duration? lastPosition,
  }) {
    return TrailerState(
      videoKey: videoKey ?? this.videoKey,
      isMinimized: isMinimized ?? this.isMinimized,
      isVisible: isVisible ?? this.isVisible,
      controller: controller ?? this.controller,
      lastPosition: lastPosition ?? this.lastPosition,
    );
  }

  @override
  List<Object?> get props => [
    videoKey,
    isMinimized,
    isVisible,
    controller,
    lastPosition,
  ];
}

class TrailerCubit extends Cubit<TrailerState> {
  TrailerCubit() : super(const TrailerState());

  void playTrailer(String videoKey) {
    if (state.videoKey == videoKey && state.controller != null) {
      maximizeTrailer();
      return;
    }

    state.controller?.dispose();

    final controller = YoutubePlayerController(
      initialVideoId: videoKey,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
        forceHD: true,
      ),
    );

    emit(
      TrailerState(
        videoKey: videoKey,
        isVisible: true,
        isMinimized: false,
        controller: controller,
      ),
    );
  }

  void minimizeTrailer() {
    if (state.videoKey != null && state.controller != null) {
      final currentPosition = state.controller!.value.position;
      // Dispose the old controller – its WebView platform channel will be
      // destroyed when TrailerPlayerView is popped from the navigator.
      state.controller!.dispose();

      // Create a fresh controller for the mini player.
      final newController = YoutubePlayerController(
        initialVideoId: state.videoKey!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          enableCaption: false,
          forceHD: true,
        ),
      );

      emit(
        TrailerState(
          videoKey: state.videoKey,
          isMinimized: true,
          isVisible: true,
          controller: newController,
          lastPosition: currentPosition,
        ),
      );
    }
  }

  void maximizeTrailer() {
    if (state.videoKey != null && state.controller != null) {
      final currentPosition = state.controller!.value.position;
      // Dispose the old controller – its WebView will be destroyed
      // when the mini player's YoutubePlayer leaves the visible tree.
      state.controller!.dispose();

      // Create a fresh controller for the full-screen player.
      final newController = YoutubePlayerController(
        initialVideoId: state.videoKey!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          enableCaption: false,
          forceHD: true,
        ),
      );

      emit(
        TrailerState(
          videoKey: state.videoKey,
          isMinimized: false,
          isVisible: true,
          controller: newController,
          lastPosition: currentPosition,
        ),
      );
    }
  }

  void closeTrailer() {
    state.controller?.dispose();
    emit(const TrailerState(isVisible: false, isMinimized: false));
  }

  @override
  Future<void> close() {
    state.controller?.dispose();
    return super.close();
  }
}
