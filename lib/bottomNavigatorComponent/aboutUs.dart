import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Updates/crudOperations.dart';

final Uri _urlYoutube = Uri.parse("https://youtube.com/@sherapp525");
final Uri _urlInstag =
    Uri.parse("https://instagram.com/sher.app2023?igshid=NGExMmI2YTkyZg==");
final Uri _urlFacebook = Uri.parse(
    "https://www.facebook.com/profile.php?id=100093380948771&mibextid=ZbWKwL");
final Uri _urlLinkdin =
    Uri.parse("https://www.linkedin.com/in/sher-app-11ab4a281/");
final Uri _urlTwitter =
    Uri.parse("https://twitter.com/Sher_App2023?t=WyftoofuodNHEwoDHPhT7A&s=09");
final Uri _urlSHERapp = Uri.parse(
    "https://play.google.com/store/apps/details?id=com.rkverma.sherapp");

Future<void> _launchUrlSHER_APP() async {
  if (!await launchUrl(_urlSHERapp)) {
    throw Exception("Could not launch $_urlSHERapp");
  }
}

Future<void> _launchUrlYouTube() async {
  if (!await launchUrl(_urlYoutube)) {
    throw Exception("Could not launch $_urlYoutube");
  }
}

Future<void> _launchUrlInsta() async {
  if (!await launchUrl(_urlInstag)) {
    throw Exception("Could not launch $_urlInstag");
  }
}

Future<void> _launchUrlFacebook() async {
  if (!await launchUrl(_urlFacebook)) {
    throw Exception("Could not launch $_urlFacebook");
  }
}

Future<void> _launchUrlLinkdin() async {
  if (!await launchUrl(_urlLinkdin)) {
    throw Exception("Could not launch $_urlLinkdin");
  }
}

Future<void> _launchUrlTwitter() async {
  if (!await launchUrl(_urlTwitter)) {
    throw Exception("Could not launch $_urlTwitter");
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 187, 227, 244),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text(
              "108 (TOP 108 Companies Updates / TOP108 Internship) is powered by Society of Humanity Education and Research in the partnership with Microsoft for Startups",
              style: GoogleFonts.alexandria(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: _launchUrlSHER_APP,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              maximumSize: const Size(80, 80),
                              minimumSize: const Size(25, 25),
                              elevation: 10,
                              shape: const CircleBorder(
                                eccentricity: 0,
                              )),
                          child: Image.asset(
                            "assets/SHER_logo.png",
                          )),
                      ElevatedButton(
                          onPressed: _launchUrlInsta,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              maximumSize: const Size(80, 80),
                              minimumSize: const Size(25, 25),
                              elevation: 5,
                              shadowColor: Colors.black,
                              shape: const CircleBorder(
                                eccentricity: 0,
                              )),
                          child: Image.asset(
                            "assets/socialMedia/Instagram.png",
                          )),
                      ElevatedButton(
                          onPressed: _launchUrlTwitter,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              maximumSize: const Size(80, 80),
                              minimumSize: const Size(25, 25),
                              elevation: 5,
                              shadowColor: Colors.black,
                              shape: const CircleBorder(
                                eccentricity: 0,
                              )),
                          child: Image.asset("assets/socialMedia/twitter.png")),
                      ElevatedButton(
                          onPressed: _launchUrlYouTube,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              maximumSize: const Size(80, 80),
                              minimumSize: const Size(25, 25),
                              elevation: 5,
                              shape: const CircleBorder(
                                eccentricity: 0,
                              )),
                          child: Image.asset("assets/socialMedia/Youtube.png")),
                      ElevatedButton(
                          onPressed: _launchUrlLinkdin,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              maximumSize: const Size(80, 80),
                              minimumSize: const Size(25, 25),
                              elevation: 5,
                              shape: const CircleBorder(
                                eccentricity: 0,
                              )),
                          child: Image.asset("assets/socialMedia/Linkdin.png")),
                      ElevatedButton(
                          onPressed: _launchUrlFacebook,
                          style: ElevatedButton.styleFrom(
                              maximumSize: const Size(80, 80),
                              minimumSize: const Size(25, 25),
                              elevation: 5,
                              shape: const CircleBorder(
                                eccentricity: 0,
                              )),
                          child:
                              Image.asset("assets/socialMedia/facebook.png")),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        "For inquiries, contact us at ",
                        style: GoogleFonts.alexandria(),
                      ),
                      TextButton(
                          onPressed: () {
                            Clipboard.setData(const ClipboardData(
                                text: 'top108compinternship@gmail.com'));
                            displayMessage(context, 'copied');
                          },
                          child: Text(
                            "top108compinternship@gmail.com",
                            style: GoogleFonts.alexandria(
                                color: const Color.fromARGB(255, 96, 69, 230)),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
