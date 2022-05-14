import 'package:flutter/material.dart';

import '../../../constants.dart';

class Regions extends StatefulWidget {
  final Function onChanged;
  final List<String> items;
  const Regions({
    Key? key,
    required this.onChanged,
    required this.items,
  }) : super(key: key);

  @override
  State<Regions> createState() => _RegionsState();
}

class _RegionsState extends State<Regions> {
  String _selectedItem = 'Select one';

  @override
  Widget build(BuildContext context) {
    var items = widget.items;

    return ExpansionTile(
      leading: const Icon(
        Icons.location_city,
        color: kSoftGreen,
      ),
      title: Text(
        _selectedItem,
        textAlign: TextAlign.center,
      ),
      children: List.generate(
        items.length,
        (index) => ListTile(
          title: TextButton(
            child: Text(items[index]),
            onPressed: () {
              setState(() {
                _selectedItem = items[index];
                widget.onChanged(index);
              });
            },
          ),
        ),
      ),
    );
  }
}
