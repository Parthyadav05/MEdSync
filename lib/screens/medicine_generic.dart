import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:syncmed/widgets/bar_chart.dart';

class MedicineAlternativesScreen extends StatelessWidget {

  final List<Map<String, dynamic>> medicineData = [
    {"brand_name": "Acetaminophen", "generic_alternatives": ["Paracetamol"]},
    {"brand_name": "Panadol", "generic_alternatives": ["Paracetamol"]},
    {"brand_name": "Prilosec", "generic_alternatives": ["Omeprazole"]},
    {"brand_name": "Amoxil", "generic_alternatives": ["Amoxicillin"]},
    {"brand_name": "Lipitor", "generic_alternatives": ["Atorvastatin"]},
    {"brand_name": "Zyrtec", "generic_alternatives": ["Cetirizine"]},
    {"brand_name": "Motrin", "generic_alternatives": ["Ibuprofen"]},
    {"brand_name": "Advil", "generic_alternatives": ["Ibuprofen"]},
    {"brand_name": "Aleve", "generic_alternatives": ["Naproxen"]},
    {"brand_name": "Disprin", "generic_alternatives": ["Aspirin"]},
    {"brand_name": "Aspro clear", "generic_alternatives": ["Aspirin"]},
    {"brand_name": "Glucophage", "generic_alternatives": ["Metformin"]},
    {"brand_name": "Synthroid", "generic_alternatives": ["Levothyroxine"]},
    {"brand_name": "Prinivil", "generic_alternatives": ["Lisinopril"]},
    {"brand_name": "Zestril", "generic_alternatives": ["Lisinopril"]},
    {"brand_name": "Norvasc", "generic_alternatives": ["Amlodipine"]},
    {"brand_name": "Cozaar", "generic_alternatives": ["Losartan"]},
    {"brand_name": "GenericHydrochlorothiazide", "generic_alternatives": ["Hydrochlorothiazide"]},
    {"brand_name": "Zocor", "generic_alternatives": ["Simvastatin"]},
    {"brand_name": "Flonase", "generic_alternatives": ["Fluticasone Propionate"]},
    {"brand_name": "Singulair", "generic_alternatives": ["Montelukast"]},
    {"brand_name": "Ventolin", "generic_alternatives": ["Albuterol"]},
    {"brand_name": "Proventil", "generic_alternatives": ["Albuterol"]},
    {"brand_name": "Prilosec", "generic_alternatives": ["Omeprazole"]},
    {"brand_name": "Prevacid", "generic_alternatives": ["Lansoprazole"]},
    {"brand_name": "Protonix", "generic_alternatives": ["Pantoprazole"]},
    {"brand_name": "Zantac", "generic_alternatives": ["Ranitidine"]},
    {"brand_name": "Tagamet", "generic_alternatives": ["Cimetidine"]},
    {"brand_name": "Claritin", "generic_alternatives": ["Loratadine"]},
    {"brand_name": "Benadryl", "generic_alternatives": ["Diphenhydramine"]},
    {"brand_name": "Imodium", "generic_alternatives": ["Loperamide"]},
    {"brand_name": "Dulcolax", "generic_alternatives": ["Bisacodyl"]},
    {"brand_name": "Senokot", "generic_alternatives": ["Sennosides"]},
    {"brand_name": "Colace", "generic_alternatives": ["Docusate Sodium"]},
    {"brand_name": "GenericMelatonin", "generic_alternatives": ["Melatonin"]},
    {"brand_name": "Valium", "generic_alternatives": ["Diazepam"]},
    {"brand_name": "Xanax", "generic_alternatives": ["Alprazolam"]},
    {"brand_name": "Ativan", "generic_alternatives": ["Lorazepam"]},
    {"brand_name": "Zoloft", "generic_alternatives": ["Sertraline"]},
    {"brand_name": "Prozac", "generic_alternatives": ["Fluoxetine"]},
    {"brand_name": "Celexa", "generic_alternatives": ["Citalopram"]},
    {"brand_name": "Crestor", "generic_alternatives": ["Rosuvastatin"]},
    {"brand_name": "Synthroid", "generic_alternatives": ["Levothyroxine"]},
    {"brand_name": "Nexium", "generic_alternatives": ["Esomeprazole"]},
    {"brand_name": "Ventolin HFA", "generic_alternatives": ["Albuterol"]},
    {"brand_name": "Advair Diskus", "generic_alternatives": ["Fluticasone propionate/Salmeterol"]},
    {"brand_name": "Lantus Solostar", "generic_alternatives": ["Glargine insulin"]},
    {"brand_name": "Vyvanse", "generic_alternatives": ["Lisdexamfetamine"]},
    {"brand_name": "Lyrica", "generic_alternatives": ["Pregabalin"]},
    {"brand_name": "Spiriva Handihaler", "generic_alternatives": ["Tiotropium bromide"]},
    {"brand_name": "Diovan", "generic_alternatives": ["Valsartan"]},
    {"brand_name": "Lantus", "generic_alternatives": ["Glargine insulin"]},
    {"brand_name": "Januvia", "generic_alternatives": ["Sitagliptin"]},
    {"brand_name": "Abilify", "generic_alternatives": ["Aripiprazole"]},
    {"brand_name": "Celebrex", "generic_alternatives": ["Celecoxib"]},
    {"brand_name": "Cialis", "generic_alternatives": ["Tadalafil"]},
    {"brand_name": "Viagra", "generic_alternatives": ["Sildenafil"]},
    {"brand_name": "Symbicort", "generic_alternatives": ["Budesonide/Formoterol"]},
    {"brand_name": "Zetia", "generic_alternatives": ["Ezetimibe"]},
    {"brand_name": "Nasonex", "generic_alternatives": ["Mometasone furoate"]},
    {"brand_name": "Suboxone", "generic_alternatives": ["Buprenorphine/Naloxone"]},
    {"brand_name": "Namenda", "generic_alternatives": ["Memantine"]},
    {"brand_name": "Bystolic", "generic_alternatives": ["Nebivolol"]},
    {"brand_name": "Levemir", "generic_alternatives": ["Detemir insulin"]},
    {"brand_name": "Xarelto", "generic_alternatives": ["Rivaroxaban"]},
    {"brand_name": "Flovent HFA", "generic_alternatives": ["Fluticasone propionate"]},
    {"brand_name": "Oxycontin", "generic_alternatives": ["Oxycodone"]},
    {"brand_name": "Cymbalta", "generic_alternatives": ["Duloxetine"]},
    {"brand_name": "Nuvaring", "generic_alternatives": ["Etonogestrel vaginal ring"]},
    {"brand_name": "Thyroid", "generic_alternatives": ["Levothyroxine"]},
    {"brand_name": "Voltaren Gel", "generic_alternatives": ["Diclofenac gel"]},
    {"brand_name": "Dexilant", "generic_alternatives": ["Dexlansoprazole"]},
    {"brand_name": "Benicar", "generic_alternatives": ["Benazapril"]},
    {"brand_name": "Proventil HFA", "generic_alternatives": ["Albuterol"]},
    {"brand_name": "Tamiflu", "generic_alternatives": ["Oseltamivir"]},
    {"brand_name": "Novolog Flexpen", "generic_alternatives": ["Insulin aspart"]},
    {"brand_name": "Humalog", "generic_alternatives": ["Insulin lispro"]},
    {"brand_name": "Novolog", "generic_alternatives": ["Insulin aspart"]},
    {"brand_name": "Premarin", "generic_alternatives": ["Conjugated estrogens"]},
    {"brand_name": "Vesicare", "generic_alternatives": ["Solifenacin succinate"]},
    {"brand_name": "Benicar HCT", "generic_alternatives": ["Benazapril/Hydrochlorothiazide"]},
    {"brand_name": "Afluria", "generic_alternatives": ["Oseltamivir phosphate"]},
    {"brand_name": "Lumigan", "generic_alternatives": ["Brimonidine tartrate"]},
    {"brand_name": "Lo Loestrin Fe", "generic_alternatives": ["Norethindrone/Ethinyl estradiol/Ferrous fumarate"]},
    {"brand_name": "Janumet", "generic_alternatives": ["Sitagliptin/Metformin"]},
    {"brand_name": "Ortho-Tri-Cyclen Lo 28", "generic_alternatives": ["Norgestimate/Ethinyl estradiol"]},
    {"brand_name": "Combivent Respimat", "generic_alternatives": ["Ipratropium bromide/Albuterol"]},
    {"brand_name": "Toprol-XL", "generic_alternatives": ["Metoprolol succinate"]},
    {"brand_name": "Pristiq", "generic_alternatives": ["Desvenlafaxine succinate"]},
    {"brand_name": "Travatan Z", "generic_alternatives": ["Travoprost"]},
    {"brand_name": "Pataday", "generic_alternatives": ["Olopatadine hydrochloride"]},
    {"brand_name": "Humalog Kwikpen", "generic_alternatives": ["Insulin lispro"]},
    {"brand_name": "Vytorin", "generic_alternatives": ["Ezetimibe/Simvastatin"]},
    {"brand_name": "Minastrin 24 Fe", "generic_alternatives": ["Norethindrone/Ethinyl estradiol/Ferrous fumarate"]},
    {"brand_name": "Focalin XR", "generic_alternatives": ["Dexmethylphenidate hydrochloride"]},
    {"brand_name": "Avodart", "generic_alternatives": ["Dutasteride"]},
    {"brand_name": "Seroquel XR", "generic_alternatives": ["Quetiapine fumarate"]},
    {"brand_name": "Strattera", "generic_alternatives": ["Atomoxetine hydrochloride"]},
    {"brand_name": "Pradaxa", "generic_alternatives": ["Dabigatran etexilate"]},
    {"brand_name": "Chantix", "generic_alternatives": ["Varenicline"]},
    {"brand_name": "Zostavax", "generic_alternatives": ["Zoster live vaccine"]},
    {"brand_name": "Namenda XR", "generic_alternatives": ["Memantine hydrochloride"]},
    {"brand_name": "Humira", "generic_alternatives": ["Adalimumab"]},
    {"brand_name": "Dulera", "generic_alternatives": ["Budesonide/Formoterol"]},
    {"brand_name": "Victoza 3-Pak", "generic_alternatives": ["Liraglutide"]},
    {"brand_name": "Lunesta", "generic_alternatives": ["Eszopiclone"]},
    {"brand_name": "Exelon", "generic_alternatives": ["Rivastigmine"]},
    {"brand_name": "Combigan", "generic_alternatives": ["Brimonidine tartrate,Timolol maleate"]},
    {"brand_name": "Onglyza", "generic_alternatives": ["Saxagliptin"]},
    {"brand_name": "Exforge", "generic_alternatives": ["Valsartan","Amlodipine"]},
    {"brand_name": "Welchol", "generic_alternatives": ["Colesevelam"]},
    {"brand_name": "Premarin Vaginal", "generic_alternatives": ["Conjugated estrogens Vaginal cream"]},
    {"brand_name": "Enbrel", "generic_alternatives": ["Etanercept"]},
    {"brand_name": "Ranexa", "generic_alternatives": ["Ranolazine"]},
    {"brand_name": "Invokana", "generic_alternatives": ["Canagliflozin"]},
    {"brand_name": "Evista", "generic_alternatives": ["Raloxifene"]},
    {"brand_name": "Truvada", "generic_alternatives": ["Emtricitabine","Tenofovir disoproxil fumarate"]},
    {"brand_name": "Tradjenta", "generic_alternatives": ["Linagliptin"]},
    {"brand_name": "Alphagan P", "generic_alternatives": ["Brimonidine tartrate"]},
    {"brand_name": "Viibryd", "generic_alternatives": ["Vilazodone"]},
    {"brand_name": "Effient", "generic_alternatives": ["Prasugrel"]},
    {"brand_name": "Xopenex HFA", "generic_alternatives": ["Levalbuterol"]},
    {"brand_name": "Azor", "generic_alternatives": ["Olmesartan medoxomil/Amlodipine"]},
    {"brand_name": "Norvir", "generic_alternatives": ["Ritonavir"]},
    {"brand_name": "Amitiza", "generic_alternatives": ["Cibrotraxin"]},
    {"brand_name": "Latuda", "generic_alternatives": ["Lurasidone"]},
    {"brand_name": "Lotemax", "generic_alternatives": ["Loteprednol etabonate"]},
    {"brand_name": "Advair HFA", "generic_alternatives": ["Fluticasone propionate/Salmeterol"]}, {'brand_name': 'Citalopram', 'generic_alternatives': ['GenericCitalopram', 'Celexa']}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(204, 204, 255, 1),
        elevation: 20,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        title: Text('Medicine Alternatives'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: MedicineAlternativesForm(medicineData: medicineData),
      ),
    );
  }
}

