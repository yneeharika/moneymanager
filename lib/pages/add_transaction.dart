import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneymanager/pages/helper.dart';
import 'package:moneymanager/theme.dart';
import 'package:moneymanager/static.dart' as Static;

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime selectedDate = DateTime.now();
  int? amount;
  String note = "Some Expense";
  String type = "Income";
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myTheme.primaryColor,
        toolbarHeight: 0.0,
      ),
      backgroundColor: Color(0xffe2e7ef),
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: [
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Add Transaction',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Static.PrimaryColor,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: EdgeInsets.all(12.0),
                child:
                    Icon(Icons.attach_money, color: Colors.white, size: 24.0),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "0",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 24.0),
                  onChanged: (val) {
                    try {
                      amount = int.parse(val);
                    } catch (e) {}
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Static.PrimaryColor,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: EdgeInsets.all(12.0),
                child: Icon(Icons.description, color: Colors.white, size: 24.0),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Note On Transaction",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 24.0),
                  onChanged: (val) {
                    note = val;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Static.PrimaryColor,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: EdgeInsets.all(12.0),
                child:
                    Icon(Icons.moving_sharp, color: Colors.white, size: 24.0),
              ),
              SizedBox(width: 12.0),
              ChoiceChip(
                label: Text('Income'),
                labelStyle: TextStyle(
                  fontSize: 18.0,
                  color: type == "Income" ? Colors.white : Colors.black,
                ),
                selectedColor: Static.PrimaryColor,
                selected: type == "Income"?true:false,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Income";
                    });
                  }
                },
              ),
              SizedBox(width: 12.0),
              ChoiceChip(
                label: Text('Expense'),
                labelStyle: TextStyle(
                  fontSize: 18.0,
                  color: type == "Expense" ? Colors.white : Colors.black,
                ),
                selectedColor: Static.PrimaryColor,
                selected: type == "Expense"?true:false,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Expense";
                    });
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 50.0,
            child: TextButton(
              onPressed: () {
                _selectDate(context);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Static.PrimaryColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    padding: EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.date_range,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Text(
                    "${selectedDate.day} ${months[selectedDate.month - 1]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 50.0,
            child: ElevatedButton(
              onPressed: () async {
                if (amount != null && note.isNotEmpty) {
                  DbHelper dbHelper = DbHelper();
                   dbHelper.addData(amount!, selectedDate, note, type);
                  Navigator.of(context).pop();
                } else {
                  print('Not all values provided');
                }
              },
              child: Text(
                'Add',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Static.PrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
