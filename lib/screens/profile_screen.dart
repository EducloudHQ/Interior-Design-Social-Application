import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var profileModel = context.watch<User>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text('Profile'),
        centerTitle: true,
      ),

      body:SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
