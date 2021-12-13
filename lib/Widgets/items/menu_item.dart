import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class MenuItem extends StatelessWidget {
  final Map menu;
  const MenuItem({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCurrent = Get.currentRoute == menu['route'];
    return InkWell(
      // hoverColor: Colors.transparent,
      // highlightColor: Colors.transparent,
      onTap: () {
        Get.toNamed(menu['route']);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              menu['icon'],
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
