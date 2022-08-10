import 'package:breakingbad/data/models/character_model.dart';
import 'package:breakingbad/data/web_services/character_web_services.dart';

class CharacterRepository{
  final  CharacterWebServices characterWebServices;

  CharacterRepository(this.characterWebServices);


  Future<List<Character>> getAllCharacters() async{
    final characters = await characterWebServices.getAllCharacters();
    return characters.map((character) => Character.fromJson(character)).toList();

  }
}