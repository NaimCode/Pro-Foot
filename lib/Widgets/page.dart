import 'package:api_football/Utils/theme.dart';
import 'package:api_football/Widgets/menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends StatefulWidget {
  final Widget page;
  final String title;
  const Root({Key? key, required this.page, required this.title})
      : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const MenuBar(),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Scaffold(
              appBar: PreferredSize(
                child: AppBar(
                  automaticallyImplyLeading: false,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Expanded(
                          child: Container(
                        color: Theme.of(context).primaryColor,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      )),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.logout))
                    ],
                  ),
                ),
                preferredSize: const Size.fromHeight(70),
              ),
              body: widget.page,
            ),
          ))
        ],
      ),
    );
  }
}
