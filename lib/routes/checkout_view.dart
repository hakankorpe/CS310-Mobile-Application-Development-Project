import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class CheckoutView extends StatefulWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("CheckoutView build is called.");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Checkout",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Card Information",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: "Card Number",
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: TextFormField(
                              keyboardType: TextInputType.datetime,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                hintText: "MM/YY",
                              ),
                            )
                        ),
                        const SizedBox(width: 15,),
                        Expanded(
                            flex: 1,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                hintText: "CVV",
                              ),
                            )
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 25,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Address Information",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_location_alt_outlined,
                          color: Colors.black,
                        ),
                        label: const Text(
                            "Enter a new address",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 25,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Order Summary",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          "370₺"
                        ),
                        const SizedBox(width: 10,),
                        ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              "Confirm"
                            ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
