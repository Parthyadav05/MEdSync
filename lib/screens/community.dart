import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncmed/data/controller.dart';
// Replace with the actual path

class CommunityPage extends StatelessWidget {
  final ReviewController reviewController = Get.put(ReviewController());
  TextEditingController value = TextEditingController();
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      reviewController.setImage(
          image.path); // Set the picked image path in the ReviewController
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Community',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromRGBO(204, 204, 255, 1),
        elevation: 20,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: Column(
          children: [
          Expanded(
            child: FutureBuilder<void>(
            future: reviewController.fetchReviewsWithImages(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Obx(
                  () => ListView.builder(
                    itemCount: reviewController.reviewsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final review = reviewController.reviewsList[index];
                      final imageUrl = review['photo_url'];
                      final reviewText = review['review_text'];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (imageUrl.isNotEmpty)
                                ClipRRect(
                                  child: Image.network(
                                    imageUrl,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              SizedBox(
                                height: 4,
                              ),
                              BubbleSpecialOne(
                                text: reviewText,
                                isSender: false,
                                color: Colors.grey.shade500.withOpacity(0.5),
                                textStyle: GoogleFonts.ubuntu(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ]),
      floatingActionButton: Wrap(
        //will break to another line on overflow
        direction: Axis.vertical, //use vertical to show  on vertical axis
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: () {
                  Get.bottomSheet(Container(
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.shade100,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    height: 200,
                    width: 400,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: value,
                            onChanged: (value) {
                              reviewController.setReviewText(
                                  value); // Set the comment text in the ReviewController
                            },
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Enter your Experience....',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        ElevatedButton(
                            style: ButtonStyle(overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors
                                      .deepPurple.shade300; //<-- SEE HERE
                                return null; // Defer to the widget's default.
                              },
                            )),
                            onPressed: () {
                              _pickImage();
                              reviewController.addReviewWithPhoto();
                            },
                            child: Text(
                              "Post",
                              style: GoogleFonts.ubuntu(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ))
                      ],
                    ),
                  ));
                },
                backgroundColor: Colors.deepPurpleAccent,
                tooltip: "Add Experience......",
                child: Icon(Icons.comment),
              )), // button second
          // Add more buttons here
        ],
      ),
    );
  }
}