class MedicineAlternativesForm extends StatefulWidget {
  final List<Map<String, dynamic>> medicineData;


  const MedicineAlternativesForm({Key? key, required this.medicineData}) : super(key: key);

  @override
  _MedicineAlternativesFormState createState() => _MedicineAlternativesFormState();
}

class _MedicineAlternativesFormState extends State<MedicineAlternativesForm> {
  int simpleIntInput = 0;
  bool isFinished = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<String> shopNames = [];
  late TextEditingController _brandMedicineController = TextEditingController();
  late List<String> _alternatives = [];
  late String _selectedAlternative = '';
  late bool _showBuySection = false;

  late TextEditingController _quantityController = TextEditingController();
  late TextEditingController _addressController = TextEditingController();
  late String _selectedStore = '';



  @override
  void initState() {
    super.initState();
    fetchRegisteredSellers();
    _quantityController = TextEditingController();
    _addressController = TextEditingController();
    _brandMedicineController = TextEditingController();
  }

  @override
  void dispose() {
    _brandMedicineController.dispose();
    _quantityController.dispose();
    _addressController.dispose();
    _brandMedicineController.dispose();
    super.dispose();
  }
  void fetchRegisteredSellers() {
    _firestore.collection('sellers').get().then((querySnapshot) {
      setState(() {
        shopNames = querySnapshot.docs.map((doc) => doc['store'] as String).toList();
      });
    }).catchError((error) {
      print("Error fetching registered sellers: $error");
    });
  }

