import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prolife_service/screen/add_edit_address.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({super.key});

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  String? selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            trailing: GestureDetector(
              onTap:(){
                Navigator.pop(context);
              },

              child: Icon(
                CupertinoIcons.multiply_circle,
                color: Colors.red,
              ),
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
            leading: Radio<String>(
              value: "Home",
              groupValue: selectedAddress,
              onChanged: (value) {
                setState(() {
                  if(selectedAddress==value){
                    selectedAddress=null;
                  }else{
                    selectedAddress=value!;
                  }
                });
              },
              activeColor: Colors.green,
            ),
            title: Text(
              "Home",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text("4517 Washington Ave.\nManchester, Kentuchy 39495"),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Radio<String>(
              value: "Work",
              groupValue: selectedAddress,
              onChanged: (value) {
                setState(() {
                  if(selectedAddress==value){
                    selectedAddress=null;
                  }
                  else{
                    selectedAddress=value!;
                  }
                  // selectedAddress = value!;

                });

              },
              activeColor: Colors.green,
            ),
            title: Text("Work"),
            subtitle:
                Text("2118 Thornridge Cir. Syracuse,\nConnecticut 356224"),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddEditAddress()));
              },
              icon: Icon(
                Icons.add_circle_outline_rounded,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  fixedSize: Size(250, 45),
                  backgroundColor: Colors.blue),
              label: Text("Add New Address"),
            ),
          )
        ],
      ),
    );

  }
}
