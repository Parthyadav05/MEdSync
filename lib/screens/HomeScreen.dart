
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncmed/screens/shopkeeper_dashboard.dart';
import 'package:syncmed/screens/signin.dart';
import 'package:syncmed/widgets/bar_chart.dart';
import 'package:telephony/telephony.dart';

import 'medicine_generic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:syncmed/screens/chat_bot.dart';
import 'package:syncmed/screens/location.dart';
import 'package:syncmed/screens/meals.dart';
import 'package:syncmed/screens/services.dart';
import 'package:lottie/lottie.dart';
import 'community.dart';
import 'health_prediction.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Telephony telephony = Telephony.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool flag = true;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Drawer(
        child: Center(child: ElevatedButton(
          onPressed: (){
            _auth.signOut();

          },
          child: Text("LogOut"),
        ),),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(204, 204, 255, 1),
        elevation: 20,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        title: Text(
          'MedSync', style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold),),
        actions: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 30,
                width: 120,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: Colors.black54,
                      offset: Offset(2,2),
                    )
                  ],
                 color: Colors.deepPurple.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Seller Login" ,style:  TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(width: 5,),
                 Icon(FontAwesomeIcons.signIn ,color: Colors.black,),
                  ],
                ),
              ),
            ),
            onTap: (){
              Get.to(ShopkeeperDashboard());
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Card(
                color:Colors.black.withBlue(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 16,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Container(
                        child: Lottie.asset("assets/genericmedicine.json"),
                        height: 250,
                        width: MediaQuery.of(context).size.width,

                      ),
                    ),
                    ListTile(
                      title: BubbleSpecialOne(
                        text: 'Find and Buy Generic Medicines',
                        isSender: false,
                        color:  Colors.deepPurple.withOpacity(0.4),
                        textStyle: GoogleFonts.ubuntu(
                          fontSize: 12,
                          letterSpacing: 2,
                          color: Colors.tealAccent.shade100,
                        ),
                      ),

                      trailing:  Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Get Upto 50%-90% off',
                          style:GoogleFonts.ubuntu(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.tealAccent.shade100),
                        ),
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(MedicineAlternativesScreen());
                        },
                        style: TextButton.styleFrom(
                          elevation: 20,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          backgroundColor: Colors.deepPurple.shade400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child:  Text(
                          'Buy Generic Medicine',
                            style: GoogleFonts.ubuntu(
                                fontSize: 15,
                                color: AppColors.contentColorWhite),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(NotificationScreen());
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Card(
                        elevation: 20,
                        color: Colors.black.withBlue(20),
                        child:Stack(children:[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15,30,0,0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text("Medicine Reminder" ,style: GoogleFonts.ubuntu(letterSpacing: 1,fontWeight: FontWeight.bold,fontSize: 16,color: Colors.tealAccent.shade100),)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 30 ,60,0, 0),
                            child: Container(child: Lottie.asset("assets/yaad.json")),
                          )
                        ]) ,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(ChatBot());
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Card(
                        elevation: 20,
                        color: Colors.black.withBlue(20),
                        child:Stack(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 30, 0, 0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text("Chat Bot Powered by" ,style: GoogleFonts.ubuntu(letterSpacing:1,fontWeight: FontWeight.bold,fontSize: 16,color: Colors.tealAccent.shade100),)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB( 15 ,35 ,0, 0),
                            child: Lottie.asset("assets/gemini.json"),
                          ),
                
                        ]) ,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(HeartDiseasePrediction());
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Card(
                        elevation: 20,
                        color: Colors.black.withBlue(20),

                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Lottie.asset("assets/background.json"),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                                child: Lottie.asset("assets/heartattack.json"),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 110.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text("CardioCare AI" ,style: GoogleFonts.ubuntu(fontSize:16,letterSpacing:3,fontWeight: FontWeight.bold,color: Colors.tealAccent.shade100),)),
                              )
                            ],
                          ),

                      ),
                    ),
                  )
                ],),
              ),
              card(),


            ],
          ),
        ),
      ),
      bottomNavigationBar:GNav(
          rippleColor: Colors.white12, // tab button ripple color when pressed
          hoverColor: Colors.white24, // tab button hover color
          haptic: true, // haptic feedback
          tabBorderRadius: 15,
          tabActiveBorder: Border.all(color: Colors.black, width: 1), // tab button border
          tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
          tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
          curve: Curves.easeOutExpo, // tab animation curves
          duration: Duration(milliseconds: 300), // tab animation duration
          gap: 8, // the tab button gap between icon and text
          color: Colors.grey[800], // unselected icon color
          activeColor: Colors.indigo.shade500, // selected icon and text color
          iconSize: 30, // tab button icon size
          tabBackgroundColor: Colors.black26.withOpacity(0.1), // selected tab background color
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5), // navigation bar padding
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: FontAwesomeIcons.podcast,
              text: 'Community',
              onPressed:(){
                Get.to(CommunityPage());
              },
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
              onPressed: (){
                Get.to(location());
              },
            ),

          ]
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 15,
        onPressed: (){
          telephony.sendSms(
              to: "9045162855",
              message: "Hey I am not Feeling well Please Help Me"
          );
          telephony.sendSms(
              to: "8909420965",
              message: "Hey I am not Feeling well Please Help Me"
          );

        },
        child: FaIcon(FontAwesomeIcons.commentSms,size: 30,),
      ),
    );
  }

  Widget card() {
    return Card(
      elevation: 20,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      clipBehavior: Clip.antiAlias,
      color: Colors.black.withBlue(20),
      child: Column(
        children: [
           ListTile(
             leading: Icon(Icons.arrow_drop_down_circle),
             title: const Text('Fitness Tracker',style: TextStyle(color: Colors.white),),
             subtitle: Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(2),
               ),
               child: Text(
                 'Here!! Is Your Custom Tracker',
                 style: TextStyle(color: Colors.white.withOpacity(0.6)),
               ),
             ),
           ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'You can Add Daily Meal.And Track your calories ',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 20,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    backgroundColor: Colors.deepPurple.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Get.to(Meals());
                  },
                  child: Text('Add Meals',style: GoogleFonts.ubuntu(color:AppColors.contentColorWhite,fontWeight: FontWeight.bold),),
                ),
              ),

            ],
          ),

        ],
      ),
    );

  }



  _callNumber() async{
    const number = '8909420965'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}
