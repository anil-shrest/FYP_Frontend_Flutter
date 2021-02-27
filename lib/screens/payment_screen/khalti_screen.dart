import 'package:flutter/material.dart';
import 'package:flutter_khalti/flutter_khalti.dart';
import 'package:provider/provider.dart';
import 'package:simpleApi/components/colors.dart';
import 'package:simpleApi/components/providers.dart';

class KhaltiScreen extends StatefulWidget {
  @override
  _KhaltiScreenState createState() => _KhaltiScreenState();
}

class _KhaltiScreenState extends State<KhaltiScreen> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String amount;

  final amountController = TextEditingController();

  // Disposing amount controller
  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  //  Khalti payment initiation
  _payViaKhalti() async {
    double amount = double.parse(amountController.text.trim()) * 100;

    FlutterKhalti _flutterKhalti = FlutterKhalti.configure(
      publicKey: "test_public_key_9f55c8620fd546158ea76f2173ce5fa8",
      urlSchemeIOS: "KhaltiPayFlutterExampleScheme",
      paymentPreferences: [
        KhaltiPaymentPreference.KHALTI,
      ],
    );

    KhaltiProduct product = KhaltiProduct(
      id: "test",
      amount: amount,
      name: "Dental service payment",
    );
    _flutterKhalti.startPayment(
      product: product,
      onSuccess: (data) {
        print("Service payment successful");
      },
      onFaliure: (error) {
        print("Payment failed!");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // key: scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: buttonColor,
          // centerTitle: true,
          title: Text(
            'Khalti Payment',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 8),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Image.network(
                        'https://miro.medium.com/max/1006/1*xqUNa2hUbiis04Z2XTr4Jw.png'),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 9),
                Text('Enter payment amount',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400)),
                SizedBox(height: 10.0),
                Form(
                  key: _formKey,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        // style: TextStyle(color: Colors.grey[800]),
                        keyboardType: TextInputType.number,
                        controller: amountController,
                        validator: (input) => input.length <= 0 || input.isEmpty
                            ? "Amount must be higher than Rs.0*"
                            : null,
                        decoration: new InputDecoration(
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 11.0),
                          hintText: "Amount in Rupees",
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: primaryColor,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.black87,
                          )),
                          prefixIcon: Icon(
                            Icons.attach_money,
                            color: Colors.teal,
                          ),
                        ),
                      )),
                ),
                SizedBox(height: 20.0),
                FlatButton(
                    height: 44.0,
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      'Continue',
                      style: TextStyle(color: buttonTextColor, fontSize: 17.0),
                    ),
                    color: primaryColor,
                    onPressed: () {
                      amount = (amountController.text);
                      if (_formKey.currentState.validate()) {
                        _payViaKhalti();
                      }
                    }),
              ],
            ),
          ),
        ));
  }
}
