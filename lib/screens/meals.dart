import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:syncmed/widgets/pie_chart.dart';

class Food {
  final String name;
  final int calories;

  Food({required this.name, required this.calories});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'],
      calories: json['calories'],
    );
  }
}

class FoodController extends GetxController {
  RxList<Food> foods = <Food>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchFoodData();
  }

  Future<void> fetchFoodData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://calarieapi-production.up.railway.app/data')); // Replace with your API endpoint
       print(response);
       print("Hello00");
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        foods.assignAll(responseData.map((data) => Food.fromJson(data)));
      } else {
        print("Hello0");
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Hello");
      print(e.toString());
    }
  }
}
class MealsInputController extends GetxController {
  RxString breakfast = ''.obs;
  RxString lunch = ''.obs;
  RxString dinner = ''.obs;

     double calculateTotalCalories(List<String> meals, List<Food> foodList) {
  double totalCalories = 0;
    for (String meal in meals) {
      final Food? selectedFood = foodList.firstWhere(
            (food) => food.name.toLowerCase() == meal.toLowerCase(),

      );

      if (selectedFood != null) {
        totalCalories += selectedFood.calories;
      }
    }
    return totalCalories;
  }
}
class Meals extends StatelessWidget {
  final FoodController foodController = Get.put(FoodController());
  final MealsInputController mealsInputController = Get.put(MealsInputController());
  final FoodController Controller = Get.find<FoodController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calories Tracker'),
        backgroundColor: Color.fromRGBO(204, 204, 255, 1),
        elevation: 20,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: Column(
        children: [
      Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(

            onChanged: (value) => mealsInputController.breakfast.value = value,
            decoration: InputDecoration(
                fillColor: Colors.grey.shade300,
                filled: true,
                border: OutlineInputBorder(),
                labelText: 'Breakfast'),
          ),
          SizedBox(height: 10,),
          TextField(
            onChanged: (value) => mealsInputController.lunch.value = value,
            decoration: InputDecoration(
                  fillColor: Colors.grey.shade300,
                filled: true,
                border: OutlineInputBorder(),
                labelText: 'Lunch'),
          ),
          SizedBox(height: 10,),
          TextField(
            onChanged: (value) => mealsInputController.dinner.value = value,
            decoration: InputDecoration(
                fillColor: Colors.grey.shade300,
                filled: true,
                border: OutlineInputBorder(),
                labelText: 'Dinner'),
          ),
          SizedBox(height: 20),
          ElevatedButton(

            onPressed: () {
              List<String> allMeals = [
                mealsInputController.breakfast.value,
                mealsInputController.lunch.value,
                mealsInputController.dinner.value,
              ];
              double totalCalories = mealsInputController.calculateTotalCalories(
                allMeals,
                foodController.foods.toList(),
              );
              print('$totalCalories');
              // Show total calories using a snackbar or navigate to a new page to display it.
              Get.to(CalorieMeter() ,arguments: totalCalories);

            },
            style: ElevatedButton.styleFrom(
              elevation: 16,
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 10),
              backgroundColor: Colors.deepPurple.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text('Calculate Total Calories' ,style: GoogleFonts.ubuntu(color: Colors.white ,fontSize: 22),),
          ),
        ],
      ),
    ),

         Expanded(child:  Obx(
               () => foodController.foods.isEmpty
               ? Center(
             child: LinearProgressIndicator(),
           )
               : ListView.builder(
             itemCount: foodController.foods.length,
             itemBuilder: (BuildContext context, int index) {
               return Card(
                 margin: EdgeInsets.all(8.0),
                 child: ListTile(
                   title: Text(foodController.foods[index].name),
                   subtitle:
                   Text('Calories: ${foodController.foods[index].calories}'),
                 ),
               );
             },
           ),
         ),),

        ],
      ),
    );
  }
}

