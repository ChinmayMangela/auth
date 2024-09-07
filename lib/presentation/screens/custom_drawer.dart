import 'package:auth/main.dart';
import 'package:auth/services/authentication/authentication_service.dart';
import 'package:auth/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final _authenticationService = AuthenticationService();

  void _signOut() async {
    Utils.showCircularProgressIndicator(context);
    await _authenticationService.signOut();
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Column(
            children: [
              const DrawerHeader(
                  child: Icon(
                Icons.person,
                color: Colors.black,
              )),
              ListTile(
                leading: const Icon(FontAwesomeIcons.link),
                title: Text('${FirebaseAuth.instance.currentUser?.email}'),
              )
            ],
          ),
          ListTile(
            leading: IconButton(
              onPressed: _signOut,
              icon: const Icon(Icons.logout),
            ),
          )
        ],
      ),
    );
  }
}
