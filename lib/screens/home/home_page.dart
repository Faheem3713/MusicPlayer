import 'package:flutter/material.dart';

import 'package:musicplayer/constants/common/textHardcode.dart';
import 'package:musicplayer/constants/constants.dart';

import 'package:musicplayer/main.dart';

import 'bottom_navigation.dart';

//ValueNotifier<AudioPlayer> audioNotifier = ValueNotifier(AudioPlayer());
ValueNotifier<bool> miniplayer = ValueNotifier(false);

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  IconData switchMode = Icons.dark_mode_outlined;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWigets(title: "Library", actions: [
          IconButton(
              onPressed: () {
                appTheme.value == ThemeData.dark()
                    ? appTheme.value = ThemeData.light().copyWith(
                        appBarTheme:
                            AppBarTheme(backgroundColor: Colors.grey[200]))
                    : appTheme.value = ThemeData.dark();
                switchMode == Icons.dark_mode_outlined
                    ? switchMode = Icons.light_mode_outlined
                    : switchMode = Icons.dark_mode_outlined;
                setState(() {});
              },
              icon: Icon(switchMode)),
          const Text('   ')
        ]),
        body: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TextHardCode.library[index].pages,
                      )),
                  leading: TextHardCode.library[index].icon,
                  title: Text(TextHardCode.library[index].text),
                  trailing: RichText(
                      text: const TextSpan(children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(Icons.chevron_right_rounded),
                    )
                  ])),
                ),
            separatorBuilder: (context, index) => index == 4
                ? const Divider(
                    thickness: 5,
                  )
                : kdivider,
            itemCount: TextHardCode.library.length),
        bottomNavigationBar: const BottomNavigationBarWidget());
  }
}

PreferredSizeWidget AppBarWigets(
    {required String title, List<Widget> actions = const []}) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: AppBar(
        foregroundColor: kBlack,
        //    automaticallyImplyLeading: false,
        elevation: 0,
        //  backgroundColor: Color(0xFFEEEEEE),
        title: Text(
          title,
          style: const TextStyle(color: kBlack, fontSize: 13),
        ),
        actions: actions,
      ));
}
