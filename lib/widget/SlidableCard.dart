import 'package:bill_generator/model/invoice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableCard extends StatefulWidget {
  final List<InvoiceItem> products;
  final BuildContext ctxt;
  SlidableCard({this.products, this.ctxt});

  @override
  _SlidableCardState createState() => _SlidableCardState();
}

class _SlidableCardState extends State<SlidableCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.products.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Card(
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  widget.products[index].description,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.products[index].quantity.toString() +
                      " X Rs " +
                      widget.products[index].unitPrice.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Rs ' +
                      (widget.products[index].quantity *
                              widget.products[index].unitPrice)
                          .toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                setState(() {
                  widget.products.removeAt(index);
                });
              },
            ),
          ],
        );
      },
    );
  }
}
