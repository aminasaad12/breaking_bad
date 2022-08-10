

import 'package:breakingbad/data/models/character_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;
  CharactersLoaded(this.characters);
}




