import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: depend_on_referenced_packages
import 'package:html/dom.dart' as dom;

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
    Map<String, Style> style = {};

    defaultStyle.forEach((key, value) {
      style[key] = Style().merge(value);
    });

    styles?.forEach((key, value) {
      if (style.containsKey(key)) {
        style[key] = style[key]!.merge(value);
      } else {
        style[key] = value;
      }
    });

    return Html(
      style: style,
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
        launchUrl(Uri.parse(url));
      }
    } on Exception {
      debugPrint("could not launch url: $url");
    } catch (error) {
      debugPrint(error.toString());
      debugPrint("could not launch url: $url");
    }
  }
}
