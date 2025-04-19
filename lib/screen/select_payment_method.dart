import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectPaymentMethod extends StatefulWidget {
  const SelectPaymentMethod({super.key});

  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios_new,
          size: 30,
        ),
        title: Text(
          "Payment Method",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Debit or Credit Card",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Image.network(
                "https://th.bing.com/th/id/OIP.g4ZuBcH_vnuDOu7CmrDYKQHaHa?w=168&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(
                "Master Card",
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text("4564-5464-6387-4253"),
              trailing: Icon(
                Icons.navigate_next,
                size: 30,
              ),
            ),
            FilledButton(

                onPressed: () {},
                style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.plus_circle,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8), // Icon aur text ke beech space ke liye
                    Text(
                      "Add New Card",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              "   Wallet",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            ListTile(
              leading: Image.network(
                "https://th.bing.com/th/id/OIP.rr2PcYggW2OLnWuP4QzF7wHaEK?w=296&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                width: 60,
                height: 60,
              ),
              title: Text(
                "Paytm",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                Icons.navigate_next,
                size: 30,
              ),
            ),
            ListTile(
              leading: Image.network(
                "https://download.logo.wine/logo/Amazon_Pay/Amazon_Pay-Logo.wine.png",
                width: 100,
                height: 60,
              ),
              title: Text(
                "Amazon Pay",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                Icons.navigate_next,
                size: 30,
              ),
            ),
            Text(
              "   UPI",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Image.network(
                "https://th.bing.com/th/id/OIP.rr2PcYggW2OLnWuP4QzF7wHaEK?w=296&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                width: 60,
                height: 60,
              ),
              title: Text(
                "Paytm Upi",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                Icons.navigate_next,
                size: 30,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ListTile(
              leading: Image.network(
                "https://th.bing.com/th/id/OIP.5OA8W4y3tR5ACnlHvJUWVgHaEe?w=252&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                width: 60,
                height: 60,
              ),
              title: Text(
                "Google Pay",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                Icons.navigate_next,
                size: 30,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "   Pay After Service",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Image.network(
                "https://th.bing.com/th/id/OIP.Giqw-ocEcQLH_rvCepspRAHaHa?rs=1&pid=ImgDetMain",
                width: 40,
                height: 60,
              ),
              title: Text(
                "Pay with Cash After Service",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              trailing: Icon(
                Icons.navigate_next,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
