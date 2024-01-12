import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RemainderButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const RemainderButton({required this.text, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      width: 200,
      child: AspectRatio(
        aspectRatio: 208 / 71,
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
            BoxShadow(
                offset: const Offset(0, 1),
                color: Colors.black.withBlue(150).withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 50)
          ]),
          child: MaterialButton(
            onPressed: onPressed,
            splashColor: Colors.lightBlue,
            elevation: 20,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
            padding: const EdgeInsets.all(0.0),
            child: Ink(
                decoration: BoxDecoration(
                  //gradient:
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/finance_app_2%2FbuttonBackgroundSmall.png?alt=media&token=fa2f9bba-120a-4a94-8bc2-f3adc2b58a73"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(36),
                ),
                child: Container(
                    constraints: const BoxConstraints(
                        minWidth: 88.0,
                        minHeight: 36.0), // min sizes for Material buttons
                    alignment: Alignment.center,
                    child: Text(text,
                        style: GoogleFonts.ubuntu(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)))),
          ),
        ),
      ),
    );
  }
}