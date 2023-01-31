import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:movie_db_api/constants/auth_style.dart';
import 'package:movie_db_api/constants/constants.dart';
import 'package:movie_db_api/constants/style_constants.dart';
import 'package:movie_db_api/drawer.dart';
import 'package:movie_db_api/main.dart';
import 'package:movie_db_api/models/moviemodel.dart';
import 'package:movie_db_api/models/tvmodel.dart';
import 'package:movie_db_api/pages/movie_home.dart';
import 'package:movie_db_api/pages/search_home.dart';
import 'package:movie_db_api/pages/tv_home.dart';
import 'package:movie_db_api/provider/google_sign_in.dart';
import 'package:movie_db_api/services/movie_api.dart';
import 'package:movie_db_api/services/tv_api.dart';
import 'package:provider/provider.dart';

import '../models/searchmodel.dart';
import '../services/search.dart';

class MyHomePage extends StatefulWidget {
  final String? path;
  final String? path2;
  final int? selectedIndex;

  const MyHomePage({Key? key, this.path, this.path2, this.selectedIndex})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? actualPath;
  String? actualPath2;

  late Future<List<Moviemodel>> _movielistFuture;
  late Future<List<Tvmodel>> _tvlistFuture;
  late Future<List<SearchModel>> _searchlistFuture;
  final user = MyApp.auth.currentUser!;

  int pageMovie = 1;
  String query = '';
  String dil = Get.locale!.languageCode;
  late bool status;

