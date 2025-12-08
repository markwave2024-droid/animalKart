import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/order_model.dart';

class InvoiceGenerator {
  static Future<String> generateInvoice(OrderModel order) async {
    final pdf = pw.Document();

    // ✅ Load Image Correctly
    final image = pw.MemoryImage(
      (await rootBundle.load("assets/images/murrah_5.jpeg"))
          .buffer
          .asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(32),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [

              // ✅ LOGO + APP NAME
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(image, height: 40),
                  pw.Text(
                    "ZapBuy",
                    style: pw.TextStyle(
                      fontSize: 20,
                      color: PdfColor.fromHex("#777777"),
                    ),
                  ),
                ],
              ),

              pw.SizedBox(height: 20),

              pw.Text(
                "MARKWAVE PRIVATE LIMITED",
                style: pw.TextStyle(
                  fontSize: 26,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.Text(
                "Order ID: ${order.id}",
                style: pw.TextStyle(
                  fontSize: 16,
                  color: PdfColor.fromHex("#555555"),
                ),
              ),

              pw.SizedBox(height: 30),

              // ✅ CUSTOMER DETAILS
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("BILLING ADDRESS",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 6),
                      // pw.Text(order.customerName ?? "Customer"),
                      // pw.Text(order.address ?? "Hyderabad"),
                      // pw.Text(order.mobile ?? "9999999999"),
                    ],
                  ),

                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("SHIPPING ADDRESS",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 6),
                      // pw.Text(order.customerName ?? "Customer"),
                      // pw.Text(order.address ?? "Hyderabad"),
                      // pw.Text(order.mobile ?? "9999999999"),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 30),

              // ✅ TABLE
              pw.Table(
                border: pw.TableBorder.all(),
                children: [

                  pw.TableRow(
                    decoration:
                        pw.BoxDecoration(color: PdfColor.fromHex('#FFE800')),
                    children: [
                      _tableHeader("Breed"),
                      _tableHeader("Age"),
                      _tableHeader("CPF %"),
                      _tableHeader("CPF Qty"),
                      _tableHeader("Amount"),
                    ],
                  ),

                  pw.TableRow(
                    children: [
                      _tableData(order.breed),
                      _tableData("${order.age} Yrs"),
                     // _tableData(order.cpf),
                      _tableData(order.cpfQuantity.toString()),
                      _tableData("₹${order.paidAmount}"),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 30),

              // ✅ PRICE SUMMARY
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    _priceRow("Subtotal", "₹${order.paidAmount}"),
                    pw.Divider(),
                    _priceRow(
                      "Total Amount Paid",
                      "₹${order.paidAmount}",
                      bold: true,
                    ),
                    _priceRow("Total Due", "₹0", bold: true),
                  ],
                ),
              ),

              pw.SizedBox(height: 40),

              // ✅ TERMS
              pw.Text(
                "Please note that delivery may take 5–7 working days.\n"
                "For support, contact help@zapbuy.com\n\n"
                "Thank you for shopping!",
                style: pw.TextStyle(
                  fontSize: 11,
                  color: PdfColor.fromHex("#666666"),
                ),
              ),
            ],
          );
        },
      ),
    );

    // ✅ SAVE FILE PROPERLY
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/invoice_${order.id}.pdf");

    await file.writeAsBytes(await pdf.save());

    return file.path;
  }

  // ✅ TABLE HEADER
  static pw.Widget _tableHeader(String title) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(title,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
    );
  }

  static pw.Widget _tableData(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(text),
    );
  }

  static pw.Widget _priceRow(String label, String value,
      {bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.end,
        children: [
          pw.Text(
            "$label: ",
            style: pw.TextStyle(
              fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
