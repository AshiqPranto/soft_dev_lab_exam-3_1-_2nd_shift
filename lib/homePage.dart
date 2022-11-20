import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {


  var iconId,temperature,description,currentCityName;
  TextEditingController cityNameController = new TextEditingController();
  var lati,longi;
  var day1Date,day1Avg,day1Min,day1Max;
  var day2Date,day2Avg,day2Min,day2Max;
  var day3Date,day3Avg,day3Min,day3Max;
  var day4Date,day4Avg,day4Min,day4Max;
  var day5Date,day5Avg,day5Min,day5Max;
  var day6Date,day6Avg,day6Min,day6Max;
  var day7Date,day7Avg,day7Min,day7Max;

  @override
  void initState() {
    // TODO: implement initState
    getLocation();
    // getWeatherForecast();
    super.initState();
  }


  getWeatherForecast(String city) async {

    // getLocation();

    // print("current city = "+lati);


    final response = await get(Uri.parse("http://api.weatherapi.com/v1/forecast.json?key=fab373dba6fa48e39e241801222011&q=${city}&days=7&aqi=no&alerts=no"));
    final json = jsonDecode(response.body);
    print("Weather forcast");
    // print(json);

    setState(() {

      day1Date = json["forecast"]["forecastday"][0]["date"];
      day1Avg = json["forecast"]["forecastday"][0]["day"]["avgtemp_c"];
      day1Min = json["forecast"]["forecastday"][0]["day"]["mintemp_c"];
      day1Max = json["forecast"]["forecastday"][0]["day"]["maxtemp_c"];
      // day 2
      day2Date = json["forecast"]["forecastday"][1]["date"];
      day2Avg = json["forecast"]["forecastday"][1]["day"]["avgtemp_c"];
      day2Min = json["forecast"]["forecastday"][1]["day"]["mintemp_c"];
      day2Max = json["forecast"]["forecastday"][1]["day"]["maxtemp_c"];
      // day 3

      day3Date = json["forecast"]["forecastday"][2]["date"];
      day3Avg = json["forecast"]["forecastday"][2]["day"]["avgtemp_c"];
      day3Min = json["forecast"]["forecastday"][2]["day"]["mintemp_c"];
      day3Max = json["forecast"]["forecastday"][2]["day"]["maxtemp_c"];
      //day 4

      day4Date = json["forecast"]["forecastday"][3]["date"];
      day4Avg = json["forecast"]["forecastday"][3]["day"]["avgtemp_c"];
      day4Min = json["forecast"]["forecastday"][3]["day"]["mintemp_c"];
      day4Max = json["forecast"]["forecastday"][3]["day"]["maxtemp_c"];
      //day 5

      day5Date = json["forecast"]["forecastday"][5]["date"];
      day5Avg = json["forecast"]["forecastday"][5]["day"]["avgtemp_c"];
      day5Min = json["forecast"]["forecastday"][5]["day"]["mintemp_c"];
      day5Max = json["forecast"]["forecastday"][5]["day"]["maxtemp_c"];
      //day 6

      day6Date = json["forecast"]["forecastday"][5]["date"];
      day6Avg = json["forecast"]["forecastday"][5]["day"]["avgtemp_c"];
      day6Min = json["forecast"]["forecastday"][5]["day"]["mintemp_c"];
      day6Max = json["forecast"]["forecastday"][5]["day"]["maxtemp_c"];
      // day 7

      day7Date = json["forecast"]["forecastday"][6]["date"];
      day7Avg = json["forecast"]["forecastday"][6]["day"]["avgtemp_c"];
      day7Min = json["forecast"]["forecastday"][6]["day"]["mintemp_c"];
      day7Max = json["forecast"]["forecastday"][6]["day"]["maxtemp_c"];

    });
    // var name = json["location"]["name"];
    // print("name = "+name);
    // print(lati);
    // print(longi);
    // print(json["location"]["name"]);
    // print(day1Date);
    // print(day1Avg);
    // print(day1Max);
    // print(day1Min);
  }


  getWeather() async{
    print("clicked");
    String cityName = cityNameController.text;
    // String cityName = "dhaka";
    final queryparameter = {
      "q": cityName,
      "key": "fab373dba6fa48e39e241801222011"
    };
    Uri uri = new Uri.http("api.weatherapi.com","/v1/current.json",queryparameter);
    final jsonData = await get(uri);
    final json = jsonDecode(jsonData.body);
    // print(json);
    currentCityName = json["location"]["name"];
    setState(() {
      currentCityName = json["location"]["name"];
      temperature = json["current"]["temp_c"];
      description = json["current"]["condition"]["text"];
      iconId = json["current"]["condition"]["icon"];
      // iconId = iconId.substring(2);
      iconId = "https:"+iconId;
    });
    getWeatherForecast(currentCityName);
  }
  getLocation() async{
    print("hello 0");
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    lati = position.latitude;
    longi = position.longitude;
    final queryparameter = {
      "q": lati,
      "q": longi,
      "key": "fab373dba6fa48e39e241801222011"
    };
    // Uri uri = new Uri.http("api.weatherapi.com","/v1/current.json",queryparameter);
    // final response = await get(uri);
    final response = await get(Uri.parse("http://api.weatherapi.com/v1/current.json?key=fab373dba6fa48e39e241801222011&q=${lati},${longi}&aqi=no"));
    // final response = await get(Uri.encodeFull("api.weatherapi.com","/v1/current.json?key=fab373dba6fa48e39e241801222011&q=23.72,90.41"));
    final json = jsonDecode(response.body);
    // print(json);
    currentCityName = json["location"]["name"];
    // print("city name = "+currentCityName);
    setState(() {
      currentCityName = json["location"]["name"];
      temperature = json["current"]["temp_c"];
      description = json["current"]["condition"]["text"];
      iconId = json["current"]["condition"]["icon"];
      // iconId = iconId.substring(2);
      iconId = "https:"+iconId;
    });
    getWeatherForecast(currentCityName);
    print("icon Id = ");
    print(iconId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Weather App"),
          ),
          body:  Center(
            child: Container(
              width: 500,
              height: 800,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 4),
                borderRadius: BorderRadius.all(Radius.circular(200)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.network((iconId == null? "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg":iconId)),
                    // Image(image: NetworkImage(iconId)),
                    // NetworkImage(iconId);

                    // I tried to add icon but it is not working, I will try this again
                    // FadeInImage(placeholder: , image: iconId),
                    // Image.network(iconId,
                    //   height: 100,
                    //   width: 100,
                    // ),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  (iconId == null ? "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg" : iconId)
                                // "https:///cdn.weatherapi.com/weather/64x64/day/116.png"
                                // "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg"
                              )
                          )
                      ),
                    ),
                    Text((currentCityName == null ? "loading" : currentCityName),
                        style: TextStyle(
                            fontSize: 30
                        )
                    ),
                    Text((temperature == null ? "loading" : temperature.toString())+"\u00B0C",
                      style: TextStyle(
                          fontSize: 40
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text((description == null ? "loading" : description.toString()),
                      style: TextStyle(
                          fontSize: 30
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                        width: 300,
                        child:
                        TextField(
                          controller: cityNameController,
                        )
                    ),

                    SizedBox(height: 30,),
                    ElevatedButton(onPressed: getWeather, child: Text("Search",
                      style: TextStyle(
                        fontSize: 25,

                      ),
                    ),
                    ),
                    SizedBox(height: 60,),
                    ElevatedButton(onPressed: getLocation, child: Text("Get your Locatoin Weather",
                      style: TextStyle(
                        fontSize: 20
                      ),
                    )
                    ),
                    SizedBox(height: 30,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Day 1 : "+(day1Date == null ? "loading" : day1Date.toString())),
                              Text("Max temp: "+(day1Max == null ? "loading": day1Max.toString())+"\u00B0C"),
                              Text("Min temp: "+(day1Min == null ? "loading": day1Min.toString())+"\u00B0C"),
                              Text("Average temp: "+(day1Avg == null ? "loading": day1Avg.toString())+"\u00B0C")
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Day 2 : "+(day2Date == null ? "loading" : day2Date.toString())),
                              Text("Max temp: "+(day2Max == null ? "loading": day2Max.toString())+"\u00B0C"),
                              Text("Min temp: "+(day2Min == null ? "loading": day2Min.toString())+"\u00B0C"),
                              Text("Average temp: "+(day2Avg == null ? "loading": day2Avg.toString())+"\u00B0C")
                            ],
                          ),
                          // day 3 column
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Day 3 : "+(day3Date == null ? "loading" : day3Date.toString())),
                              Text("Max temp: "+(day3Max == null ? "loading": day3Max.toString())+"\u00B0C"),
                              Text("Min temp: "+(day3Min == null ? "loading": day3Min.toString())+"\u00B0C"),
                              Text("Average temp: "+(day3Avg == null ? "loading": day3Avg.toString())+"\u00B0C")
                            ],
                          ),
                          // day 4
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Day 4 : "+(day4Date == null ? "loading" : day4Date.toString())),
                              Text("Max temp: "+(day4Max == null ? "loading": day4Max.toString())+"\u00B0C"),
                              Text("Min temp: "+(day4Min == null ? "loading": day4Min.toString())+"\u00B0C"),
                              Text("Average temp: "+(day4Avg == null ? "loading": day4Avg.toString())+"\u00B0C")
                            ],
                          ),
                          // day 5
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Day 5 : "+(day5Date == null ? "loading" : day5Date.toString())),
                              Text("Max temp: "+(day5Max == null ? "loading": day5Max.toString())+"\u00B0C"),
                              Text("Min temp: "+(day5Min == null ? "loading": day5Min.toString())+"\u00B0C"),
                              Text("Average temp: "+(day5Avg == null ? "loading": day5Avg.toString())+"\u00B0C")
                            ],
                          ),
                          // day 7
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Day 2 : "+(day7Date == null ? "loading" : day7Date.toString())),
                              Text("Max temp: "+(day7Max == null ? "loading": day7Max.toString())+"\u00B0C"),
                              Text("Min temp: "+(day7Min == null ? "loading": day7Min.toString())+"\u00B0C"),
                              Text("Average temp: "+(day7Avg == null ? "loading": day7Avg.toString())+"\u00B0C")
                            ],
                          ),

                        ],
                      ),
                    )
                    // this button is for fetch current location
                    // ElevatedButton(onPressed: getLocation, child: Text("Get Current Location")),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}

