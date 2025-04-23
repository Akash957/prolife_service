import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prolife_service/add_address_provider.dart';
import 'package:prolife_service/global_widget/globle_screen.dart';
import 'package:provider/provider.dart';

import 'helper_widget.dart';

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

  //
  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<AddAddressProvider>(context,listen: false);
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.arrow_left),
        title: Text(
          "add delivery address",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller:nameController,
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

            SizedBox(
              height: 20,
            ),
            Container(
                width: 260,
                height: 45,
                child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30))),
                          builder: (context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(
                                    indent: 120,
                                    endIndent: 120,
                                    color: Colors.grey,
                                    thickness: 4,
                                  ),
                                  Text(
                                    "Select Date",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        SizedBox(width: 10),
                                        dateBox("Tue", "29"),
                                        dateBox("Wed", "30"),
                                        dateBox("Thu", "31"),
                                        dateBox("Fri", "01"),
                                        dateBox("Sat", "02"),
                                        dateBox("Sun", "03"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Select Time",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Wrap(
                                    runSpacing: 10,
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 10),
                                      timeBox("10:00 AM"),
                                      timeBox("11:00 AM"),
                                      timeBox("11:00 AM"),
                                      timeBox("11:00 AM"),
                                      timeBox("12:30 PM"),
                                      timeBox("01:30 PM"),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                top: Radius.circular(30),
                                              )),
                                              builder: (context) {
                                                String selectedAddress = "Home";
                                                return StatefulBuilder(builder:
                                                    (context, setState) {
                                                  return Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.5,
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Divider(
                                                          indent: 150,
                                                          endIndent: 150,
                                                          color: Colors.grey,
                                                          thickness: 6,
                                                        ),
                                                        ListTile(
                                                          leading: Text(
                                                            "Select address",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20),
                                                          ),
                                                          trailing: Icon(
                                                            CupertinoIcons
                                                                .multiply_circle,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Divider(
                                                          indent: 30,
                                                          endIndent: 30,
                                                          color: Colors.grey,
                                                          thickness: 1,
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        ListTile(
                                                          leading:
                                                              Radio<String>(
                                                            value: "Home",
                                                            groupValue:
                                                                selectedAddress,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedAddress =
                                                                    value!;
                                                              });
                                                            },
                                                            activeColor:
                                                                Colors.green,
                                                          ),
                                                          title: Text(
                                                            "Home",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          subtitle: Text(
                                                              "4517 Washington Ave.\nManchester, Kentuchy 39495"),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        ListTile(
                                                          leading:

                                                              Radio<String>(

                                                            value: "Work",
                                                            groupValue:
                                                                selectedAddress,
                                                            onChanged: (value) {
                                                              selectedAddress =
                                                                  value!;
                                                            },
                                                          ),

                                                          title: Text("Work"),
                                                          subtitle: Text(
                                                              "2118 Thornridge Cir. Syracuse,\nConnecticut 356224"),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Center(
                                                          child: ElevatedButton
                                                              .icon(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              Icons
                                                                  .add_circle_outline_rounded,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              3),
                                                                    ),
                                                                    fixedSize:
                                                                        Size(
                                                                            250,
                                                                            45),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .blue),
                                                            label: Text(
                                                                "Add New Address"),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                              });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                            backgroundColor: Colors.blue,
                                            fixedSize: Size(250, 45)),
                                        child: Text(
                                          "Proceed to checkout",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3))),
                    child: Text(
                      "Save address",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
