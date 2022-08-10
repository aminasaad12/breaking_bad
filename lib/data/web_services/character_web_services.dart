
import 'package:breakingbad/Constants/strings.dart';
import 'package:dio/dio.dart';


class CharacterWebServices{
  late Dio dio;
  CharacterWebServices(){

    BaseOptions baseOptions =BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true ,
      connectTimeout: 20*1000,
      receiveTimeout:20*1000,
    );
    dio= Dio(baseOptions);
  }
  Future<List<dynamic>> getAllCharacters() async{
    try {
      Response response= await dio.get('characters');
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }

  }


  }