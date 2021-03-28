import 'package:flutter/material.dart';
import 'package:tiktok/pages/home.dart';
import 'package:tiktok/theme/color.dart';
import 'package:tiktok/widgets/tiktok.dart';
import 'package:tiktok/widgets/upload_icon.dart';
import 'package:tiktok/pages/camera.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [
        Home(),
        Camera(),
      ],
    );
  }

  Widget getFooter() {
    var size = MediaQuery.of(context).size;
    List bottomItem = [
      {"icon": Icons.home, "label": "Home", "isIcon": true},
      {"icon": Icons.camera, "label": "Camera", "isIcon": true}
    ];
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(color: white),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(bottomItem.length, (index) {
            return bottomItem[index]["isIcon"]
                ? InkWell(
                    onTap: () {
                      selectedIndex(index);
                    },
                    child: Column(
                      children: [
                        Icon(
                          bottomItem[index]["icon"],
                          color: Colors.black,
                        ),
                        SizedBox(height: 5),
                        Text(
                          bottomItem[index]["label"],
                          style: TextStyle(
                            color: black,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  )
                : InkWell(
                    onTap: () {
                      selectedIndex(index);
                    },
                    child: UploadIcon(),
                  );
          }),
        ),
      ),
    );
  }

  selectedIndex(int index) {
    setState(() {
      pageIndex = index;
    });
  }
}
