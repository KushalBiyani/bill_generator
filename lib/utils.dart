import 'package:bill_generator/model/supplier.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart';
import 'model/invoice.dart';

class Utils {
  static const Map<int, Alignment> kcellAlignments = {
    0: Alignment.centerLeft,
    1: Alignment.centerRight,
    2: Alignment.centerRight,
    3: Alignment.centerRight,
    4: Alignment.centerRight,
    5: Alignment.centerRight,
  };
  static TextStyle kboldStyle = TextStyle(fontWeight: FontWeight.bold);
  static const Supplier ksupplier = Supplier(
      name: 'Kushal Biyani',
      address: '855 Raja Gali',
      paymentInfo: '7898294826@paytm');

  static kformatPrice(double price) => '\Rs ${price.toStringAsFixed(2)}';
  static kformatDate(DateTime date) => DateFormat.yMd().format(date);
  static kgrandTotal(Invoice invoice) => invoice.items
      .map((item) => item.unitPrice * item.quantity)
      .reduce((item1, item2) => item1 + item2);
  static kcalculateTax(InvoiceItem item) =>
      item.unitPrice * (1 - item.vat / 100);
}
