import 'package:flutter/material.dart';
import 'package:musicplayer/constants/common/alert_dialogues.dart';
import 'package:musicplayer/constants/constants.dart';
import 'package:musicplayer/functions/load_data.dart';
import 'package:musicplayer/model/songs_model.dart';
import 'package:musicplayer/screens/home/home_page.dart';
import 'package:musicplayer/screens/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistSongsDisplay extends StatelessWidget {
  const PlaylistSongsDisplay({
    super.key,
    required this.playlistName,
    required this.songData,
  });
  final String playlistName;
  final List<SongsDataModel> songData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWigets(title: playlistName),
      body: ValueListenableBuilder(
          valueListenable: allSongs,
          builder: (context, data, _) {
            return songData.isEmpty
                ? const Center(
                    child: Text('No songs in playlist'),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      final allSongData = songData[index];
                      return ListTile(
                        minVerticalPadding: 10,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NowPlaying(
                                    songData: data,
                                    intex: index,
                                    toStart: true),
                              ));
                        },
                        leading: QueryArtworkWidget(
                            nullArtworkWidget: const Icon(Icons.music_note),
                            id: allSongData.id,
                            type: ArtworkType.AUDIO),
                        title: Text(allSongData.displayName),
                        subtitle: Text(allSongData.artist),
                        trailing: IconButton(
                            onPressed: () {
                              CustomAlertDialogues.deleteDialogue(context, () {
                                songData[index].playlists.removeWhere(
                                    (element) =>
                                        element.contains(playlistName));
                                songData.removeAt(index);
                                LoadData.instance.removeAndAddPlaylist(
                                  allSongData,
                                );
                                Navigator.pop(context);
                              });
                            },
                            icon: const Icon(Icons.delete)),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        data[index + 1].playlists.contains(playlistName)
                            ? kdivider
                            : const SizedBox(),
                    itemCount: songData.length);
          }),
    );
  }
}
