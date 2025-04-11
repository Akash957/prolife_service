import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prolife_service/global_widget/globle_screen.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController nameController = TextEditingController();
  TextEditingController personalNumberController = TextEditingController();
  TextEditingController alternateNumberController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController houseNameController = TextEditingController();
  TextEditingController roadNameController = TextEditingController();
  TextEditingController pinCodeNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController stateNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.arrow_left),
        title: Text("add delivery address",style: TextStyle(fontSize: 25),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: "Full Name(Required)*",
                  hintText: "Enter your name",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: personalNumberController,
              decoration: InputDecoration(
                  labelText: "Phone number(Required)*",
                  hintText: "Enter your phone number",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: alternateNumberController,
              decoration: InputDecoration(
                  labelText: "+Add Alternate Phone Number",
                  hintText: "Enter your alternate number",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: pinCodeController,
                    decoration: InputDecoration(
                      hintText: "Pincode number",
                      labelText: "Pincode(required)*",
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: cityNameController,
                    keyboardType: TextInputType.phone,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        hintText: "City name",
                        labelText: "City(Required)*",
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2))),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: stateNameController,
                    decoration: InputDecoration(
                        hintText: "state name",
                        labelText: "State(Required)*",
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2))),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 160,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.location_on,
                      size: 20,
                    ),
                    label: Text(
                      "Add location",
                      style: TextStyle(fontSize: 17),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: houseNameController,
              decoration: InputDecoration(
                labelText: "House No.,Building Name(Required)*",
                hintText: "Enter your house name",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: roadNameController,
              decoration: InputDecoration(
                  labelText: "Road name,Area,colony(Required)*",
                  hintText: "Enter your address",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
            SizedBox(
              height: 15,
            ),

            // ClipRRect(child: Text("+    Add Nearby Famous Shop/Mall/Landmark",style: TextStyle(fontWeight: FontWeight.bold),)),
            // Text(
            //   "Type of address",
            //   style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: 20,
            //       color: Colors.black),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     SizedBox(width: 15,),
            //     ElevatedButton.icon(
            //       onPressed: () {},
            //       style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            //       icon: Icon(
            //         Icons.home,
            //         color: Colors.black,
            //       ),
            //       label: Text(
            //         "Home",
            //         style: TextStyle(fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //     ElevatedButton.icon(
            //       onPressed: () {},
            //       style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            //       icon: Icon(
            //         Icons.apartment_outlined,
            //         color: Colors.black,
            //       ),
            //       label: Text(
            //         "work",
            //         style: TextStyle(fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //     SizedBox(width: 15,),
            //   ],
            // ),
            SizedBox(height: 20,),
            Container(
              width: 260,
                height: 45,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3))),
                    child: Text("Save address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),)))
          ],
        ),
      ),
    );
  }
}
