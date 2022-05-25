import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool>saveData({
  required String key,
  required dynamic value,

})async{
    if(value is bool){
      return sharedPreferences.setBool(key, value);

    }
    else if(value is String){
      return sharedPreferences.setString(key, value);

    }
    else if(value is int){
      return sharedPreferences.setInt(key, value);

    }
    else{
      return sharedPreferences.setDouble(key, value);

    }

  }
  static dynamic getSavedData({required String key,}){
    return   sharedPreferences.get(key);
  }
  static Future clearCache({required String key})async{

   await sharedPreferences.remove(key);
  }
}
