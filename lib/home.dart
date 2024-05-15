import 'package:flutter/material.dart';
import 'Scanpage.dart'; // Import the ScanPage

class HomeScreen extends StatefulWidget {
  final token; // Specify the type of token as String
  HomeScreen({required this.token, Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airlonger'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Your existing content here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Add functionality for button tap
                        },
                        child: Card(
                          elevation: 4, // Set elevation for the card
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Adjust the border radius of the card
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20), // Add padding inside the card
                            child: Icon(
                              Icons.inventory_rounded,
                              color: Colors.red,
                              size: MediaQuery.of(context).size.width * 0.1, // Set the size based on screen width
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text('Stocks', textAlign: TextAlign.center,),
                    ],
                  ),

                  SizedBox(width: 4),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Add functionality for button tap
                        },
                        child: Card(
                          elevation: 4, // Set elevation for the card
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Adjust the border radius of the card
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20), // Add padding inside the card
                            child: Icon(
                              Icons.add_box_outlined,
                              color: Colors.red,
                              size: MediaQuery.of(context).size.width * 0.1, // Set the size based on screen width
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text('Add', textAlign: TextAlign.center,),
                    ],
                  ),

                  SizedBox(width: 4),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Add functionality for button tap
                        },
                        child: Card(
                          elevation: 4, // Set elevation for the card
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Adjust the border radius of the card
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20), // Add padding inside the card
                            child: Icon(
                              Icons.local_shipping_outlined,
                              color: Colors.red,
                              size: MediaQuery.of(context).size.width * 0.1, // Set the size based on screen width
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text('Logistics', textAlign: TextAlign.center,),
                    ],
                  ),

                  // Add spacing between buttons
                  SizedBox(width: 4),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Add functionality for button tap
                        },
                        child: Card(
                          elevation: 4, // Set elevation for the card
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Adjust the border radius of the card
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20), // Add padding inside the card
                            child: Icon(
                              Icons.shopping_cart_checkout_outlined,
                              color: Colors.red,
                              size: MediaQuery.of(context).size.width * 0.1, // Set the size based on screen width
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text('Orders', textAlign: TextAlign.center,),
                    ],
                  )
                ],
              ),

            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the ScanPage when the QR scanner icon is clicked
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ScanPage(token: widget.token)),
          ).then((value) {
            // Handle the data captured from the scanner if needed
            print('Scanned data: $value');
          });
        },
        child: Icon(
          Icons.qr_code_scanner_outlined,
          color: Colors.white,
          size: 40,
        ),
        backgroundColor: Colors.red,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: SizedBox(
          height: 100,
        ),
      ),
    );
  }
}
