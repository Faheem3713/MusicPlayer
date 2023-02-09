import 'package:flutter/material.dart';
import 'package:musicplayer/constants/constants.dart';
import 'package:musicplayer/functions/load_data.dart';
import 'package:musicplayer/functions/playlist_repo.dart';
import 'package:musicplayer/model/playlist/playlist_model.dart';
import 'package:musicplayer/screens/home/home_page.dart';
import 'package:musicplayer/screens/playlistsongs/playlist_songs.dart';
import '../../constants/common/alert_dialogues.dart';

class PlayLists extends StatefulWidget {
  const PlayLists({super.key});
  @override
  State<PlayLists> createState() => _PlayListsState();
}

class _PlayListsState extends State<PlayLists> {
  final List _names = [];

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(238, 238, 238, 1),
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
                ? Center(
                    child: Text('No playlists'),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      final _playlistData = playlistSong[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlaylistSongsDisplay(
                                    playlistName: _playlistData.playlistName),
                              ));
                        },
                        leading: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.grey[200]),
                          child: const Icon(Icons.music_note_rounded),
                        ),
                        title: Text(_playlistData.playlistName),
                        subtitle: Text(_playlistData.playlistName.toString()),
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
                                                      _playlistData
                                                          .playlistName;

                                                  _dialogueWidget(context, true,
                                                      index: index,
                                                      updateName:
                                                          _playlistData);
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
                                                              _playlistData
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
                              SnackBar(content: Text('Name already exist')));
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
