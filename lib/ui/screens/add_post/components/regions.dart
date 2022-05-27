import 'package:flutter/material.dart';

import '../../../constants.dart';

class Regions extends StatefulWidget {
  final Function onChanged;
  final List<String> items;
  final int defaultItemIndex;

  const Regions({
    Key? key,
    required this.onChanged,
    required this.items,
    this.defaultItemIndex = 0,
  }) : super(key: key);

  @override
  State<Regions> createState() => _RegionsState();
}

class _RegionsState extends State<Regions> {
  String _selectedItem = 'Select one';

  @override
  void initState() {
    super.initState();

    setState(() {
      if (widget.items.isEmpty) {
        _selectedItem = 'List is empty';
      } else {
        _selectedItem = widget.items[widget.defaultItemIndex];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var items = widget.items;

    return ExpansionTile(
      leading: const Icon(
        Icons.fmd_good_outlined,
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
