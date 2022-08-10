
import 'package:breakingbad/Constants/my_colors.dart';
import 'package:breakingbad/data/models/character_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final Character character;

  CharactersDetailsScreen({Key? key, required this.character}) : super(key: key);


  Widget BuildSliverAppBar(){
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickname,
          style: TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

  }
  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 3,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(
        slivers:
        [
          BuildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        characterInfo('Nickname : ', character.nickname),
                        buildDivider(240),
                        characterInfo('Job : ', character.occupation.join(' / ')),
                        buildDivider(281),
                        characterInfo('Appeared in : ', character.appearance.join(' / ')),
                        buildDivider(215),
                        characterInfo('Status : ', character.status),
                        buildDivider(257),
                        characterInfo('Birthday : ', character.birthday),
                        buildDivider(244),
                        character.betterCallSaulAppearance.isEmpty ? Container() :
                        characterInfo('BetterCallSaulAppearance : ', character.betterCallSaulAppearance.join(' / ')),
                        character.betterCallSaulAppearance.isEmpty ? Container() :
                        buildDivider(100),

                      ],

                    ),
                  ),
                ]
              ))
        ],
      ),

    );
  }
}
