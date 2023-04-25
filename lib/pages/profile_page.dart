import 'package:ecommerce/pages/home_page.dart';
import 'package:ecommerce/servics/auth_service.dart';
import 'package:flutter/material.dart';

import '../auth/login_page.dart';
import '../widgets/widget.dart';

class ProfilePage extends StatefulWidget {
  String username;
  String email;
  ProfilePage({super.key, required this.username, required this.email});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Authservice authservice = Authservice();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(
          'profile',
          style: TextStyle(
              color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.symmetric(vertical: 50),
        children: [
          Icon(
            Icons.account_circle,
            size: 120,
            color: Colors.blueGrey,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            widget.username,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Divider(
            height: 2,
          ),
          ListTile(
            onTap: () {
              nextScreen(context, HomePage());
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: Icon(Icons.group),
            title: Text("Group", style: TextStyle(color: Colors.black)),
          ),
          ListTile(
            onTap: () {},
            selected: true,
            selectedColor: Theme.of(context).primaryColor,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: Icon(Icons.group),
            title: Text("Profile", style: TextStyle(color: Colors.black)),
          ),
          ListTile(
            onTap: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.red,
                            )),
                        IconButton(
                            onPressed: () async {
                              await authservice.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                  (route) => false);
                            },
                            icon: Icon(
                              Icons.done,
                            )),
                      ],
                    );
                  });
            },
            selectedColor: Theme.of(context).primaryColor,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout", style: TextStyle(color: Colors.black)),
          )
        ],
      )),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 170),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.account_circle,
              size: 200,
              color: Colors.grey[700],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('full name',style: TextStyle(fontSize: 17),),
                Text(widget.username,style:TextStyle(fontSize: 17)),
              ],
            ),
            Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Email',style: TextStyle(fontSize: 17),),
                Text(widget.email,style:TextStyle(fontSize: 17)),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
