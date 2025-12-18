import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
 
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.food;
  DateTime _dateTime=  DateTime.now();

  @override
  void dispose(){
    super.dispose();

    _titleController.dispose();
  }

  void onCreate() {
    //  1 Build an expense
    String  title = _titleController.text;
    double amount = double.tryParse(_amountController.text) ?? 0;          // for now..
    Category category =Category.food;   // for now..
    DateTime date =_dateTime;
    

    // ignore: unused_local_variable
    Expense newExpense = Expense(title: title, amount: amount, date: date, category: _selectedCategory);



    // TODO YOUR CODE HERE

    
    

    Navigator.pop(context,newExpense);
  }
  
  void onCancel() {
   
    // Close the modal
    Navigator.pop(context);
  }
  void defaultCategory(Category? category){
    if(category==null) return;
    setState(() {
      _selectedCategory=category;
    });
  }
   Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = picked;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(label: Text("Title")),
            maxLength: 50,
          ),
          SizedBox(height: 10,),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(label: Text("Amount")),
            keyboardType: TextInputType.number,
            maxLength: 50,
          ),
          SizedBox(height: 10,),
          DropdownButton<Category>(value: _selectedCategory,items: Category.values.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category.name.toUpperCase()),
              );
            }).toList(), onChanged: defaultCategory),
            SizedBox(width: 10,),
            const SizedBox(height: 20.0,),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 8),
                Text('Select date'),
              ],
            ),
),
           ElevatedButton(onPressed: onCancel, child: Text("Cancel")),
           
          ElevatedButton(onPressed: onCreate, child: Text("Create")),
        ],
      ),
    );
  }
}
