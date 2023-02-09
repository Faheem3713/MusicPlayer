// import 'package:flutter/material.dart';
// import 'package:musicplayer/constants/constants.dart';
// import 'package:musicplayer/functions/load_data.dart';
// import 'package:musicplayer/screens/album_songs.dart';
// import 'package:musicplayer/screens/allsongs.dart';
// import 'package:musicplayer/screens/home_page.dart';

// class Albums extends StatelessWidget {
//   const Albums({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarWigets(title: 'Albums'),
//       body: ValueListenableBuilder(
//           valueListenable: songsAlbum,
//           builder: (context, albumsData, _) {
//             return ListView.separated(
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               AlbumSongs(albumSongs: albumsData),
//                         )),
//                     leading: Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(4),
//                           color: Colors.grey[200]),
//                       child: const Icon(Icons.music_note_rounded),
//                     ),
//                     title: Text(albumsData[index].album),
//                     subtitle: Text(
//                         "${albumsData[index].numOfSongs.toString()} Songs"),
//                   );
//                 },
//                 separatorBuilder: (context, index) => kdivider,
//                 itemCount: albumsData.length);
//           }),
//     );
//   }
// }
