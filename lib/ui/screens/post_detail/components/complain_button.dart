import 'package:flutter_html/flutter_html.dart';
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
         int? val = -1; 
         bool StatusTextArea = false;
  @override
  Widget build(BuildContext context) {
        
    return Center(
      child: InkWell(
        highlightColor: Colors.transparent,
        onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => SingleChildScrollView(
          child: StatefulBuilder(
            builder: (context, setState){
              return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              title: const Text('To complain', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
              actions: <Widget>[
               Container(
                 margin: EdgeInsets.only(bottom: getProportionateScreenHeight(kDilegSizedBox+5)),
                 height: getProportionateScreenHeight(150),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children: [
               
               Expanded(  
                 child: RadioListTile(
                   
                           value: 1 ,
                           groupValue: val,
                           activeColor: Colors.green,
                           onChanged: (value)  {
                            setState(() {
                              val =  value as int?;
                             _value = true;
                          });
                           },
                           title: Text("Illegal content", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                           selected: _value,
                         ),
               ),
              Expanded(
                child: RadioListTile(
                value: 2,
                activeColor: Colors.green,
                groupValue: val,
                onChanged: (value) {
                   setState(() {
                            val = value as int?;
                             _value = true;
                          });
                },
                title: Text("Inappropriate image", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                selected: _value,
          
                ),
              ),
              Expanded(
                child: RadioListTile(
                value: 3,
                activeColor: Colors.green,
                groupValue: val,
                onChanged: (value) {
                  
                },
                title: Text("Unrealiable of  informantion", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                 selected: _value,
          
                ),
              ),
              Expanded(
                child: RadioListTile(
                value: 4,
                activeColor: Colors.green,
                groupValue: val,
                onChanged: (value) {
                   setState(() {
                            val =  value as int?;
                             _value = true;
                             StatusTextArea=true;
                          });
                },
                  title: Text("other", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                  selected: _value,
                        ),
              )
                   ],
                 ),
               ),
                   
                 SizedBox(height: kDilegSizedBox+10,),
               
                StatusTextArea? Container(
                   decoration: BoxDecoration(
                     color: Color.fromARGB(255, 197, 196, 196),
                     borderRadius: BorderRadius.circular(10)
                   ),
                   child: TextField(
                      maxLines: 10,
                      maxLength: 1000,
                      decoration: InputDecoration(
                        
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "Description...",
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        // counterText: '(0/1000)',
                        
                        counterStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenHeight(20),
                          vertical: getProportionateScreenWidth(15),
                        ),
                      ),
                    ),
                 ) : Container(),
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
            );
            },
   
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
        activeColor: Colors.green,
      ),
    );
  }
}
