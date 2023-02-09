import 'package:flutter/material.dart';
import 'package:musicplayer/model/songs_model.dart';
import '../../functions/load_data.dart';
import '../../functions/playlist_repo.dart';
import '../../screens/home/home_page.dart';
import '../constants.dart';

class CustomAlertDialogues {
  static deleteDialogue(BuildContext context, void Function()? onPress) =>
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: const Text('Are you sure you want to delete'),
          actions: [
            TextButton(onPressed: onPress, child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'))
          ],
        ),
      );

  static playlistSheet(BuildContext context, SongsDataModel allSongsData) =>
      showModalBottomSheet(
          context: context,
          builder: (ctx) => SizedBox(
                child: Column(
                  children: [
                    AppBarWigets(title: 'Playlists'),
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, inde) => ListTile(
                              onTap: () async {
                                if (!allSongsData.playlists.contains(
                                    playListSongs.value[inde].playlistName)) {
                                  allSongsData.playlists.add(
                                      playListSongs.value[inde].playlistName);
                                  LoadData.instance.removeAndAddPlaylist(
                                      SongsDataModel(
                                          title: allSongsData.title,
                                          recentlyPlayed:
                                              allSongsData.recentlyPlayed,
                                          isFavourite: allSongsData.isFavourite,
                                          playlists: allSongsData.playlists,
                                          finderKey: allSongsData.finderKey,
                                          id: allSongsData.id,
                                          uri: allSongsData.uri,
                                          duration: allSongsData.duration,
                                          displayName: allSongsData.displayName,
                                          album: allSongsData.album,
                                          artist: allSongsData.artist));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Already added to playlist')));
                                }

                                Navigator.pop(context);
                              },
                              leading: const Icon(Icons.my_library_music_sharp),
                              title:
                                  Text(playListSongs.value[inde].playlistName),
                            ),
                        separatorBuilder: (context, inde) => kdivider,
                        itemCount: playListSongs.value.length),
                  ],
                ),
              ));
}
