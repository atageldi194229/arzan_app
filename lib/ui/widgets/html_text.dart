import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

Map<String, Style> defaultStyle = {
  "p": Style(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.zero,
  ),
  "body": Style(
    color: Colors.blueGrey[700],
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
  ),
  "a": Style(
    color: kSoftGreen,
  ),
};

class HtmlTextWidget extends StatelessWidget {
  final String html;
  final Map<String, Style>? styles;
  final bool canLaunch;

  const HtmlTextWidget({
    Key? key,
    required this.html,
    this.styles,
    this.canLaunch = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, Style> _style = {};

    defaultStyle.forEach((key, value) {
      _style[key] = Style().merge(value);
    });

    styles?.forEach((key, value) {
      if (_style.containsKey(key)) {
        _style[key] = _style[key]!.merge(value);
      } else {
        _style[key] = value;
      }
    });

    return Html(
      style: _style,
      data: html,
      onLinkTap: _onLinkTap,

      // customRender: (node, children) {
      //   if (node is dom.Element) {
      //     switch (node.localName) {
      //       case "custom_tag": // using this, you can handle custom tags in your HTML
      //         return Column(children: children);
      //     }
      //   }
      // },
    );
  }

  void _onLinkTap(String? url, RenderContext context,
      Map<String, String> attributes, dom.Element? element) {
    // check if can launch
    if (!canLaunch) return;

    //open URL in webview, or launch URL in browser, or any other logic here
    try {
      if (url != null) {
        launch(url).then((value) {
          if (!value) {
            // print("Could not launch $url");
          }
        });
      }
    } on Exception {
      // print(exception.toString());
    } catch (error) {
      // print(error.toString());
    }
  }
}
