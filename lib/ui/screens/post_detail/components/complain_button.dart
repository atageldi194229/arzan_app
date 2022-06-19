import 'package:provider/provider.dart';
import 'package:tm/core/api/services/feedback_sercvcie.dart';
import 'package:tm/core/localization/index.dart';
import 'package:tm/core/providers/auth_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:tm/ui/helper/arzan_show_dialogs.dart';
import 'package:tm/ui/size_config.dart';

class ComplainButton extends StatefulWidget {
  const ComplainButton({Key? key}) : super(key: key);

  @override
  State<ComplainButton> createState() => _ComplainButtonState();
}

class _ComplainButtonState extends State<ComplainButton> {
  bool _value = false;
  int? val = -1;
  bool statusTextArea = false;
  TextEditingController complainFeedback = TextEditingController();

  handleTap(BuildContext context) {
    bool isUserLoggedIn = context.read<AuthProvider>().isLoggedIn;

    if (isUserLoggedIn) {
      showDialog<String>(
        context: context,
        builder: _dialogBuilder,
      );
    } else {
      showDialogToLogin(context);
    }
  }

  Widget _dialogBuilder(BuildContext context) {
    return SingleChildScrollView(
      child: StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              context.tt('complain'),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    bottom: getProportionateScreenHeight(kDilegSizedBox + 5)),
                height: getProportionateScreenHeight(150),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: RadioListTile(
                        value: 1,
                        groupValue: val,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            val = value as int?;
                            _value = true;
                            statusTextArea = false;
                            complainFeedback.text = 'Illegal content';
                          });
                        },
                        title: Text(
                          context.tt('illegal_content'),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
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
                            statusTextArea = false;
                            complainFeedback.text = 'Inappropriate image';
                          });
                        },
                        title: Text(context.tt('inappropriate_image'),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700)),
                        selected: _value,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        value: 3,
                        activeColor: Colors.green,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {
                            val = value as int?;
                            _value = true;
                            statusTextArea = false;
                            complainFeedback.text = 'unrealiable of_informtion';
                          });
                        },
                        title: Text(context.tt('unrealiable_of_informtion'),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700)),
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
                            val = value as int?;
                            _value = true;
                            statusTextArea = true;
                          });
                        },
                        title: Text(context.tt('other'),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700)),
                        selected: _value,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: kDilegSizedBox + 10,
              ),
              statusTextArea
                  ? Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 197, 196, 196),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: complainFeedback,
                        maxLines: 10,
                        maxLength: 1000,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: context.tt('description'),
                          hintStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          // counterText: '(0/1000)',

                          counterStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(20),
                            vertical: getProportionateScreenWidth(15),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(height: kDilegSizedBox),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    FeedbackService()
                        .userFeedback(text: complainFeedback.text)
                        .then((value) {
                      if (value) {
                        Navigator.of(context).pop();
                        showDialogSuccess(context);
                      } else {
                        debugPrint('server error');
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(12)),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 233, 16, 0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(context.tt('to_send'),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        highlightColor: Colors.transparent,
        onTap: () => handleTap(context),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: kBorderRadius,
            boxShadow: kBoxShadow,
          ),
          child: Text(
            context.tt('complain'),
            style: const TextStyle(
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
    Key? key,
    required this.value,
    required this.groupValue,
    required this.text,
    required this.onChanged,
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
