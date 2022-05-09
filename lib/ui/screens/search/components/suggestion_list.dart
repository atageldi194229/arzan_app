import 'package:flutter/material.dart';

class SuggestionList extends StatelessWidget {
  final String query;
  final ValueChanged<String> onSelect;
  final Function fetchSuggestions;

  const SuggestionList({
    Key? key,
    required this.query,
    required this.onSelect,
    required this.fetchSuggestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: fetchSuggestions(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const SizedBox();
        }

        List<String> items = snapshot.data!;

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final String suggestion = items[index];
            return ListTile(
              onTap: () => onSelect(suggestion),
              leading:
                  query.isEmpty ? const Icon(Icons.history) : const Icon(null),
              // Highlight the suggestion substring that matched
              title: RichText(
                text: TextSpan(
                  text: suggestion.substring(0, query.length),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: suggestion.substring(query.length),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
