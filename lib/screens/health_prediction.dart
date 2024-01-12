import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:syncmed/widgets/AddButton.dart';
import 'prediction_result.dart';

class HeartDiseasePrediction extends StatefulWidget {
  @override
  _HeartDiseasePredictionState createState() => _HeartDiseasePredictionState();
}

class _HeartDiseasePredictionState extends State<HeartDiseasePrediction> {
  TextEditingController ageController = TextEditingController();
  TextEditingController trestbpsController = TextEditingController();
  TextEditingController cholController = TextEditingController();
  TextEditingController thalachController = TextEditingController();
  TextEditingController oldpeakController = TextEditingController();
  TextEditingController caController = TextEditingController();
  String sexValue = ''; // Default value for sex
  String cpValue = ''; // Default value for chest pain type
  String fbsValue = ''; // Default value for fasting blood sugar
  String restecgValue = ''; // Default value for rest ECG
  String exangValue = ''; // Default value for exercise-induced angina
  String slopeValue = ''; // Default value for slope
  String thalValue = ''; // Default value for thal


  String predictionResult = '';
  Future<void> predict() async {
    const apiUrl = 'https://prediction-7llb.onrender.com/api/predict';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'age': ageController.text,
        'sex': sexValue == 'Male' ? '1' : '0',
        'cp': ChestPain(cpValue),
        'trestbps': trestbpsController.text,
        'chol': cholController.text,
        'fbs': fbsValue == 'Greater than 120 mg/dl' ? '1' : '0',
        'restecg': Restecg(restecgValue),
        'thalach': thalachController.text,
        'exang': exangValue == 'Yes' ? '1' : '0',
        'oldpeak': oldpeakController.text,
        'slope': Slope(slopeValue),
        'ca': caController.text,
        'thal': Thalass(thalValue),

      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        print("Updated");
        predictionResult = '${data['prediction']}';
      });
    } else {
      setState(() {
        predictionResult = 'Failed to get prediction';
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(204, 204, 255, 1),
        elevation: 20,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))
        ),
        title: Text('Heart Disease Prediction',style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              SizedBox(height: 10,),
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(
                    suffixIcon: Icon(FontAwesomeIcons.userPen ,color: Colors.deepPurple,),
                    border: OutlineInputBorder(),
                    labelText: 'Age'),
              ),
              SizedBox(height: 10,),
              buildDropdown('Sex', ['Select Option', 'Male', 'Female'], 'Select Option', (value) {
                setState(() {
                  sexValue = value!;
                });
              }),
              SizedBox(height: 10,),
              buildDropdown('Chest Pain Type', ['Select Option', 'Typical Angina', 'Atypical Angina', 'Non-anginal Pain', 'Asymptomatic'], 'Select Option', (value) {
                setState(() {
                  cpValue = value!;
                });
              }),
              SizedBox(height: 10,),
              TextFormField(
                controller: trestbpsController,
                decoration: InputDecoration(
                    suffixIcon: Icon(FontAwesomeIcons.userPen ,color: Colors.deepPurple,),
                    border: OutlineInputBorder(),
                    labelText: 'Resting Blood Pressure'),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: cholController,
                decoration: InputDecoration(
                    suffixIcon: Icon(FontAwesomeIcons.userPen ,color: Colors.deepPurple,),
                    border: OutlineInputBorder(),
                    labelText: 'Serum Cholesterol'),
              ),
              SizedBox(height: 10,),
              buildDropdown('Fasting Blood Sugar', ['Select Option', 'Greater than 120 mg/dl', 'Less than 120 mg/dl'],'Select Option', (value) {
                setState(() {
                  fbsValue = value!;
                });
              }),
              SizedBox(height: 10,),
              buildDropdown('Resting ECG Results', ['Select Option', 'Normal', 'ST-T wave abnormality', 'definite left ventricular hypertrophy'],'Select Option' , (value) {
                setState(() {
                  restecgValue = value!;
                });
              }),

              SizedBox(height: 10,),
              TextFormField(
                controller: thalachController,
                decoration: InputDecoration(
                    suffixIcon: Icon(FontAwesomeIcons.userPen ,color: Colors.deepPurple,),
                    border: OutlineInputBorder(),
                    labelText: 'Max Heart Rate'),
              ),
              SizedBox(height: 10,),
              buildDropdown('Exercise-induced Angina', ['Select Option', 'Yes', 'No'], 'Select Option', (value) {
                setState(() {
                  exangValue = value!;
                });
              }),
              SizedBox(height: 10,),
              TextFormField(
                controller: oldpeakController,
                decoration: InputDecoration(
                    suffixIcon: Icon(FontAwesomeIcons.userPen ,color: Colors.deepPurple,),
                    border: OutlineInputBorder(),
                    labelText: 'ST depression'),
              ),
              SizedBox(height: 10,),
              buildDropdown('Slope', ['Select Option', 'Upsloping', 'Flat', 'Downsloping'], 'Select Option', (value) {
                setState(() {
                  slopeValue = value!;
                });
              }),

              SizedBox(height: 10,),
              TextFormField(
                controller: caController,
                decoration: InputDecoration(
                    suffixIcon: Icon(FontAwesomeIcons.userPen ,color: Colors.deepPurple,),
                    border: OutlineInputBorder(),
                    labelText: 'Number of Major vessels'),
              ),
              SizedBox(height: 10,),
              buildDropdown('Thalassemia', ['Select Option', 'Normal', 'Fixed Defect', 'Reversible Defect'], 'Select Option', (value) {
                setState(() {
                  thalValue = value!;
                });
              }),

              SizedBox(height: 20),

              RemainderButton(text: "Predict", onPressed: (){
                predict();
                print(predictionResult);
                predictionResult.isNotEmpty ? Get.to(Prediction() , arguments: predictionResult) : CircularProgressIndicator();

              }),
              SizedBox(height: 20,),
              thalValue.isNotEmpty ? LinearProgressIndicator(color: Colors.deepPurple,) :Container(),
            ],
          ),
        ),
      ),
    );
  }
  DropdownButtonFormField<String> buildDropdown(
      String labelText,
      List<String> items,
      String? value, // Change String to String?
      Function(String?)? onChanged,
      ) {
    return DropdownButtonFormField<String>(
      menuMaxHeight: MediaQuery.of(context).size.height,
      dropdownColor: Colors.deepPurple.shade200,
      elevation: 5,
      icon: Icon(FontAwesomeIcons.angleDown),
      borderRadius: BorderRadius.circular(8),
      value: value, // Set the default value here
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          enabled: true,
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged != null
          ? (String? newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      }
          : null,
      decoration: InputDecoration(
        focusColor: Colors.lightBlue,
        border: OutlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
  String ChestPain(String type){
    if(type == "Typical Angina"){
      return  '0';
    }
    if(type == "Atypical Angina"){
        return '1';
    }
    if(type == "Non-anginal Pain"){
      return  '2';
    }
     return '3';
  }
  String Restecg(String type){
    if(type == "Normal"){
      return  '0';
    }
    if(type == "ST-T wave abnormality"){
      return '1';
    }
    return '2';
  }
  String Slope(String type){
    if(type == "Upsloping"){
      return  '0';
    }
    if(type == "Flat"){
      return '1';
    }
    return '2';
  }
  String Thalass(String type){
    if(type == "Normal"){
      return  '0';
    }
    if(type == "Fixed Defect"){
      return '1';
    }
    return '2';
  }
}