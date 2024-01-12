import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncmed/data/vaccine.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;



class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    initializeNotifications();
  }
  Future<void> initializeTimezone() async {
    tz.initializeTimeZones();
  }

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> scheduleNotification(DateTime selectedDate, TimeOfDay selectedTime) async {
    tz.initializeTimeZones();
    String currentTimeZone = 'Asia/Kolkata'; // Update this with the appropriate timezone
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    final DateTime combinedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    try {
      final now = DateTime.now();
      final scheduledTime = tz.TZDateTime.from(combinedDateTime, tz.local);
      final difference = scheduledTime.difference(now).inSeconds;
      if (difference > 0) {
        // If the scheduled time is in the future, schedule the notification
        await flutterLocalNotificationsPlugin.zonedSchedule(
          0,
          'Notification Title',
          'Notification Body',
          scheduledTime,
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
        );
      } else {
        // If the scheduled time is in the past, don't schedule the notification
        print('Scheduled time is in the past.');
      }
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }



  Future<void> _selectDateAndTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        print('SelectedDate:- $pickedDate');
        print('Selecttime:- $pickedTime');
        scheduleNotification(pickedDate, pickedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
     var vaccines = Vaccines();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: ElevatedButton(
          onPressed: () => _selectDateAndTime(context),
          child: Text('Select Date and Time for Medicine'),
        ),
      ),
      body: Column(
        children: [
          Text("Suggested Vaccines",style: GoogleFonts.ubuntu(fontSize: 20,fontWeight: FontWeight.bold),),
          Expanded(child:  ListView.builder(
            itemCount: vaccines.vaccinationSchedule.length,
            itemBuilder: (BuildContext context, int index) {
              final vaccine = vaccines.vaccinationSchedule[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                  contentPadding: EdgeInsets.all(10),
                  autofocus: true,
                  hoverColor: Colors.grey,
                  splashColor: Colors.grey,
                  style: ListTileStyle.drawer,
                  onTap: (){
                   Get.snackbar("Set Reminder", "Add Vaccine Reminder",isDismissible: true,snackPosition:SnackPosition.BOTTOM);
                  },
                  title: Text(vaccine['vaccine']),
                  subtitle: Text('Age: ${vaccine['age']}'),
                  trailing: Text('Doses: ${vaccine['doses']}'),
                ),
              );
            },
          ), )
        ],
      )
    );
  }
}



