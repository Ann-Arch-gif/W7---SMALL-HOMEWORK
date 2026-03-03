import 'package:flutter/widgets.dart';

import '../../../data/repositories/songs/song_repository.dart';
import '../../states/player_state.dart';

/// ViewModel for the Library screen.
/// Will be fully implemented in Part 4.
class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;

  LibraryViewModel({
    required this.songRepository,
    required this.playerState,
  });
  // TODO: Full implementation in Part 4
}
