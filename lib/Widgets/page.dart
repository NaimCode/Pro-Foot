// ignore_for_file: non_constant_identifier_names

import 'package:api_football/Data/list.dart';
import 'package:api_football/Utils/theme.dart';
import 'package:api_football/Widgets/constants/logo.dart';
import 'package:api_football/Widgets/menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'historique.dart';

RxList historiqueList = [].obs;

class Root extends StatefulWidget {
  final Widget page;
  const Root({Key? key, required this.page}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    RxBool isMenu = true.obs;
    bool m = MediaQuery.of(context).size.width <= 450;
    return Scaffold(
      floatingActionButton:
          m && Get.currentRoute != "/home" && Get.currentRoute != "/"
              ? Builder(
                  builder: (context) => FloatingActionButton(
                      tooltip: "Historique",
                      backgroundColor: Colors.blue[900],
                      onPressed: () {
                        isMenu.value = false;
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: const Icon(Icons.history)))
              : null,
      appBar: m && Get.currentRoute != "/home" && Get.currentRoute != "/"
          ? AppBar(
              automaticallyImplyLeading: true,
              elevation: 8,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.navigate_before)),
              title: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Logo(),
              ),
              actions: [
                Builder(
                    builder: (context) => IconButton(
                          tooltip: "Menu",
                          onPressed: () {
                            isMenu.value = true;
                            Scaffold.of(context).openEndDrawer();
                          },
                          icon: const Icon(Icons.menu),
                        ))
              ],
            )
          : null,
      endDrawer: m
          ? Drawer(
              child: Obx(
                  () => isMenu.value ? const MenuBar() : const Historique()),
            )
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Visibility(
              visible:
                  Get.currentRoute != "/home" && Get.currentRoute != "/" && !m,
              child: const MenuBar()),
          Expanded(
              child: Get.currentRoute != "/home" && Get.currentRoute != "/"
                  ? Padding(
                      padding: EdgeInsets.only(
                          left: m ? 0 : 20, top: 10, right: m ? 0 : 20),
                      child: widget.page,
                    )
                  : widget.page),
          Visibility(
              visible:
                  Get.currentRoute != "/home" && Get.currentRoute != "/" && !m,
              child: const Historique())
        ],
      ),
    );
  }
}
