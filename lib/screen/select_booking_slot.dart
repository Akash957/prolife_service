import 'dart:ui';
import 'package:flutter/material.dart';

class SelectBookingSlot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Column(
          //   children: [
          //     Expanded(
          //       child: Container(
          //         color: Colors.blue[300],
          //         child: Center(child: Text("This is the background")),
          //       ),
          //     ),
          //   ],
          // ),

          // Blur effect for upper half
          Align(
            alignment: Alignment.topCenter,

            child: Stack(
              children: [
                Image.network(
                  "https://media.istockphoto.com/id/911703434/photo/hands-of-plumber-with-a-wrench.jpg?s=612x612&w=0&k=20&c=vUroIJBzae0CbrcGe_ut2_CJSvBu4owfaYcP6ZC23DI=",
                  height: MediaQuery.of(context).size.height / 2,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                ),
              ],
            ),

            // child: ClipRect(
            //   child: BackdropFilter(
            //     filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            //     child: Container(
            //       height: MediaQuery.of(context).size.height / 2,
            //     ),
            //   ),
            // ),
          ),

          // Foreground content (optional)
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.only(

                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              child: Container(

                height: MediaQuery.of(context).size.height / 2,
                // decoration: BoxDecoration(
                     color: Colors.white,
                //     borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(30),
                //         topRight: Radius.circular(30))),
                child: Center(

                  child: Text(
                    "Bottom half is clear",

                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
