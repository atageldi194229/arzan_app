import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:tm/ui/size_config.dart';

class ComplainButton extends StatefulWidget {

  const ComplainButton({Key? key}) : super(key: key);

  @override
  State<ComplainButton> createState() => _ComplainButtonState();
}

class _ComplainButtonState extends State<ComplainButton> {
    bool _value = false;
  int val = -1;
  @override
  Widget build(BuildContext context) {
      
    return Center(
      child: InkWell(
        highlightColor: Colors.transparent,
        onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => SingleChildScrollView(
          child: AlertDialog(
            title: const Text('To complain', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
            actions: <Widget>[
             Column(
               verticalDirection: VerticalDirection.up,
               children: [
               ComplainButtonRadio(groupValue: 1, text: "other", value: 1, onChanged: (){},),
               ComplainButtonRadio(groupValue: 1, text: "Illegal content", value: 2, onChanged: (){},),
               ComplainButtonRadio(groupValue: 1, text: "Inappropriate image", value: 3, onChanged: (){},),
               ComplainButtonRadio(groupValue: 1, text: "Unrealiable of  informantion", value: 4, onChanged: (){},),
               
               ],
             ),
           Align(
             alignment: Alignment.center,
             child: Text('Write to us about what is bothering you', style: TextStyle(fontWeight: FontWeight.bold),)),
               SizedBox(height: kDilegSizedBox+10,),
             
               Container(
                 decoration: BoxDecoration(
                   color: Color.fromARGB(255, 197, 196, 196),
                   borderRadius: BorderRadius.circular(10)
                 ),
                 child: TextField(
                    maxLines: 10,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Description...",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenHeight(20),
                        vertical: getProportionateScreenWidth(15),
                      ),
                    ),
                  ),
               ),
               SizedBox(height: kDilegSizedBox),
               Align(
                 alignment: Alignment.center,
                 child: Container(
                   padding: EdgeInsets.all(getProportionateScreenWidth(12)),
                   decoration: BoxDecoration(
                     color: Color.fromARGB(255, 233, 16, 0),
                     borderRadius: BorderRadius.circular(10)
                   ),
                   child: Text('To send', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                 ),
               )
            ],
          ),
        ),
      ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: kBorderRadius,
            boxShadow: kBoxShadow,
          ),
          child: const Text(
            'Complain',
            style: TextStyle(
              color: Colors.red,
              letterSpacing: 0.7,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ComplainButtonRadio extends StatefulWidget {
  final int value;
  final int groupValue;
  final String text;
  final Function onChanged;
  const ComplainButtonRadio({
    Key? key,required this.value,required this.groupValue,required this.text,required this.onChanged,
  }) : super(key: key);

  @override
  State<ComplainButtonRadio> createState() => _ComplainButtonRadioState();
}

class _ComplainButtonRadioState extends State<ComplainButtonRadio> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.text),
    
      leading: Radio(
        value: widget.value,
        groupValue: widget.groupValue,
        onChanged: widget.onChanged(),
        activeColor: Colors.red,
      ),
    );
  }
}
