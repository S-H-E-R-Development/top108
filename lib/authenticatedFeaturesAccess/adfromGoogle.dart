import 'dart:html';
import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';

Widget adsenseWidget(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;

  // Register the view factory for 'adsenseViewType'
  ui.platformViewRegistry.registerViewFactory(
    'adsenseViewType',
        (int viewID) {
      final iframe = IFrameElement()
        ..width = (width / 3).toString()
        ..height = (height / 6).toString()
        ..srcdoc = '''
          <html>
            <body>
              <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-8356711992647862"
                crossorigin="anonymous"></script>
              <!-- Adunit1 -->
              <ins class="adsbygoogle"
                style="display:block"
                data-ad-client="ca-pub-8356711992647862"
                data-ad-slot="3905727085"
                data-ad-format="auto"
                data-full-width-responsive="true"></ins>
              <script>
                (adsbygoogle = window.adsbygoogle || []).push({});
              </script>
            </body>
          </html>
        ''';

      iframe.style.border = 'none';

      return iframe;
    },
  );

  return SizedBox(
    height: height / 6,
    width: width / 3,
    child: const HtmlElementView(
      viewType: 'adsenseViewType',
    ),
  );
}
