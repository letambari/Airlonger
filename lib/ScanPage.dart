import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'scannedResult.dart';

class ScanPage extends StatelessWidget {
  final token; // Specify the type of token as String
  ScanPage({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.4,
          child: MobileScanner(
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates,
            ),
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              final Uint8List? image = capture.image;
              for (final barcode in barcodes) {
                print('Barcode found ${barcode.rawValue}');
                // Navigate to the result page with the scanned data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScannedResultPage(token: token, data: (barcode.rawValue).toString()),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
