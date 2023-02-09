import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/constants/common/alert_dialogues.dart';
import 'package:musicplayer/functions/load_data.dart';
import 'package:musicplayer/model/songs_model.dart';
import 'package:musicplayer/screens/home/home_page.dart';
import 'package:musicplayer/screens/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../constants/constants.dart';

class AllSongs extends StatefulWidget {
  AllSongs({super.key});

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  bool isSearch = false;
  final List<SongsDataModel> _allSongs = [];
  final _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _allSongs.addAll(allSongs.value);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !isSearch
          ? AppBarWigets(title: 'All Songs', actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = !isSearch;
                    });
                  },
                  icon: const Icon(
                    Icons.search,
                  ))
            ])
          : AppBar(
              //    backgroundColor: Colors.grey[200],
              automaticallyImplyLeading: false,
              title: CupertinoSearchTextField(
                //   backgroundColor: Colors.grey[50],
                suffixMode: OverlayVisibilityMode.always,
                onSuffixTap: (() {
                  setState(() {
                    _searchController.text.isNotEmpty
                        ? _searchController.clear()
                        : isSearch = !isSearch;
                    _allSongs.clear();
                    _allSongs.addAll(allSongs.value);
                    setState(() {});
                  });
                }),
                //decoration: BoxDecoration(),
                suffixIcon: const Icon(
                  CupertinoIcons.clear,
                  color: kBlack,
                ),
                onChanged: (value) async {
                  await _searchFilter(value);
                },
                controller: _searchController,
              )),
      body: _allSongs.isEmpty
          ? const Center(
              child: Text('No songs found'),
            )
          : ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NowPlaying(
                            songData: _allSongs,
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
                      id: _allSongs[index].id,
                      type: ArtworkType.AUDIO),
                  title: Text(
                    _allSongs[index].displayName,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(_allSongs[index].album,
                      overflow: TextOverflow.ellipsis),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () async {
                      await showDialog(
                          context: context,
                          builder: ((ctx) => AlertDialog(
                                contentPadding: const EdgeInsets.all(9),
                                content: SizedBox(
                                  height: 120,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          CustomAlertDialogues.playlistSheet(
                                              context, _allSongs[index]);
                                        },
                                        leading: const Icon(Icons.playlist_add),
                                        title: const Text('Add to playlist'),
                                      ),
                                      kdivider,
                                      ListTile(
                                        onTap: () {
                                          LoadData.instance
                                              .addToFavourite(_allSongs[index]);
                                          Navigator.pop(context);
                                        },
                                        leading:
                                            const Icon(Icons.favorite_outlined),
                                        title: const Text('Add to favourite'),
                                      )
                                    ],
                                  ),
                                ),
                              )));
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => kdivider,
              itemCount: _allSongs.length),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }

  _searchFilter(String query) async {
    if (query.isEmpty) {
      setState(() {
        _allSongs.clear();
        _allSongs.addAll(allSongs.value);
      });
    } else {
      setState(() {
        _allSongs.clear();
        for (var element in allSongs.value) {
          if (element.displayName.toLowerCase().contains(query.toLowerCase())) {
            _allSongs.add(element);
          }
        }
      });
    }
  }
}
