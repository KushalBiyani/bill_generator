import 'package:bill_generator/widget/SlidableCard.dart';
import 'package:bill_generator/widget/textInput.dart';
import 'package:flutter/material.dart';
import 'package:bill_generator/api/pdf_api.dart';
import 'package:bill_generator/api/pdf_invoice_api.dart';
import 'package:bill_generator/main.dart';
import 'package:bill_generator/model/customer.dart';
import 'package:bill_generator/model/invoice.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../utils.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  TextEditingController custName, custPhone = TextEditingController();
  List<InvoiceItem> products = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.picture_as_pdf),
              onPressed: () async {
                final date = DateTime.now();
                final invoice = Invoice(
                  supplier: Utils.ksupplier,
                  customer: Customer(
                    name: custName.text,
                    mobileNo: int.parse(custPhone.text),
                  ),
                  info: InvoiceInfo(
                    date: date,
                    number: (date.microsecondsSinceEpoch / 1000)
                        .round()
                        .toString()
                        .substring(3),
                  ),
                  items: products,
                );
                final pdfFile = await PdfInvoiceApi.generate(invoice);
                PdfApi.openFile(pdfFile);
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.person),
                title: TextInputLabel(custName, "Name", true),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: TextInputLabel(custPhone, "Phone", false),
              ),
              SizedBox(height: 24),
              Expanded(
                child: products.length != 0
                    ? SlidableCard(
                        ctxt: context,
                        products: products,
                      )
                    : Container(),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController productName,
              productQuantity,
              productPrice,
              productTax = TextEditingController();
          productTax.text = '18';
          Alert(
              context: context,
              title: "Add Item",
              content: Column(
                children: <Widget>[
                  TextInputLabel(productName, 'Product Name', true),
                  TextInputLabel(productQuantity, 'Quantity', false),
                  TextInputLabel(productPrice, 'Unit Price', false),
                  TextInputLabel(productTax, 'Tax', false),
                ],
              ),
              buttons: [
                DialogButton(
                  onPressed: () {
                    InvoiceItem newItem = InvoiceItem(
                      description: productName.text,
                      quantity: int.parse(productQuantity.text),
                      unitPrice: double.parse(productPrice.text),
                      vat: double.parse(productTax.text),
                    );
                    setState(() {
                      products.add(newItem);
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ]).show();
        },
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }
}
