import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Color,
        Colors,
        EdgeInsets,
        FontWeight,
        Icon,
        IconButton,
        IconData,
        Icons,
        MaterialPageRoute,
        MediaQuery,
        Navigator,
        Padding,
        SizedBox,
        Text,
        TextButton,
        Widget;
import 'package:google_fonts/google_fonts.dart';
import 'HomePage.dart';
import 'Updates/UpdatesPages.dart';
import 'auth/authPage.dart';

AppBar appBarCard(BuildContext context, String isProfileSelected) {
  final width = MediaQuery.of(context).size.width;
  return AppBar(
    backgroundColor: Colors.white,
    actions: [
      appbar_action(context,
          iconsName: Icons.home,
          label: "HOME",
          triggerWidget: const HomeScreen()),
      appbar_action(context,
          iconsName: Icons.account_tree,
          label: "IT-Companies",
          triggerWidget: const LatestUpdates('IT_Companies')),
      appbar_action(context,
          iconsName: Icons.explore,
          label: "Non-IT-Companies",
          triggerWidget: const LatestUpdates('IT_Companies')),
      width > 600
          ? SizedBox(
              width: 200 - 50000 / width,
            )
          : const SizedBox(
              width: 0,
            ),
      appbar_action(context,
          iconsName: Icons.notifications_none_outlined,
          label: "Notifications",
          triggerWidget: AuthPage(isProfileSelected)),
      appbar_action(context,
          iconsName: Icons.person,
          label: "Profile",
          triggerWidget: AuthPage(isProfileSelected)),
      width > 650
          ? const SizedBox(
              width: 25,
            )
          : const SizedBox(
              width: 0,
            ),
    ],
  );
}

appbar_action(BuildContext context,
    {required IconData iconsName,
    required String label,
    required Widget triggerWidget}) {
  double width = MediaQuery.of(context).size.width;

  Color color = const Color.fromARGB(255, 218, 230, 240);
  return width < 500 || label == ""
      ? Padding(
          padding: EdgeInsets.symmetric(horizontal: width < 300 ? 3 : 8),
          child: IconButton.filled(
            onPressed: () => Future.delayed(Duration.zero, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => triggerWidget));
            }),
            icon: Icon(
              iconsName,
              color: color,
              size: width < 300
                  ? width < 200
                      ? 5
                      : 15
                  : 25,
            ),
            tooltip: label,
            autofocus: true,
            splashColor: const Color.fromARGB(255, 31, 31, 31),
            color: const Color.fromARGB(188, 76, 56, 56),
          ),
        )
      : Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: TextButton(
            onPressed: () => Future.delayed(Duration.zero, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const LatestUpdates('IT_Companies')));
            }),
            autofocus: true,
            child: Text(
              label,
              selectionColor: color,
              style: GoogleFonts.cabin(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
}
