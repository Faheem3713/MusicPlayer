import 'package:flutter/material.dart';
import 'package:musicplayer/functions/load_data.dart';
import 'package:musicplayer/model/songs_model.dart';
import 'package:musicplayer/screens/home/home_page.dart';
import 'package:musicplayer/screens/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../constants/constants.dart';
import 'home/bottom_navigation.dart';

class MostPlayed extends StatefulWidget {
  const MostPlayed({
    super.key,
  });
  @override
  State<MostPlayed> createState() => _PlayedSongsListState();
}

class _PlayedSongsListState extends State<MostPlayed> {
  List<SongsDataModel> songData = [];
  @override
  void initState() {
    super.initState();
    sortingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWigets(title: 'Most Played Songs'),
      body: songData.isEmpty
          ? const Center(
              child: Text('No songs found'),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                final allSongsData = songData[index];
                return ListTile(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NowPlaying(
                            songData: songData,
                            intex: index,
                            toStart: true,
                          ),
                        ));
                  },
                  leading: QueryArtworkWidget(
                      nullArtworkWidget: const Icon(
                        Icons.music_note_rounded,
                        size: 38,
                      ),
                      artworkBorder: BorderRadius.circular(5),
                      id: allSongsData.id,
                      type: ArtworkType.AUDIO),
                  title: Text(
                    allSongsData.displayName,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(allSongsData.artist,
                      overflow: TextOverflow.ellipsis),
                );
              },
              separatorBuilder: (context, index) =>
                  songData[index + 1].played == 0 ? const SizedBox() : kdivider,
              itemCount: songData.length),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }

  sortingList() {
    for (var element in allSongs.value) {
      if (element.played > 3) {
        setState(() {
          songData.add(element);
        });
      }
    }
    songData.sort(
      (a, b) {
        return b.played.compareTo(a.played);
      },
    );
  }
}
