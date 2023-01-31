import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String? title;
  const ProfilePage({Key? key, this.title}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.blueGrey.shade900,
      title: Text(widget.title.toString()),
    ));
  }
}
