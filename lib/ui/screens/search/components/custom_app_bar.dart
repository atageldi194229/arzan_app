import 'package:tm/core/api/services/search_service.dart';
import 'package:tm/core/providers/home_screen_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/helper/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'suggestion_list.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  final Size preferredSize;
}

class _CustomAppBarState extends State<CustomAppBar> {
  final _controller = ScrollController();
  late _MySearchDelegate _delegate;

  @override
  void initState() async {
    super.initState();

    _delegate = _MySearchDelegate();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
        } else {
          context.read<HomeScreenProvider>().loadPosts();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Posts'),
      actions: [
        IconButton(
          tooltip: 'Search',
          icon: const Icon(Icons.search),
          onPressed: () async {
            final String? selected = await showSearch<String>(
              context: context,
              delegate: _delegate,
            );

            if (selected != null && selected.isNotEmpty) {
              showToast(context, selected);
            }
          },
        ),
      ],
    );
  }
}

class _MySearchDelegate extends SearchDelegate<String> {
  List<String> _lastFetchedSuggestions = [];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  _MySearchDelegate() : super();

  @override
  List<Widget>? buildActions(BuildContext context) {
    List<Widget> actions = [
      IconButton(
        tooltip: 'Search',
        icon: const Icon(Icons.search, color: kTextColor),
        onPressed: () {
          showResults(context);
        },
      ),
    ];

    if (query.isNotEmpty) {
      actions.add(
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear, color: kTextColor),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
      );
    }

    return actions;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        // SearchDelegate.close() can return values, similar to Navigator.pop().
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: add the post search api here

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('You have selected the word:'),
            GestureDetector(
              onTap: () {
                close(context, query);
              },
              child: Text(
                query,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SuggestionList(
      query: query,
      onSelect: (String suggestion) async {
        query = suggestion;

        _addQueryToHistory();

        showResults(context);
      },
      fetchSuggestions: () async {
        if (query.isEmpty) {
          return (await _prefs).getStringList('suggestion_history') ?? [];
        }

        List<String> result = await SearchService().getSuggestions(query);

        if (result.isEmpty) {
          return _lastFetchedSuggestions;
        }

        _lastFetchedSuggestions = result;
        return result;
      },
    );
  }

  _addQueryToHistory() async {
    const String suggestionHistoryPrefKey = 'history_suggestion_list';

    SharedPreferences prefs = await _prefs;

    List<String> _history = prefs.getStringList(suggestionHistoryPrefKey) ?? [];

    _history.insert(0, query);

    prefs.setStringList(suggestionHistoryPrefKey, _history);
  }
}
