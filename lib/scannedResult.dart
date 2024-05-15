import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart';


class ScannedResultPage extends StatefulWidget {
  final token;
  final String data;
  const ScannedResultPage({@required this.token, required this.data, Key? key}) : super(key: key);

  @override
  _ScannedResultPageState createState() => _ScannedResultPageState();
}

class _ScannedResultPageState extends State<ScannedResultPage> {
  //late String stockCode = 'CKAZGFT6BRLE';
  //late String stockCode = '';



  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchstockData();
  }

  late String metaTitle = '';
  late String qrc_number = '';
   String? proledg_primary_photo = 'jhhjh';


  void fetchstockData() async {
    try {
      // Move the calculation of stockCode here
      late String stockCode = widget.data.split("/").last;

      final String apiUrl = 'https://api.airlonger.com/api/scanned-result/?code=${stockCode}';
      final Map<String, String> headers = {
        'Authorization': 'Bearer ${widget.token}',
      };

      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          final Map<String, dynamic> pageMetaData = responseData['page_meta_data'];
          final Map<String, dynamic> page_qrc_data = responseData['qrc_data'];
          final Map<String, dynamic> inventory_ledger_data = responseData['inventory_ledger'];

          setState(() {
            metaTitle = pageMetaData['metaTitle'];
            qrc_number = page_qrc_data['qrc_number'];
            proledg_primary_photo  = inventory_ledger_data['proledg_primary_photo'];
            // You can access other properties like metaDesc, metaUrl, etc.
            _isLoading = false;
          });
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text('QR Code not found on our system.'),
              actions: [
                TextButton(
                  onPressed: () {
                    // Navigate to the dashboard screen after successful login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen(token: widget.token)),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
          throw Exception(responseData['message']);

        }
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('QR Code not found'),
            actions: [
              TextButton(
                onPressed: () {
                  // Navigate to the dashboard screen after successful login
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen(token: widget.token)),
                  );
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
        print('try fetching data: ${stockCode}');
        throw Exception('Failed to load data22');

      }
    } catch (e) {
      print('Error fetching data: $e');

    }
  }

  //  List<String> _placeholderImages = [
  //   'https://airlonger.com/content_delivery/product_photos/${proledg_primary_photo}',
  // ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanned Result'),
      ),
      body:
      _isLoading
        ? Center(
        child: CircularProgressIndicator(), // Show CircularProgressIndicator while loading
    )
       :
      SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Scanned Data:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  // Text(
                  //   widget.data,
                  //   style: TextStyle(fontSize: 18),
                  // ),
                  SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
            child: Image.network(
              'https://airlonger.com/content_delivery/product_photos/${proledg_primary_photo.toString()}',
              //fit: BoxFit.cover,
              height: 300,
              width: 50,
            ),
          ),
                  // CarouselSlider(
                  //   options: CarouselOptions(
                  //     height: 200.0,
                  //     aspectRatio: 16 / 9,
                  //     viewportFraction: 0.8,
                  //     initialPage: 0,
                  //     enableInfiniteScroll: true,
                  //     reverse: false,
                  //     autoPlay: true,
                  //     autoPlayInterval: Duration(seconds: 3),
                  //     autoPlayAnimationDuration: Duration(milliseconds: 800),
                  //     autoPlayCurve: Curves.fastOutSlowIn,
                  //     enlargeCenterPage: true,
                  //     onPageChanged: (index, reason) {
                  //       print('Page changed to index $index');
                  //     },
                  //     scrollDirection: Axis.horizontal,
                  //   ),
                  //   items: _placeholderImages.map((url) {
                  //     return Builder(
                  //       builder: (BuildContext context) {
                  //         return Container(
                  //           width: MediaQuery.of(context).size.width,
                  //           margin: EdgeInsets.symmetric(horizontal: 5.0),
                  //           decoration: BoxDecoration(
                  //             color: Colors.grey[300],
                  //           ),
                  //           child: Image.network(
                  //             url,
                  //             fit: BoxFit.cover,
                  //           ),
                  //         );
                  //       },
                  //     );
                  //   }).toList(),
                  // ),
                  SizedBox(height: 10),
                  Text(
                    metaTitle.toString(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(300, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      backgroundColor: Colors.red,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Restock',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(300, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      backgroundColor: Colors.red,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_shopping_cart, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Place Order',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(300, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      backgroundColor: Colors.red,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory_outlined, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Stock Settings',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(right: 300.0),
                    child: Text(
                      'Stock Data',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 400,
                    child: Table(
                      border: TableBorder.all(color: Colors.grey),
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.fiber_manual_record, color: Colors.black, size: 10),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text('Attributes'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text('Values'),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.toggle_on, color: Colors.black, size: 10),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text('Product Name'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(metaTitle.toString()),
                              ),
                            ),
                          ],
                        ),

                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.toggle_on, color: Colors.black, size: 10),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text('QR Code'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(qrc_number.toString() ?? ''),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),


                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(right: 300.0),
                    child: Text(
                      'Product Data',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 400,
                    child: Table(
                      border: TableBorder.all(color: Colors.grey),
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.fiber_manual_record, color: Colors.black, size: 10),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text('Attributes'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text('Specifications'),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.toggle_on, color: Colors.black, size: 10),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text('Pipe Material'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(qrc_number ?? ''),
                              ),
                            ),
                          ],
                        ),

                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.toggle_on, color: Colors.black, size: 10),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text('Fitting Type'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(qrc_number ?? ''),
                              ),
                            ),
                          ],
                        ),

                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.toggle_on, color: Colors.black, size: 10),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text('Pipe Schedule'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(qrc_number ?? ''),
                              ),
                            ),
                          ],
                        ),

                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.toggle_on, color: Colors.black, size: 10),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text('Connection Type'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(qrc_number ?? ''),
                              ),
                            ),
                          ],
                        ),

                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.toggle_on, color: Colors.black, size: 10),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text('Color'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(qrc_number ?? ''),
                              ),
                            ),
                          ],
                        ),

                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.toggle_on, color: Colors.black, size: 10),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text('Size'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(qrc_number ?? ''),
                              ),
                            ),
                          ],
                        ),

                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.toggle_on, color: Colors.black, size: 10),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text('Length'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(qrc_number ?? ''),
                              ),
                            ),
                          ],
                        ),

                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.toggle_on, color: Colors.black, size: 10),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text('Pressure Rating'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(qrc_number ?? ''),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
    ),
    );
          }

  bool _isValidUrl(String url) {
    return true;
  }
}
