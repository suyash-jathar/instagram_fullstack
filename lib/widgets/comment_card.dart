import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({super.key});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    final User user =Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 16,),
      child: Row(children: [
        
        CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 18,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                      text: 'username',
                      style:TextStyle(fontWeight: FontWeight.bold)
                    ),
                      TextSpan(
                      text: 'some description to insert',
                      style:TextStyle(fontWeight: FontWeight.bold)
                    ),
                    ]
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 4),
                child: Text('23/12/23',style:TextStyle(fontWeight: FontWeight.w400,)),
                ),
                Container(
                  
                  padding: const EdgeInsets.all(8),
                  child: Icon(Icons.favorite,size: 16,),
                )
              ],
            ),
          ),
        )
      ],
      ),
    );
  }
}