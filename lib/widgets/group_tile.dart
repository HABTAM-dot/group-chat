import 'package:ecommerce/widgets/widget.dart';
import 'package:flutter/material.dart';

import '../pages/chatpage.dart';

class GroupTile extends StatefulWidget {
  final String username;
  final String groupId;
  final String groupName;
  const GroupTile(
      {super.key,
      required this.username,
      required this.groupId,
      required this.groupName});

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: () {
       nextScreen(context, chatPage(groupId: widget.groupId,groupName: widget.groupName,username: widget.username,));
         },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
         subtitle: Text('join the conversation as ${widget.username}',style: TextStyle(fontSize: 
         13)),
          title: Text(widget.groupName,style: const TextStyle(fontWeight: FontWeight.bold ),),
        ),
      ),
    );
  }
}
