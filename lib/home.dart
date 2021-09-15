import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'app_string.dart';
import 'sound_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var fb = FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var recFirstChild = fb.reference();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Alarm notification"),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Container(
            margin: const EdgeInsets.all(15),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StreamBuilder(
                      stream: recFirstChild.onValue,
                      builder: (context, AsyncSnapshot snap) {
                        if (snap.hasData &&
                            !snap.hasError &&
                            snap.data != null) {
                          var snapshot = snap.data.snapshot;
                          return AlarmItem(
                            icon: Icon(
                              Icons.notifications,
                              size: 100,
                              color: snapshot.value[alarmfire]
                                  ? colorBlack
                                  : colorRad,
                            ),
                            name: appNotification,
                            status: snapshot.value[alarmfire],
                            isOnline: snapshot.value[appOnline],
                            onSwitchChange: () {
                              // updateAlarmFirst(!status);
                            },
                          );
                        }
                        return const Text(
                          "Something went wrong",
                        );
                      }),
                  StreamBuilder(
                      stream: recFirstChild.onValue,
                      builder: (context, AsyncSnapshot snap) {
                        if (snap.hasData &&
                            !snap.hasError &&
                            snap.data != null) {
                          var snapshot = snap.data.snapshot;
                          return AlarmItem(
                            icon: Icon(
                              Icons.lightbulb,
                              size: 100,
                              color: snapshot.value[alarmElectrical]
                                  ? colorBlack
                                  : colorRad,
                            ),
                            name: appLightLabel,
                            status: snapshot.value[alarmElectrical],
                            isOnline: snapshot.value[appOnline],
                            onSwitchChange: () {
                              // updateAlarmFirst(!status);
                            },
                          );
                        }
                        return const Text(
                          "Something went wrong",
                        );
                      }),
                ],
              ),
            )),
      ),
    );
  }



  void updateAlarmFirst(bool status) {
    fb.reference().child('firstAlarm').update({'status': status});
  }

  void updateAlarmSecond(bool status) {
    fb.reference().child('secondAlarm').update({'status': status});
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(0),
            child: Image.network(
              'https://scontent.fpnh2-1.fna.fbcdn.net/v/t31.18172-8/11894070_1614742852110752_8664674509829991181_o.jpg?_nc_cat=102&ccb=1-5&_nc_sid=174925&_nc_eui2=AeEGagPLshkxWou3-mcY2mWD9lnUfilxkHj2WdR-KXGQeH_0W4qNTViaHT98zWA38Zk4m0KhtODBAdXads_VeY-7&_nc_ohc=debOKk4CWCUAX_sFn6e&_nc_ht=scontent.fpnh2-1.fna&oh=d3b7db05ba39cb4dd40a9ce61e9e5d89&oe=6165E83B',
              fit: BoxFit.cover,
            ),
          ),
          const ListTile(
            title: Text("Home"),
            leading: Icon(Icons.home),
          )
        ],
      ),
    );
  }
}

class AlarmItem extends StatefulWidget {
  const AlarmItem({
    Key? key,
    required this.name,
    required this.status,
    required this.onSwitchChange,
    required this.isOnline,
    required this.icon,
  }) : super(key: key);

  final String name;
  final bool status;
  final bool isOnline;
  final Function onSwitchChange;
  final Icon icon;

  @override
  State<AlarmItem> createState() => _AlarmItemState();
}

class _AlarmItemState extends State<AlarmItem> {
  @override
  Widget build(BuildContext context) {
    var soundManager = SoundManager();
    //widget.soundManager?.playWithUrl("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3");
    soundManager.playSoundLocal();
    // !widget.status
    //     ? widget.soundManager?.playWithUrl("")
    //     : widget.soundManager?.stop();
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(75)),
      ),
      color: Colors.blueGrey,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.white,
                    child: widget.icon,
                  ),
                ),
                Positioned(
                  right: -15,
                  top: -10,
                  child: Icon(
                    Icons.lightbulb,
                    color: widget.isOnline ? Colors.green : Colors.red[400],
                  ),
                )
              ],
              clipBehavior: Clip.none,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: widget.status ? Colors.white : colorRad,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      widget.status ? "Normal" : "Not Normal",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Switch(
                    value: widget.status,
                    onChanged: (isTrue) {
                      widget.onSwitchChange();
                    },
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.red[300],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
