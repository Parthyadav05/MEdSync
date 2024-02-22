# Steps to run the code :-
1. Install Flutter:
If you haven't already, install Flutter by following the instructions on the official Flutter website: Flutter Installation Guide.

2. Set Up Firebase Project:

Go to the Firebase console: Firebase Console.
Create a new project or use an existing one.
Set up Firebase Authentication and Firestore for your project. Go to the "Authentication" and "Firestore" tabs in the Firebase console to set them up according to your requirements.
Download the google-services.json file for Android or GoogleService-Info.plist file for iOS and place them in the respective directories of your Flutter project.

3. Clone the GitHub Repository:
Clone the Flutter code repository from GitHub that you want to run on your local machine.
git clone <repository-url>

4. Install Dependencies:
Run the following command to get all the dependencies required for the Flutter project:
flutter pub get

5.Configure Firebase in Flutter:
Update the pubspec.yaml file to include the necessary Firebase and Firestore dependencies. Ensure that the google-services.json or GoogleService-Info.plist files are correctly placed in the project.

6.Run the Flutter Project:
Run the Flutter project on an emulator or a physical device using the following command:
flutter run
This command will build and run the Flutter project on the connected device or emulator.

7.Testing Firebase Authentication and Firestore:
Test the Firebase Authentication functionalities (e.g., sign up, sign in) to ensure they are working as expected.
Test Firestore integration by reading from and writing to the Firestore database.

8. To run the chatbot which uses Gemini:
API Key Setup:
To use Gemini's API, you typically need to sign up for an account on their platform and generate API keys. Follow Gemini's documentation to create API keys with the necessary permissions for your app.
# MEdSync: Your Health Management Companion

Overview:

MEdSync is a comprehensive health and wellness app designed to empower you to manage your health proactively and conveniently. Its key features include:
* Affordability: Find cheaper meds & save money.
* Medication Management: Reminders, shopkeeper dashboard & more.
* Vaccination Management: Predict due dates & get reminders.
* Personalized Health: Chatbot, diet plans, exercise routines & heart risk assessment.
* Community: Share, inspire & get support on your health journey.
* Location Services: Find nearby hospitals & get emergency help.
* Calorie tracking & data privacy included.
  <br>
![Screenshot 2024-01-12 123055](https://github.com/Parthyadav05/MEdSync/assets/122090751/ba73064a-6ccb-462b-8968-bf0bd6eb028d)
![Screenshot 2024-01-12 123141](https://github.com/Parthyadav05/MEdSync/assets/122090751/d6d785d8-4471-4be1-8867-89eb1b9bbb3a)
![Screenshot 2024-01-12 123256](https://github.com/Parthyadav05/MEdSync/assets/122090751/c3d75b33-f14e-4adf-a5b8-f4efe3eb1538)
![Screenshot 2024-01-12 123323](https://github.com/Parthyadav05/MEdSync/assets/122090751/af415854-a355-4e10-b08b-0136c9c3c260)

# Find & Buy Generic Medicine:

* Search for generic alternatives by brand name of medicine.

* Order medicines directly through the app or visit partnered stores.
![Screenshot 2024-01-12 123614](https://github.com/Parthyadav05/MEdSync/assets/122090751/349d39d5-8787-48f1-8007-ce0bbc75f137)
![Screenshot 2024-01-12 123753](https://github.com/Parthyadav05/MEdSync/assets/122090751/d240b0bb-3e37-4c53-85fa-f99055d7bc8a)
# SELLER DASHBOARD
* New seller Registration and Login using firebase 

* Sellers can View and manage orders recieved to the store in realtime.
* Update inventory and track order fulfillment.

  
![Screenshot 2024-01-12 124909](https://github.com/Parthyadav05/MEdSync/assets/122090751/631fc7fd-6add-4b78-bff6-1a3ce113d422)
![Screenshot 2024-01-12 124950](https://github.com/Parthyadav05/MEdSync/assets/122090751/a9debf36-7d92-47dc-8dd8-186e2be4094d)
![Screenshot 2024-01-12 125007](https://github.com/Parthyadav05/MEdSync/assets/122090751/03ca6f42-91c5-493b-a372-476b9d85a144)
# Vaccine and Medicine Reminder:
* Set reminders for individual medications or create recurring schedules.
* Receive customizable notifications to ensure timely adherence.
* Enter your date of birth to receive personalized due date notifications.
* Set reminders for upcoming vaccinations to avoid missed or delayed immunizations.
* Access educational resources about recommended immunizations.
![Screenshot 2024-01-12 124014](https://github.com/Parthyadav05/MEdSync/assets/122090751/cf135395-18b4-4f3d-bc1d-0f77d17472ce)
![Screenshot 2024-01-12 124030](https://github.com/Parthyadav05/MEdSync/assets/122090751/db5416cc-bd1d-4d3d-b19c-530186bea77e)
# Heart Disease Prediction Model:

* Answer a series of questions about your health history and lifestyle habits.
* Receive an estimated risk assessment for heart disease.

![Screenshot 2024-01-12 124308](https://github.com/Parthyadav05/MEdSync/assets/122090751/f503a839-782e-42a0-a9cc-742ebd04f1bb)
![Screenshot 2024-01-12 124535](https://github.com/Parthyadav05/MEdSync/assets/122090751/3264f327-bd13-4627-8240-728df2942189)
![Screenshot 2024-01-12 124616](https://github.com/Parthyadav05/MEdSync/assets/122090751/f161faca-d9f6-4c29-8877-771f78830e3e)
<br>
* consult with doctor
  
![Screenshot 2024-01-12 124702](https://github.com/Parthyadav05/MEdSync/assets/122090751/d2584c9d-b313-4f35-a2e0-8c1eea2c08c5)
# Calorie Tracker:
* Track your daily calorie intake and receive insights into your dietary patterns.
![Screenshot 2024-01-12 124816](https://github.com/Parthyadav05/MEdSync/assets/122090751/2469f924-8579-4564-aa96-b3b467464808)
![Screenshot 2024-01-12 124844](https://github.com/Parthyadav05/MEdSync/assets/122090751/69f1fcd3-f25c-4394-9dff-b3904efae433)




# Gemini-Powered Chatbot:
* Ask general health questions and receive evidence-based answers.
* Get personalized diet plans based on your health goals and preferences.
* Explore recommended exercise routines and yoga poses for improved fitness.

![Screenshot 2024-01-12 124059](https://github.com/Parthyadav05/MEdSync/assets/122090751/5978d027-23cd-4625-9470-d952eeb2b65a)
![Screenshot 2024-01-12 124228](https://github.com/Parthyadav05/MEdSync/assets/122090751/f6edb4bf-5f8a-4a0c-8a8d-b0616a05bf7d)




# Community Page:
* Share healthy recipes, food pictures, exercise routines, and yoga poses.
* Read and be inspired by other users' health and wellness journeys.
* Offer and receive support and encouragement within the community.
![Screenshot 2024-01-12 123532](https://github.com/Parthyadav05/MEdSync/assets/122090751/4a49eb04-f173-4ef1-8d77-68b1566c30c3)
![Screenshot 2024-01-12 123506](https://github.com/Parthyadav05/MEdSync/assets/122090751/0e5f179d-fc23-4cde-9084-5ccbe7fb5fcc)

![Screenshot 2024-01-12 123352](https://github.com/Parthyadav05/MEdSync/assets/122090751/8e654645-9bc9-442e-a59a-88ce10bbc051)




