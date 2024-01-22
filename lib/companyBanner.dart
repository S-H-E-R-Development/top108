//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
//
// Class  top30Banner(BuildContext context)
// {
//
// final width = MediaQuery.of(context).size.width;
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Image(
//         image: const AssetImage(
//           "assets/top30internship.png",
//         ),
//         width: 348 - 50000 / width,
//         height: 236 - 50000 / width,
//       ),
//
// // Include the dropdown button here
//
//       width > 650
//           ? Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           width: 120,
//           color: Colors.white,
//           alignment: Alignment.topRight,
//           child: dropDownButton(context, companiesList))
//           : const SizedBox(
//         width: 1,
//       ),
//     ],
//   );
//
// }
//
