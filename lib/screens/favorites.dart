import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:musicplayer/constants/common/alert_dialogues.dart';
import 'package:musicplayer/constants/constants.dart';
import 'package:musicplayer/functions/playlist_repo.dart';
import 'package:musicplayer/functions/load_data.dart';
import 'package:musicplayer/model/songs_model.dart';
import 'package:musicplayer/screens/home/home_page.dart';
import 'package:musicplayer/screens/now_playing.dart';
import 'package:musicplayer/screens/playlistsongs/playlists.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<SongsDataModel> songData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfav();
  }

  @override
  Widget build(BuildContext context) {
    print(songData.isEmpty);
    return Scaffold(
      appBar: AppBarWigets(title: 'Favorites'),
      body: ValueListenableBuilder(
          valueListenable: allSongs,
          builder: (context, data, _) {
            return songData.isEmpty
                ? const Center(
                    child: Text(
                      'No songs in favourite',
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      final favdata = songData[index];

                      return ListTile(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NowPlaying(
                                  songData: data, intex: index, toStart: true),
                            )),
                        title: Text(favdata.displayName),
                        subtitle: Text(favdata.artist),
                        leading: QueryArtworkWidget(
                            nullArtworkWidget: const Icon(Icons.music_note),
                            id: favdata.id,
                            type: ArtworkType.AUDIO),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_forever_rounded),
                          onPressed: () async {
                            await CustomAlertDialogues.deleteDialogue(context,
                                () {
                              LoadData.instance.deleteFromFavourite(favdata);
                              Navigator.pop(context);
                            });
                            songData.removeAt(index);
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => kdivider,
                    itemCount: songData.length);
          }),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }

  getfav() async {
    allSongs.value.forEach((element) {
      if (element.isFavourite == true) {
        setState(() {
          songData.add(element);
        });
      }
    });
  }
}
