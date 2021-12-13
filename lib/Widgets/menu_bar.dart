import 'package:api_football/Data/list.dart';
import 'package:api_football/Widgets/constants/logo.dart';
import 'package:flutter/material.dart';
import 'items/menu_item.dart';

class MenuBar extends StatefulWidget {
  const MenuBar({Key? key}) : super(key: key);

  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border(
          right: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Column(
        children: [
          const Logo(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).dividerColor.withOpacity(0.50)),
              top: BorderSide(
                  color: Theme.of(context).dividerColor.withOpacity(0.50)),
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: listMenu.map((e) => MenuItem(menu: e)).toList(),
            ),
          )
        ],
      ),
    );
  }
}
