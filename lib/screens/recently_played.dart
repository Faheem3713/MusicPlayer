import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:musicplayer/functions/load_data.dart';
import 'package:musicplayer/model/songs_model.dart';
import 'package:musicplayer/screens/home/home_page.dart';
import 'package:musicplayer/screens/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../constants/constants.dart';
import 'home/bottom_navigation.dart';

class RecentlyPlayed extends StatefulWidget {
  const RecentlyPlayed({
    super.key,
  });

  @override
  State<RecentlyPlayed> createState() => _RecentlyPlayedState();
}

class _RecentlyPlayedState extends State<RecentlyPlayed> {
  List<SongsDataModel> songDatas = [];
  List values = [];
  @override
  void initState() {
    _getThings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWigets(title: 'Recently played'),
      body: songDatas.isEmpty
          ? const Center(
              child: Text('No Songs'),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                final allSongsData = songDatas[index];
                return ListTile(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NowPlaying(
                            songData: songDatas,
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
                  allSongs.value[index + 1].played == 0
                      ? const SizedBox()
                      : kdivider,
              itemCount: songDatas.length),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }

  void _getThings() async {
    var box = await Hive.openBox<int>('recent');
    values.addAll(box.values);

    box.values.toList().forEach((element) {
      for (var ele in allSongs.value) {
        if (element == ele.id) {
          setState(() {
            songDatas.add(ele);
          });
        }
      }
    });
  }
}
