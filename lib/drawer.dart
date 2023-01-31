import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db_api/constants/constants.dart';
import 'package:movie_db_api/constants/style_constants.dart';
import 'package:movie_db_api/pages/home.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blueGrey, Colors.blue.shade800])),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blueGrey, Colors.blue.shade800])),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 33,
                    left: 10,
                    right: 10,
                    bottom: 15,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/images/drawer_icon.png",
                      fit: BoxFit.contain,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              ExpansionTile(
                textColor: Colors.black,
                title:  Text("Movies".tr, style: Sabitler.drawerStyle),
                leading: const Icon(Icons.movie, size: 30, color: Colors.black),
                children: [
                  myDrawerItem(
                    Icons.movie,
                    "Upcoming".tr,
                    context,
                    Constants.upComing,
                  ),
                  myDrawerItem(
                    Icons.movie,
                    "Now Playing".tr,
                    context,
                    Constants.nowPlaying,
                  ),
                  myDrawerItem(
                    Icons.movie,
                    "Top Rated".tr,
                    context,
                    Constants.topRated,
                  ),
                  myDrawerItem(
                    Icons.movie,
                    "Populer".tr,
                    context,
                    Constants.popularMovies,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ExpansionTile(
                textColor: Colors.black,
                title:  Text("TV Shows".tr, style: Sabitler.drawerStyle3),
                leading: const Icon(Icons.tv, size: 30, color: Colors.black),
                children: [
                  myDrawerItem2(
                    Icons.tv,
                    "Top Rated".tr,
                    context,
                    Constants.tvTopRated,
                  ),
                  myDrawerItem2(
                    Icons.tv,
                    "On The Air".tr,
                    context,
                    Constants.onTheAir,
                  ),
                  myDrawerItem2(
                    Icons.tv,
                    "Populer".tr,
                    context,
                    Constants.tvPopuler,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget myDrawerItem(
          IconData icon, String title, BuildContext context, String path) =>
      ListTile(
        leading: const SizedBox(),
        title: Text(
          title,
          style: Sabitler.drawerStyle2,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                      path: path,
                      selectedIndex: 0,
                    )),
          );
        },
      );
  Widget myDrawerItem2(
          IconData icon, String title, BuildContext context, String path) =>
      ListTile(
        leading: const SizedBox(),
        title: Text(
          title,
          style: Sabitler.drawerStyle2,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                      path2: path,
                      selectedIndex: 1,
                    )),
          );
        },
      );
}
