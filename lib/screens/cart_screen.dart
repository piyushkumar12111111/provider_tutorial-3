import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/orders_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';
import 'package:flutter_complete_guide/providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart =
        Provider.of<Cart>(context); //!HERE WE HAVE CALLED CART PROVIDER
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(), //! IT IS USED TO TAKE ZERO SPACE BETWEEN THINGS
                  Chip(  //! SPECIAL WIDGET
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: TextStyle(
                          //color: Theme.of(context).primaryTextTheme.title.color,
                          color: Colors.black),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    child: Text('ORDER NOW'),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                        cart.items.values//! ITEM IS NAME OF A MAP WE ARE ACCESSING ITS VALUE NOT KEY 
                            .toList(), //! HERE WE HAVE CONVERTED MAP TO LIST ELEMENT ONLY PASSING THE VALUE SAME WE CAN PASS KEY ALSO
                        cart.totalAmount,
                      );
                      cart.clear();

                      //Navigator.of(context).pushNamed(OrdersScreen().routename);
                      Navigator.of(context).pushNamed(OrdersScreen.routeName);
                    },
                    //textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                //! SAME AS ABOVE WE HAVE PASSED VALUE OF MAP HERE
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
              ),
            ),
          )
        ],
      ),
    );
  }
}
