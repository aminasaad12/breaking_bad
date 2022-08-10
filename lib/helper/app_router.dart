
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:breakingbad/business_logic/cubit/characters_cubit.dart';
import 'package:breakingbad/data/models/character_model.dart';
import 'package:breakingbad/data/repository/character_repository.dart';
import 'package:breakingbad/data/web_services/character_web_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Constants/strings.dart';
import '../presentation/screens/characters_details_screen.dart';
import '../presentation/screens/characters_screen.dart';


class AppRouter{
  late CharacterRepository characterRepository;
  late CharacterCubit characterCubit;

  AppRouter()
  {
     characterRepository=CharacterRepository( CharacterWebServices());
     characterCubit=CharacterCubit(characterRepository);

  }

  Route? generateRoute(RouteSettings settings){
    switch(settings.name){
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_)=>BlocProvider(
            create: (BuildContext context)=>CharacterCubit(characterRepository),
            child: CharactersScreen()));
      case charactersDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(builder: (_)=>CharactersDetailsScreen(character:character ,));
    }
    return null;


  }
}