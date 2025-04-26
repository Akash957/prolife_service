import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(
              CupertinoIcons.cart,
              size: 40,
            ),
            title: Text(
              "Your Cart",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            // tileColor: Colors.white,
            // style: ListTileTheme(selectedColor: Colors.white,),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Image.network(
              "https://os-wordpress-media.s3.ap-south-1.amazonaws.com/blog/wp-content/uploads/2020/11/24212247/Air-Conditioner-Buying-Guide-1140x570.jpg",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            title: GlobalWidgetAll.TextFunction("Ac Repair Service "),
            subtitle: Text("1 service     ₹1116"),
            trailing:
                IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.delete)),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey,
            height: 1,
            endIndent: 25,
            indent: 25,
            thickness: 1,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              ". Foam_jet_service (4 Acs) x 1",
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 20,
              ),
              FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3))),
                  child: Text("Add Services")),
              FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3))),
                  child: Text("Checkout")),
              SizedBox(
                width: 20,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQp_Taucdb1LmAb1whNe3f0o6LfbBSif2Vsaw&s",
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              "Living room Cleaner",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            subtitle: Text("1 service ₹999"),
            trailing:
                IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.delete)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 20,
              ),
              FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3))),
                  child: Text("Add service")),
              FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3))),
                  child: Text("Checkout")),
              SizedBox(
                width: 20,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdXA466FKWXJi_Y7BlbbcM8vnrRvUhCTQJag&s",
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text("Salon For Men"),
            subtitle: Text("2 service ₹899"),
            trailing:
                IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.delete)),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              ". Beard trimming & styling x 1 \n. Haircut for men x 1",
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 20,
              ),
              FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3))),
                  child: Text("Add service")),
              FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3))),
                  child: Text("Checkout")),
              SizedBox(
                width: 20,
              )
            ],
          ),
        ],
      ),
    );
  }
}
