import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:syncmed/screens/HomeScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class Prediction extends StatefulWidget {
  const Prediction({super.key});

  @override
  State<Prediction> createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  bool isFinished = false;
  String result = Get.arguments;

  final Uri _url = Uri.parse('https://www.apollo247.com/specialties/cardiology');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color.fromRGBO(204, 204, 255, 1),
        elevation: 20,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              Get.to(HomeScreen());
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.3),
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),
        centerTitle: true,
        title: const Text("Your Heart Health Status",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 360,
                width: double.infinity,
                child: Lottie.asset("assets/Animationp.json"),
                decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(150),
                    ),
              ),
              const SizedBox(height: 30),
               result == '0' && result.isNotEmpty? Text(
                "Your Heart Health is Good",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 24),
              ) :  result == '1' && result.isNotEmpty? Text(
                 "Your Heart Health is Not Good Please Consult A Doctor",
                 textAlign: TextAlign.center,
                 style: TextStyle(color: Colors.redAccent, fontSize: 24),
               ) : Container(),
              const SizedBox(height: 30),
              const Text(
                "Note:- This AI Model has 82% accuracy",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 30),
              SwipeableButtonView(
                  buttonText: "SWIPE TO CONSULT",
                  buttonWidget: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey,
                  ),
                  activeColor: Colors.deepPurple.withOpacity(0.3),
                  isFinished: isFinished,
                  onWaitingProcess: () {
                    Future.delayed(Duration(seconds: 1), () {
                      setState(() {
                        isFinished = true;
                      });
                    });
                  },
                  onFinish: () async {
                    print(result);
                    setState(() {
                      print("Hello");
                      _launchUrl();

                      isFinished = false;
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}