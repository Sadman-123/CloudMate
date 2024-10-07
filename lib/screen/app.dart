import 'package:flutter/cupertino.dart';
import 'package:jossweather/custom_widget/location_card.dart';
import 'package:jossweather/custom_widget/temperature_and_icon.dart';
import 'package:jossweather/provider/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../style/style.dart';
class App extends StatelessWidget {
  WeatherProvider weather = Get.find();
  @override
  Widget build(BuildContext context) {
    var mdh = MediaQuery.sizeOf(context).height;
    var mdw = MediaQuery.sizeOf(context).width;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.blueAccent.shade700,
      ),
      child: Container(
        height: double.infinity,
        decoration: Linear_BG_Decoration(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: mdw * 0.84,
                    margin: EdgeInsets.only(top: 25),
                    child: CupertinoTextField(
                      controller: weather.ctr,
                      placeholder: "Enter City",
                      decoration: Input_decor(),
                      placeholderStyle: Input_TextHolder(mdw),
                      prefix: Prefix_Icon(),
                      padding: EdgeInsets.all(18),
                    ),
                  ),
                  SizedBox(height: mdh * 0.02),
                  CupertinoButton.filled(
                    child: Text("Search"),
                    onPressed: () {
                      weather.getDatas();
                    },
                  ),
                  SizedBox(height: mdh * 0.050),
                  LocationCard(mdw: mdw, mdh: mdh),
                  TemperatureAndIcon(mdw: mdw, mdh: mdh),
                  SizedBox(height: mdh * 0.04),
                  Obx((){
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Stack(
                              children: [
                                Card(
                                  child: Container(
                                    width: mdw*0.45,
                                    height: mdh*0.25,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${weather.wind} km/h",style: Card_Title(mdw),),
                                        Text("Wind Speed",style: Card_SubTitle(mdw),)
                                      ],
                                    ),
                                  ),
                                  color: CupertinoColors.systemFill,
                                ),
                                Positioned(
                                  top: -35,
                                  left: 55,
                                  child: Image.asset("assets/wind.png",width: mdw*0.23,),
                                )
                              ],
                              clipBehavior: Clip.none,
                            ),
                          ),
                          Container(
                            child: Stack(
                              children: [
                                Card(
                                  child: Container(
                                    width: mdw*0.45,
                                    height: mdh*0.25,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Obx(()=>Text("${weather.humidity.value}%",style: TextStyle(fontSize: mdw*0.07,fontWeight: FontWeight.bold,color: CupertinoColors.white,fontFamily: "apple"),),),
                                        Text("humidity",style: TextStyle(fontSize: mdw*0.04,color: CupertinoColors.white,fontFamily: "apple"),)
                                      ],
                                    ),
                                  ),
                                  color: CupertinoColors.systemFill,
                                ),
                                Positioned(
                                  top: -35,
                                  left: 55,
                                  child: Image.asset("assets/humidity.png",width: mdw*0.23,),
                                )
                              ],
                              clipBehavior: Clip.none,
                            ),
                          ),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
