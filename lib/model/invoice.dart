import 'package:bill_generator/model/customer.dart';
import 'package:bill_generator/model/supplier.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    this.info,
    this.supplier,
    this.customer,
    this.items,
  });
}

class InvoiceInfo {
  final String number;
  final DateTime date;

  const InvoiceInfo({
    this.number,
    this.date,
  });
}

class InvoiceItem {
  final String description;
  final int quantity;
  final double vat;
  final double unitPrice;

  const InvoiceItem({
    this.description,
    this.quantity,
    this.vat,
    this.unitPrice,
  });
}
