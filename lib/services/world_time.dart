import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  late String location;// location name for UI
  late String time;// time in that location
  late String flag;// url to an asset flag icon
  late String url;// location url for api endpoint
  late bool isDayTime;// true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async{// we used Future<void> instead of just void so that we can use await keyword in loading.dart at line 15

    try{
      //make the request
      var uri= Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      Response response = await get(uri);
      Map data= jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set time property
      isDayTime = now.hour>6 && now.hour<20 ? true : false;//daytime :6AM-8PM
      time=DateFormat.jm().format(now);
    }
    catch(e){
      print(e);
      time='could not get time data';
    }
  }
}