import 'package:flutter/material.dart';
import 'package:musicplayer/constants/constants.dart';
import 'package:musicplayer/functions/load_data.dart';
import 'package:musicplayer/functions/playlist_repo.dart';
import 'package:musicplayer/model/playlist/playlist_model.dart';
import 'package:musicplayer/model/songs_model.dart';
import 'package:musicplayer/screens/home/home_page.dart';
import 'package:musicplayer/screens/playlistsongs/playlist_songs.dart';
import '../../constants/common/alert_dialogues.dart';

class PlayLists extends StatelessWidget {
  PlayLists({super.key});

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
        onPressed: () {
          _dialogueWidget(context, false);
        },
        child: const Icon(
          Icons.add,
          color: kBlack,
        ),
      ),
      appBar: AppBarWigets(title: 'Playlists'),
      body: ValueListenableBuilder(
          valueListenable: playListSongs,
          builder: (context, playlistSong, _) {
            return playListSongs.value.isEmpty
                ? const Center(
                    child: Text('No playlists'),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      final playlistData = playlistSong[index];
                      return ListTile(
                        onTap: () {
                          List<SongsDataModel> filtered = [];
                          for (var element in allSongs.value) {
                            if (element.playlists
                                .contains(playlistData.playlistName)) {
                              filtered.add(element);
                            }
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlaylistSongsDisplay(
                                    songData: filtered,
                                    playlistName: playlistData.playlistName),
                              ));
                        },
                        leading: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.grey[200]),
                          child: const Icon(
                            Icons.music_note_rounded,
                            size: 30,
                          ),
                        ),
                        title: Text(playlistData.playlistName),
                        //  subtitle: Text(_play),
                        trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: ((ctx) => AlertDialog(
                                        contentPadding: const EdgeInsets.all(9),
                                        content: SizedBox(
                                          height: 120,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                onTap: () {
                                                  _nameController.text =
                                                      playlistData.playlistName;

                                                  _dialogueWidget(context, true,
                                                      index: index,
                                                      updateName: playlistData);
                                                },
                                                leading: const Icon(Icons.edit),
                                                title: const Text('Update'),
                                              ),
                                              kdivider,
                                              ListTile(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  CustomAlertDialogues
                                                      .deleteDialogue(context,
                                                          () {
                                                    for (var element
                                                        in allSongs.value) {
                                                      element.playlists
                                                          .removeWhere((e) =>
                                                              playlistData
                                                                  .playlistName
                                                                  .contains(e));
                                                      LoadData.instance
                                                          .removeAndAddPlaylist(
                                                              element);
                                                    }

                                                    PlaylistRepo.instance
                                                        .deletePlaylist(index);
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                leading:
                                                    const Icon(Icons.delete),
                                                title: const Text('Delete'),
                                              )
                                            ],
                                          ),
                                        ),
                                      )));
                            },
                            icon: const Icon(Icons.more_vert)),
                      );
                    },
                    separatorBuilder: (context, index) => kdivider,
                    itemCount: playlistSong.length);
          }),
    );
  }

  Future<dynamic> _dialogueWidget(BuildContext context, bool isUpdate,
      {int index = 0, PlayListDataModel? updateName}) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        titleTextStyle: TextStyle(
            color: kBlack.withOpacity(.7),
            fontSize: 18,
            fontWeight: FontWeight.w300),
        title: Text(isUpdate ? "Update playlist" : 'Add playlist'),
        content: SizedBox(
          height: 120,
          child: ListView(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              kHeight,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      int numContains = 0;
                      for (var ele in playListSongs.value) {
                        if (ele.playlistName == _nameController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Name already exist')));
                          numContains = 1;
                          break;
                        }
                      }
                      if (numContains == 0) {
                        isUpdate == false
                            ? PlaylistRepo.instance.createPlaylist(
                                PlayListDataModel(
                                    playlistName: _nameController.text))
                            : PlaylistRepo.instance.updatePlaylist(
                                updateName!, _nameController.text, index);
                        _nameController.clear();
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('Add playlists')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
