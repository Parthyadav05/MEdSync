import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncmed/widgets/bar_chart.dart';





class ShopkeeperDashboard extends StatefulWidget {
  @override
  _ShopkeeperDashboardState createState() => _ShopkeeperDashboardState();
}

class _ShopkeeperDashboardState extends State<ShopkeeperDashboard> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _currentUser;
  bool _loggedIn = false;
  String _currentStore = '';
  List<Map<String, dynamic>> _buyRequests = [];

  TextEditingController _sellerEmailController = TextEditingController();
  TextEditingController _sellerPasswordController = TextEditingController();
  TextEditingController _storeSelectionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _getCurrentUser();
  }




  void _getCurrentUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _currentUser = user;
        _loggedIn = true;
      });
      await _getSellerData(user.email!);
    }
  }

  Future<void> _getSellerData(String email) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('sellers')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          _currentStore = querySnapshot.docs.first['store'];
        });
        _fetchBuyRequests();
      }
    } catch (e) {
      print('Error fetching seller data: $e');
    }
  }

  Future<void> _fetchBuyRequests() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('buyRequests')
          .where('store', isEqualTo: _currentStore)
          .where('sellerEmail', isEqualTo: _currentUser?.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> requests = [];
        querySnapshot.docs.forEach((doc) {
          requests.add(doc.data() as Map<String, dynamic>);
        });
        setState(() {
          _buyRequests = requests;
        });
      }
    } catch (e) {
      print('Error fetching buy requests: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(204, 204, 255, 1),
        elevation: 20,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        title: Text('Seller Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 5),
                  backgroundColor: Colors.deepPurple.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  _auth.signOut();
                  setState(() {
                    _currentUser = null;
                    _loggedIn = false;
                    _currentStore = '';
                    _buyRequests.clear();
                  });

                },
                child: Center(
                  child: Text(
                    "Log Out",
                    style: GoogleFonts.ubuntu(
                        fontSize: 16,
                        color: AppColors.contentColorWhite),
                  ),
                )),
          ),],
      ),
      body: SingleChildScrollView(

        padding: EdgeInsets.all(16.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: _loggedIn
              ? _buildLoggedInContent()
              : _buildLoginForms(),
        ),
      ),
    );
  }

  List<Widget> _buildLoggedInContent() {
    return [
      Text(
        'Welcome, $_currentStore',
        style: GoogleFonts.ubuntu(fontSize: 24.0,fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 20.0),
      Text(
        'Orders',
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10.0),
      Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buyRequests
                .map(
                  (request) => Card(
                    elevation: 20,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Customer Email: ${request['Email']}',style: GoogleFonts.ubuntu(fontSize: 20),),
                      Text('Medicine: ${request['genericMedicine']}',style: GoogleFonts.ubuntu(fontSize: 20),),
                      Text('Quantity: ${request['quantity']}',style: GoogleFonts.ubuntu(fontSize: 20),),
                      Text('Address: ${request['address']}',style: GoogleFonts.ubuntu(fontSize: 20),),

                    ],
                  ),
                ),
              ),
            ).toList(),

          ),
          SizedBox(height: 10,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 10),
                backgroundColor: Colors.deepPurple.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                _fetchBuyRequests;

              },
              child: Center(
                child: Text(
                  "Fetch New Orders",
                  style: GoogleFonts.ubuntu(
                      fontSize: 20,
                      color: AppColors.contentColorWhite),
                ),
              )),

        ],
      ),


    ];
  }

  List<Widget> _buildLoginForms() {
    return [
      Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(color:Colors.white10,blurRadius: 14,spreadRadius: 4)
          ],
            color: AppColors.contentColorPurple.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8)

        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Seller Registration',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _sellerEmailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Seller Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _sellerPasswordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _storeSelectionController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Choose Store Name'),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 16,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    backgroundColor: Colors.deepPurple.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Get.snackbar("Congratulation","You are Now Seller at MedSync" );
                    _registerSeller();
                  },
                  child: Center(
                    child: Text(
                      "Register as Seller",
                      style: GoogleFonts.ubuntu(
                          fontSize: 20,
                          color: AppColors.contentColorWhite),
                    ),
                  )),

              SizedBox(height: 20.0),
              Text(
                'Seller Login',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _sellerEmailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),labelText: 'Seller Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _sellerPasswordController,
                decoration: InputDecoration( border: OutlineInputBorder(),labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    backgroundColor: Colors.deepPurple.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {

                    _loginSeller();

                  },
                  child: Center(
                    child: Text(
                      "Login as Seller",
                      style: GoogleFonts.ubuntu(
                          fontSize: 20,
                          color: AppColors.contentColorWhite),
                    ),
                  )),

            ],
          ),
        ),
      ),
    ];
  }

  Future<void> _registerSeller() async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: _sellerEmailController.text,
        password: _sellerPasswordController.text,
      );

      await _firestore.collection('sellers').doc(userCredential.user!.uid).set({
        'email': _sellerEmailController.text,
        'store': _storeSelectionController.text,
      });

      setState(() {
        _currentUser = userCredential.user;
        _loggedIn = true;
        _currentStore = _storeSelectionController.text;
        _sellerEmailController.clear();
        _sellerPasswordController.clear();
        _storeSelectionController.clear();
      });
    } catch (e) {
      print('Seller registration failed: $e');
    }
  }

  Future<void> _loginSeller() async {
    try {
      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: _sellerEmailController.text,
        password: _sellerPasswordController.text,
      );

      setState(() {
        _currentUser = userCredential.user;
        _loggedIn = true;
        _sellerEmailController.clear();
        _sellerPasswordController.clear();
      });

      await _getSellerData(_currentUser!.email!);
    } catch (e) {
      print('Seller login failed: $e');
    }
  }
}
