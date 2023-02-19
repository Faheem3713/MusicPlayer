import 'package:flutter/material.dart';
import 'package:musicplayer/constants/common/alert_dialogues.dart';
import 'package:musicplayer/constants/constants.dart';
import 'package:musicplayer/functions/load_data.dart';
import 'package:musicplayer/model/songs_model.dart';
import 'package:musicplayer/screens/home/home_page.dart';
import 'package:musicplayer/screens/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'home/bottom_navigation.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<SongsDataModel> songData = [];
  @override
  void initState() {
    super.initState();
    getfav();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWigets(title: 'Favorites'),
      body: songData.isEmpty
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
                            songData: songData, intex: index, toStart: true),
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
                      await CustomAlertDialogues.deleteDialogue(context, () {
                        LoadData.instance.deleteFromFavourite(favdata);
                        Navigator.pop(context);
                      });
                      setState(() {
                        songData.removeAt(index);
                      });
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => kdivider,
              itemCount: songData.length),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }

  getfav() async {
    for (var element in allSongs.value) {
      if (element.isFavourite == true) {
        setState(() {
          songData.add(element);
        });
      }
    }
  }
}