  void buyMedicine() {
    final brandMedicineInput = _brandMedicineController.text;
    final selectedGenericMedicine = _selectedAlternative;
    final quantityInput = _quantityController.text;
    final addressInput = _addressController.text;
    final selectedStore = _selectedStore;

    // Check if all necessary fields are filled
    if (brandMedicineInput.isNotEmpty &&
        selectedGenericMedicine.isNotEmpty &&
        quantityInput.isNotEmpty &&
        addressInput.isNotEmpty &&
        selectedStore.isNotEmpty) {
      // Perform the purchase action here
      // For example, you can display an alert or send data to a server
      // For demonstration, just print the values
      print('Buying:');
      print('Brand Medicine: $brandMedicineInput');
      print('Generic Medicine: $selectedGenericMedicine');
      print('Quantity: $quantityInput');
      print('Address: $addressInput');
      print('Store: $selectedStore');

      // Clear the form after the purchase
      _brandMedicineController.clear();
      _quantityController.clear();
      _addressController.clear();
      setState(() {
        _selectedAlternative = '';
        _selectedStore = '';
        _showBuySection = false;
      });
      Get.snackbar('Purchase Successful','Your order has been placed.');
      // Show a confirmation or navigate to a success screen
      // For example, you can display an alert dialog

    } else {
      Get.snackbar('Error','Please fill in all fields.');


    }
  }
  void sendOrderToStore(
      String selectedStore,
      String selectedGenericMedicine,
      int quantity,
      String address,
      ) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('sellers')
          .where('store', isEqualTo: selectedStore)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) async {
          String sellerEmail = doc['email'];

          await FirebaseFirestore.instance.collection('buyRequests').add({
            'sellerEmail': sellerEmail,
            'genericMedicine': selectedGenericMedicine,
            'quantity': quantity,
            'address': address,
            'store': selectedStore,
            'Email' : _auth.currentUser?.email,
          });

          print('Order sent to $selectedStore for $selectedGenericMedicine');
        });
      } else {
        print('No seller found for store $selectedStore');
      }
    } catch (e) {
      print('Error sending order: $e');
    }
  }



  void getAlternatives() {
    final brandMedicineInput = _brandMedicineController.text.toLowerCase();
    final medicineEntry = widget.medicineData.firstWhere(
          (entry) => entry['brand_name'].toLowerCase() == brandMedicineInput,
      orElse: () => {'generic_alternatives': []},
    );

    setState(() {
      _alternatives = medicineEntry['generic_alternatives'].cast<String>();
      _showBuySection = _alternatives.isNotEmpty;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10,),
          TextFormField(
            controller: _brandMedicineController,
            decoration: InputDecoration(labelText: 'Enter Branded Medicine',
            border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
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
                getAlternatives();
              },
              child: Center(
                child: Text(
                  "Find Generic Alternatives",
                  style: GoogleFonts.ubuntu(
                      fontSize: 20,
                      color: AppColors.contentColorWhite),
                ),
              )),
          SizedBox(height: 16.0),
          if (_showBuySection) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _alternatives
                  .map(
                    (alternative) => Card(
                  child: ListTile(
                    enabled: true,
                    title: Text(alternative),
                    focusColor: Colors.teal,
                    splashColor: Colors.tealAccent,
                    autofocus: true,
                    enableFeedback: true,
                    trailing: Text("Tap to Select"),
                    onTap: () {
                      setState(() {
                        _selectedAlternative = alternative;
                      });
                    },
                  ),
                ),
              ).toList(),
            ),
            // Add other form fields for quantity, address, store selection here
            // ...
            Padding(
              padding: EdgeInsets.all(8),
              child: QuantityInput(
                  value: simpleIntInput,
                  label: "Quantity",
                  decoration: InputDecoration(
                    enabled: true,
                    enabledBorder: OutlineInputBorder()
                  ),
                  onChanged: (value) => setState(() {simpleIntInput = int.parse(value.replaceAll(',', ''));
                   print("$simpleIntInput");
                  })
              ),
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Address"),
                  helperText: 'Enter Delivery Address'),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Tap to Select"),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: false,
                autoPlay: true,
              ),
              items:shopNames.map((ShopName) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedStore = ShopName;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade300,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Expanded(child:Lottie.asset("assets/pharmacy.json"), ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:Colors.deepPurple.shade300,
                                ),
                                child: Text(
                                  ShopName,
                                  style: GoogleFonts.ubuntu(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),
                                ),
                              ),
                              SizedBox(height: 10,)

                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 10,),
            SwipeableButtonView(
                buttonText: "SWIPE TO CONFIRM ORDER",
                buttonWidget: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                ),
                activeColor: Colors.deepPurple.shade200,
                buttontextstyle: GoogleFonts.ubuntu(color: Colors.white,fontSize: 16),
                isActive: true,
                isFinished: isFinished,
                onWaitingProcess: () {
                  Future.delayed(Duration(seconds: 1), () {
                    setState(() {
                      isFinished = true;
                    });
                  });
                },
                onFinish: () async {

                  setState(() {
                    isFinished = false;
                    if (_selectedStore.isNotEmpty &&
                        _selectedAlternative.isNotEmpty &&
                        simpleIntInput.isFinite &&
                        _addressController.text.isNotEmpty) {
                      final int quantity = simpleIntInput;
                      final String address = _addressController.text;

                      sendOrderToStore(
                        _selectedStore,
                        _selectedAlternative,
                        quantity,
                        address,
                      );

                      // Clear the form after the purchase
                      _brandMedicineController.clear();
                      _quantityController.clear();
                      _addressController.clear();
                      setState(() {
                        _selectedAlternative = '';
                        _selectedStore = '';
                        _showBuySection = false;
                      });
                      Get.snackbar('Order Placed', 'Your order has been placed successfully.');

                    } else {
                      Get.snackbar('Error', 'Please fill in all fields.');
                    }

                  });
                }),

          ],
        ],
      ),
    );
  }
}