// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:musicplayer/functions/load_data.dart';

// import 'package:musicplayer/screens/home_page.dart';
// import 'package:musicplayer/screens/now_playing.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// import '../constants/constants.dart';

// class AlbumSongs extends StatelessWidget {
//   const AlbumSongs({super.key, required this.albumSongs});
//   final List<AlbumModel> albumSongs;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarWigets(title: 'Songs'),
//       body: ListView.separated(
//           itemBuilder: (context, index) => ListTile(
//                 onTap: () async {
//                   // Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(
//                   //       builder: (context) => NowPlaying(
//                   //         songData: albumSongs[index],
//                   //         intex: index,
//                   //       ),
//                   //     ));
//                 },
//                 // leading: Image.memory(vall.value[index]),
//                 title: Text(albumSongs[index].album),
//                 subtitle: Text(albumSongs[index].artist!),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.more_vert),
//                   onPressed: () {},
//                 ),
//               ),
//           separatorBuilder: (context, index) => kdivider,
//           itemCount: albumSongs.length),
//       bottomNavigationBar: bottomNavigationBarWidget(),
//     );
//   }
// }
