import 'package:flutter/widgets.dart';

import '../../../data/repositories/songs/song_repository.dart';
import '../../../model/songs/song.dart';
import '../../states/player_state.dart';

/// ViewModel for the Library screen.
/// Orchestrates data from SongRepository and PlayerState.
class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;

  List<Song> _songs = [];

  LibraryViewModel({
    required this.songRepository,
    required this.playerState,
  }) {
    init();
    // Listen to PlayerState changes and notify this ViewModel's listeners
    playerState.addListener(_onPlayerStateChanged);
  }

  /// Fetch songs from the repository
  void init() {
    _songs = songRepository.fetchSongs();
    notifyListeners();
  }

  /// Called when PlayerState changes
  void _onPlayerStateChanged() {
    notifyListeners();
  }

  // --- Getters: expose all UI data ---

  /// List of all songs
  List<Song> get songs => _songs;

  /// The currently playing song (if any)
  Song? get currentSong => playerState.currentSong;

  /// Check if a specific song is currently playing
  bool isPlaying(Song song) => playerState.currentSong == song;

  // --- User actions ---

  /// Start playing a song
  void play(Song song) {
    playerState.start(song);
  }

  /// Stop the current song
  void stop() {
    playerState.stop();
  }

  @override
  void dispose() {
    playerState.removeListener(_onPlayerStateChanged);
    super.dispose();
  }
}
