import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/songs/song.dart';
import '../../states/settings_state.dart';
import '../../theme/theme.dart';
import 'library_view_model.dart';

/// Content widget for the Library screen.
/// Reads only LibraryViewModel and AppSettingsState.
/// Delegates all presentation logic to LibraryViewModel.
/// Kept purely declarative.
class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 1 - Watch the LibraryViewModel for songs and player data
    LibraryViewModel viewModel = context.watch<LibraryViewModel>();

    // 2 - Read the global settings state for theme
    AppSettingsState settingsState = context.read<AppSettingsState>();

    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),

          SizedBox(height: 50),

          Expanded(
            child: ListView.builder(
              itemCount: viewModel.songs.length,
              itemBuilder: (context, index) {
                final song = viewModel.songs[index];
                return SongTile(
                  song: song,
                  isPlaying: viewModel.isPlaying(song),
                  onTap: () {
                    viewModel.play(song);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(song.title),
      trailing: Text(
        isPlaying ? "Playing" : "",
        style: TextStyle(color: Colors.amber),
      ),
    );
  }
}
