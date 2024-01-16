class TransactionModel {
 int amount;
  final DateTime date;
  final String note;
  final String type;

 addamount(int amount){
 this.amount=this.amount+amount;
 }
  TransactionModel(this.amount, this.date, this.note, this.type);

  // 
}
