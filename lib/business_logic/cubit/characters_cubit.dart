

import 'package:breakingbad/business_logic/cubit/characters_state.dart';
import 'package:breakingbad/data/models/character_model.dart';
import 'package:breakingbad/data/repository/character_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CharacterCubit extends Cubit<CharactersState>
{
   final CharacterRepository characterRepository;
   List<Character> characters = [];

  CharacterCubit(this.characterRepository) : super(CharactersInitial());

  List<Character> getAllCharacters(){
    characterRepository.getAllCharacters()
        .then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;

    });
return characters;
  }

}