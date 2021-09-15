import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const colorRad = Colors.red;
const colorBlack = Colors.black;
const colorGreen = Colors.green;
const colorBlue100 = Color(0xffbbdefb);

bool alarmNote = false ;
bool alarmElectrical = false ;
bool appOnlineAlarm = true ;
bool appOnlineElectric = true ;
String normalData = 'Normal';
String alarmData = 'Alarm';

var textAlarmNotify = alarmNote?alarmData:normalData;
var textAlarmElectric = alarmElectrical?alarmData:normalData;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('test').snapshots();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.brown,
            leading: const Icon(
              Icons.menu,
              color: Colors.black,
              size: 40,
            ),
            title: const Center(
              child: Text(
                'Alarm Notification',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //------------Body-----------------
                      //------------part1-----------------
                      //------------Body-----------------
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                        padding: const EdgeInsets.all(2),
                        color: Colors.white,
                        height: 135,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(70),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                height: 131,
                                color: Colors.blueGrey,
                                child: Row(
                                  children: [
                                    //------------------------
                                    //------Part ICon-----------
                                    //------------------------
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        color: Colors.white,
                                        child: Icon(
                                          Icons.notifications,
                                          color: alarmNote?colorRad:colorBlack,
                                          size: 100,
                                        ),
                                      ),
                                    ),
                                    //-----------------------------
                                    //-----------Point Active------
                                    //-----------------------------
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 70),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          margin: const EdgeInsets.only(right: 1),
                                          //padding: const EdgeInsets.all(25),
                                          //color: Colors.green,
                                          child:  Expanded(
                                            child: Icon(
                                              Icons.lightbulb,
                                              color: appOnlineAlarm?colorGreen:colorRad,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    //----------------------------
                                    //-------Text And Button------
                                    //-----------------------------
                                    partBodyAPP('Alarm Note', textAlarmNotify , alarmNote),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //------------Body-----------------
                      //------------part2-----------------
                      //------------Body-----------------
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        padding: const EdgeInsets.all(2),
                        color: Colors.white,
                        height: 135,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(70),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                height: 131,
                                color: Colors.blueGrey,
                                child: Row(
                                  children: [
                                    //------------------------
                                    //------Part ICon-----------
                                    //------------------------
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        color: Colors.white,
                                        child: Icon(
                                          Icons.lightbulb,
                                          color: alarmElectrical?colorRad:colorBlack,
                                          size: 100,
                                        ),
                                      ),
                                    ),
                                    //-----------------------------
                                    //-----------Point Active------
                                    //-----------------------------
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 70),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          margin: const EdgeInsets.only(right: 1),
                                          //padding: const EdgeInsets.all(25),
                                          //color: Colors.red,
                                          child:  Expanded(
                                            child: Icon(
                                              Icons.lightbulb,
                                              color: appOnlineElectric?colorGreen:colorRad,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    //----------------------------
                                    //-------Text And Button------
                                    //-----------------------------
                                    partBodyAPP('Electrical', textAlarmElectric, alarmElectrical),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

Widget partBodyAPP(
    var titlePartBody,
    var notifyTitle,
    bool alarmText,
    ) {
  return Container(
    height: 115,
    width: 230,
    color: Colors.blueGrey,
    child: Column(
      children: [
        //--------------------------------
        //-------Text-------------
        //----------------------------
        Container(
          height: 35,
          color: Colors.blueGrey,
          child: Text(
            '$titlePartBody',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
        ),
        //--------------------------------
        //-------Text-------------
        //----------------------------
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 35,
            width: 150,
            color: alarmText?colorRad:colorBlue100,
            child: Center(
              child: Text(
                '$notifyTitle',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        //----------------------------
        //---------Button-------------
        //----------------------------
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 45,
            width: 100,
            color: Colors.blueAccent,
            child: TextButton(
              onPressed: () {},
              child: const Center(
                child: Text(
                  'Stop',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}