  bool initialPageMovie = true;
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 1.0, keepScrollOffset: true);
  int pageTv = 1;
  bool pageTvChecker = false;
  bool pageMovieChecker = false;
  bool pageMovieChecker1 = false;
  bool _showBackToTopButton = false;
  bool _showBackToTopButtonTv = false;
  late int selectedIndex;
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
    //throw Exception("dispose() Exception..!!!");
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 3), curve: Curves.linear);
  }

  void _scrollToTopTv() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 3), curve: Curves.linear);
  }

  @override
  void initState() {
    super.initState();
    actualPath = widget.path;
    actualPath2 = widget.path2;
    selectedIndex = widget.selectedIndex ?? 0;

    _movielistFuture =
        MovieApi.fetchAllMovies(pageMovie, true, dil, path: actualPath);
    _tvlistFuture = Tvapi.fetchAllTv(pageTv, true, dil, path: actualPath2);

    _searchlistFuture = SearchAp.fetchAllSearch(query, true, dil);

    _scrollController.addListener(() {
      if (pageMovieChecker &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        if (actualPath == "movie/popular" && pageMovie == 2) {
          pageMovie = 4;
        }
        print(pageMovie);
        pageMovie++;
        setState(() {
          _movielistFuture =
              MovieApi.fetchAllMovies(pageMovie, false, dil, path: actualPath);
        });
      }

      setState(() {
        if (pageMovieChecker && _scrollController.offset >= 400) {
          _showBackToTopButton = true; // show the back-to-top button
        } else {
          _showBackToTopButton = false; // hide the back-to-top button
        }
      });

      if (pageTvChecker &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        if (actualPath2 == "tv/popular" && pageTv == 5) {
          pageTv = 8;
        } else if (actualPath2 == "tv/on_the_air" && pageTv == 2) {
          pageTv = 4;
        } else if (actualPath2 == "tv/on_the_air" && pageTv == 14) {
          pageTv = 16;
        }
        pageTv++;
        setState(() {
          _tvlistFuture =
              Tvapi.fetchAllTv(pageTv, false, dil, path: actualPath2);
        });
      }
      setState(() {
        if (pageTvChecker && _scrollController.offset >= 400) {
          _showBackToTopButtonTv = true; // show the back-to-top button
        } else {
          _showBackToTopButtonTv = false; // hide the back-to-top button
        }
      });
    });
  }

  List<Widget> pages(BuildContext context) {
    return <Widget>[
      FutureBuilder<List<Moviemodel>>(
        future: _movielistFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Moviemodel> _listem = snapshot.data!;
            return ListView.builder(
              controller: _scrollController,
              itemCount: _listem.length,
              itemBuilder: (context, index) {
                var oankiFilm = _listem[index];
                pageTvChecker = false;
                pageMovieChecker = true;
                return MovieHome(moviemodel: oankiFilm, index: index);
              },
            );
          } else if (snapshot.hasError) {
            pageMovieChecker1 = true;
            return Center(
              child: Text("error".tr),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                value: 200,
              ),
            );
          }
        },
      ),
      FutureBuilder<List<Tvmodel>>(
        future: _tvlistFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Tvmodel> _listem = snapshot.data!;

            return ListView.builder(
              controller: _scrollController,
              itemCount: _listem.length,
              itemBuilder: (context, index) {
                var oankiTv = _listem[index];
                pageTvChecker = true;
                pageMovieChecker = false;
                return TvHome(tvmodel: oankiTv, index: index);
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                value: 200,
              ),
            );
          }
        },
      ),
      FutureBuilder<List<SearchModel>>(
        future: _searchlistFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<SearchModel> _listem = snapshot.data!;

            return ListView.builder(
              controller: _scrollController,
              itemCount: _listem.length,
              itemBuilder: (context, index) {
                var oankiSearch = _listem[index];
                pageTvChecker = false;
                pageMovieChecker = true;
                return SearchHome(searchmodel: oankiSearch, index: index);
              },
            );
          } else if (snapshot.hasError) {
            pageMovieChecker1 = true;
            return Center(
              child: Text("error".tr),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                value: 200,
              ),
            );
          }
        },
      ),
      Column(
        children: [
          user.photoURL != null
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(user.photoURL!),
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
                ),
          user.displayName != null
              ? Text(
                  user.displayName!,
                  style: Sabitler.baslikStyle,
                )
              : Text(
                  "User".tr,
                  //user.email.toString(),
                  style: Sabitler.baslikStyle,
                ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                SizedBox(
                  //hesabı sil
                  height: 120,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(56),
                        topLeft: Radius.circular(56),
                        bottomRight: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    color: Constants.kProfilColor,
                    shadowColor: Colors.black54,
                    elevation: 12,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ListTile(
                        leading: const Icon(
                          Icons.dangerous,
                          size: 68,
                          color: Colors.white70,
                        ),
                        onTap: () {
                          CoolAlert.show(
                            context: context,
                            backgroundColor: Constants.kProfilColor,
                            type: CoolAlertType.confirm,
                            title: 'Are you sure?'.tr,
                            text: 'Do you want to delete this account?'.tr,
                            loopAnimation: true,
                            confirmBtnText: 'Yes'.tr,
                            onConfirmBtnTap: () async {
                              final provider =
                                  Provider.of<GoogleSignInProvider>(context,
                                      listen: false);
                              provider.logout();
                              await MyApp.auth.currentUser!.delete();
                              Navigator.of(context).pop();
                            },
                            cancelBtnText: 'No'.tr,
                            confirmBtnColor: Constants.kProfilColor,
                          );
                        },
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10, right: 50),
                          child: Center(
                            child: Text(
                              "Delete Account".tr,
                              style: kHeadline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  //çıkış yap
                  height: 120,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(56),
                        topLeft: Radius.circular(56),
                        bottomRight: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    color: Constants.kProfilColor,
                    elevation: 12,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ListTile(
                        leading: const Icon(
                          Icons.exit_to_app,
                          size: 68,
                          color: Colors.white70,
                        ),
                        onTap: () {
                          CoolAlert.show(
                            context: context,
                            backgroundColor: Constants.kProfilColor,
                            type: CoolAlertType.confirm,
                            title: 'Are you sure?'.tr,
                            text: 'Do you want to logout?'.tr,
                            loopAnimation: true,
                            confirmBtnText: 'Yes'.tr,
                            onConfirmBtnTap: () async {
                              final provider =
                                  Provider.of<GoogleSignInProvider>(context,
                                      listen: false);
                              provider.logout();
                              Navigator.of(context).pop();
                              await MyApp.auth.signOut();
                            },
                            cancelBtnText: 'No'.tr,
                            confirmBtnColor: Constants.kProfilColor,
                          );
                        },
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10, right: 50),
                          child: Center(
                            child: Text(
                              "Logout".tr,
                              style: kHeadline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ];
  }

  List<String> appBarHeadings = [
    "Movies".tr,
    "Tv Shows".tr,
    "Search".tr,
    "Profile".tr
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Get.locale!.languageCode == 'en') {
      status = true;
    } else {
      status = false;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey.shade500,
        appBar: AppBar(
          actions: [
            /* IconButton(
              onPressed: () {
                Get.changeTheme(
                    Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
                Get.snackbar(
                  "Thema Changed".tr,
                  "DarkMode ${Get.isDarkMode}".tr,
                );
              },
              icon: const Icon(Icons.change_circle),
            ), */
            FlutterSwitch(
              width: 80.0,
              height: 45.0,
              toggleSize: 45.0,
              value: status,
              borderRadius: 30.0,
              padding: 2.0,
              activeToggleColor: Colors.blue.shade200,
              inactiveToggleColor: Colors.red.shade200,
              activeColor: Colors.blue.shade200,
              inactiveColor: Colors.red.shade200,
              activeIcon: Image.asset(
                "assets/images/english.png",
              ),
              inactiveIcon: Image.asset(
                "assets/images/turkey.png",
              ),
              onToggle: (val) {
                setState(() {
                  status = val;
                  MovieApi.list.clear();
                  Tvapi.list.clear();
                  //SearchAp.list.clear();
                  Get.updateLocale(Get.locale == const Locale('tr', 'TR')
                      ? const Locale('en', 'US')
                      : const Locale('tr', 'TR'));
                  print(Get.locale!.languageCode);
                  dil = Get.locale!.languageCode;
                  _movielistFuture = MovieApi.fetchAllMovies(
                      pageMovie, false, dil,
                      path: actualPath);
                  _tvlistFuture =
                      Tvapi.fetchAllTv(pageTv, true, dil, path: actualPath2);
                  _searchlistFuture = SearchAp.fetchAllSearch(query, true, dil);

                  Get.snackbar(
                      'Language Changed'.tr, 'Language ${Get.locale}'.tr);
                });
              },
            ),
          ],
          bottom: selectedIndex == 2
              ? PreferredSize(
                  child: TextField(
                    onTap: () {
                      _searchlistFuture =
                          SearchAp.fetchAllSearch(query, true, dil);
                    },
                    onChanged: (text) {
                      setState(() {
                        _searchlistFuture =
                            SearchAp.fetchAllSearch(text, true, dil);
                      });
                    },
                    decoration: InputDecoration(
                      icon: const Icon(Icons.search, color: Colors.white70),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.blue)),
                      filled: true,
                      fillColor: Colors.white70,
                      focusColor: Colors.amber,
                      hintText: 'Search Shows'.tr,
                    ),
                  ),
                  preferredSize: const Size.fromHeight(kToolbarHeight))
              : null,
          backgroundColor: Colors.blueGrey.shade900,
          title: Text(appBarHeadings.elementAt(selectedIndex)),
        ),
        floatingActionButton: Stack(
          fit: StackFit.expand,
          children: [
            Visibility(
              visible: _showBackToTopButton,
              child: Container(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  heroTag: 'Movie',
                  backgroundColor: Colors.blueGrey[500],
                  hoverColor: Colors.blueGrey[300],
                  onPressed: () {
                    if (pageMovieChecker) {
                      _scrollToTop();
                    }
                  },
                  child: const Icon(
                    Icons.navigation,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _showBackToTopButtonTv,
              child: Container(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  heroTag: 'TV',
                  backgroundColor: Colors.blueGrey[500],
                  hoverColor: Colors.blueGrey[300],
                  onPressed: () {
                    if (pageTvChecker) {
                      _scrollToTopTv();
                    }
                  },
                  child: const Icon(
                    Icons.navigation,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(child: pages(context).elementAt(selectedIndex)),
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: const MainDrawer(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.movie),
              label: 'Movies'.tr,
              backgroundColor: Colors.white54,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.tv),
              label: 'Tv Shows'.tr,
              backgroundColor: Colors.white54,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: 'Search'.tr,
              backgroundColor: Colors.white54,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: 'Profile'.tr,
              backgroundColor: Colors.white54,
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.blue.shade800,
          unselectedItemColor: Colors.blueGrey.shade500,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
