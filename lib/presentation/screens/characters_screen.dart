import 'package:breakingbad/Constants/my_colors.dart';
import 'package:breakingbad/business_logic/cubit/characters_cubit.dart';
import 'package:breakingbad/business_logic/cubit/characters_state.dart';
import 'package:breakingbad/data/models/character_model.dart';
import 'package:breakingbad/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacters;
  bool isSearching =false;
  final TextEditingController _searchingEditingController = TextEditingController();



  void addtosearchingForcharacter(String searchingcharacter) {
    searchedForCharacters=allCharacters.where((character) =>
        character.name.toLowerCase().startsWith(searchingcharacter)).toList();
  setState(() {

  });

  }
  List<Widget> IconButtonBuildAppbarAction() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: MyColors.myGrey),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _StartSearch,
          icon: Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }
  void _StartSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      isSearching = true;
    });

  }
  void _stopSearching() {
    _clearSearch();

    setState(() {
      isSearching = false;
    });
  }
  void _clearSearch() {
    setState(() {
      _searchingEditingController.clear();
    });
  }
  Widget BuildSearchTextFeild(){
    return TextField(
      controller: _searchingEditingController,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: 'Find a character....',
        border: InputBorder.none,
        hintStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
          fontWeight: FontWeight.w900,

        ),
      ),
      style: TextStyle(
        fontSize: 19.0,
        color: Colors.black,
        fontWeight: FontWeight.w900,

      ),
      onChanged: (searchingcharacter){
        addtosearchingForcharacter(searchingcharacter);
      },
    );
  }
  Widget buildBlocWidget() {
    return BlocBuilder<CharacterCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {

          allCharacters = (state).characters;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }
  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchingEditingController.text.isEmpty ?
      allCharacters.length
          : searchedForCharacters.length,
      itemBuilder:(ctx, index) {

        return CharacterItem(
          character:_searchingEditingController.text.isEmpty ?
          allCharacters[index]
              :searchedForCharacters[index],);

      },
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharacterCubit>(context).getAllCharacters();
  }
  Widget AppBarText(){
    return  Text('Characters',
      style: TextStyle(
        color: Colors.black,
      ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        leading: isSearching ? BackButton(color: Colors.black,) : Container(),
        title: isSearching ? BuildSearchTextFeild() :AppBarText(),
        actions: IconButtonBuildAppbarAction(),
      ),
      body:buildBlocWidget(),
    );
  }



}
