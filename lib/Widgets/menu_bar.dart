import 'package:api_football/Data/list.dart';
import 'package:api_football/Widgets/constants/logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuBar extends StatefulWidget {
  const MenuBar({Key? key}) : super(key: key);

  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        shape: BoxShape.rectangle,
        border: Border(
          right: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const Logo(),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).dividerColor.withOpacity(0.50)),
                  top: BorderSide(
                      color: Theme.of(context).dividerColor.withOpacity(0.50)),
                )),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: listMenu.map((e) => MenuItem(menu: e)).toList(),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.settings,
                      color:
                          Theme.of(context).iconTheme.color!.withOpacity(0.4))),
            )
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final Map menu;
  const MenuItem({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool m = MediaQuery.of(context).size.width <= 450;
    bool isHome = Get.currentRoute == "/";
    bool isCurrent = isHome ? isHome : Get.currentRoute.contains(menu['route']);
    return InkWell(
      // hoverColor: Colors.transparent,
      // highlightColor: Colors.transparent,
      onTap: () {
        if (m) {
          Navigator.of(context).pop();
        }
        Get.toNamed(menu['route']);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              menu['icon'],
              size: m ? 30 : null,
              color: isCurrent
                  ? Theme.of(context).iconTheme.color
                  : Theme.of(context).iconTheme.color!.withOpacity(0.4),
            ),
            const SizedBox(height: 5),
            Text(menu['titre'],
                style: isCurrent
                    ? null
                    : Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(0.4))),
          ],
        ),
      ),
    );
  }
}
