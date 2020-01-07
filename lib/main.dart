import 'package:flutter/material.dart';

void main() {
  runApp(new SIForm());
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SIFormState();
  }
}

class SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  List<String> _currencies = ['Rupees', 'Dollar', 'Pounds'];
  var current = '';

  void initState() {
    super.initState();
    current = _currencies[0];
  }

  final _minPadding = 5.0;
  TextEditingController principal = TextEditingController();
  TextEditingController roi = TextEditingController();
  TextEditingController term = TextEditingController();
  var display = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Simple Interest Calculator',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Simple Interest Calculator'),
          ),
          body: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(_minPadding * 2),
                child: ListView(
                  children: <Widget>[
                    getImageAsset(),
                    Padding(
                        padding: EdgeInsets.only(
                            top: _minPadding, bottom: _minPadding),
                        child: TextFormField(
                          style: textStyle,
                          controller: principal,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter pricipal amount';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Principle',
                              hintText: 'Enter Principle e.g 12000',
                              errorStyle: TextStyle(
                                color: Colors.yellowAccent,
                                fontSize: 15.0,
                              ),
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          keyboardType: TextInputType.number,
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                            top: _minPadding, bottom: _minPadding),
                        child: TextFormField(
                          style: textStyle,
                          controller: roi,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter rate of interest';
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Rate of Interest',
                              hintText: 'In percent',
                              labelStyle: textStyle,
                              errorStyle: TextStyle(
                                color: Colors.yellowAccent,
                                fontSize: 15.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          top: _minPadding, bottom: _minPadding),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: textStyle,
                            controller: term,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter rate of term';
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Term',
                                hintText: 'Time in Years',
                                labelStyle: textStyle,
                                errorStyle: TextStyle(
                                  color: Colors.yellowAccent,
                                  fontSize: 15.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                          )),
                          Container(
                            width: _minPadding * 5,
                          ),
                          Expanded(
                              child: DropdownButton<String>(
                            items: _currencies.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: textStyle,
                                ),
                              );
                            }).toList(),
                            value: current,
                            onChanged: (String newValueSelected) {
                              setState(() {
                                current = newValueSelected;
                              });
                            },
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: _minPadding, bottom: _minPadding),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            textColor: Theme.of(context).primaryColorDark,
                            child: Text(
                              'Calculate',
                              textScaleFactor: 1.2,
                              style: textStyle,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  this.display = calculateTotalReturns();
                                }
                              });
                            },
                          )),
                          Expanded(
                              child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              'Reset',
                              textScaleFactor: 1.2,
                              style: textStyle,
                            ),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: _minPadding, bottom: _minPadding),
                      child: Text(
                        display,
                        style: textStyle,
                      ),
                    )
                  ],
                ),
              )),
        ));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minPadding * 10),
    );
  }

  String calculateTotalReturns() {
    double principal_val = double.parse(principal.text) ?? 0;
    double roi_val = double.parse(roi.text) ?? 0;
    double term_val = double.parse(term.text) ?? 0;
    double totalAmountPayable =
        principal_val + (principal_val * roi_val * term_val) / 100;
    String result =
        'After $term_val years , your interest will be worth $totalAmountPayable $current';
    return result;
  }

  void _reset() {
    principal.text = '';
    roi.text = '';
    term.text = '';
    display = '';
    current = _currencies[0];
  }
}
