import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatefulWidget {
  final double topRight;
  final double bottomRight;
  final TextEditingController controller;

  const InputWidget(this.topRight, this.bottomRight,
      {required this.controller, Key? key})
      : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  FocusNode focusNode = FocusNode();
  String hintText = 'Enter your number';
  String prefix = '+91 ';
  bool hasHint = true;
  //TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    hintText = prefix;

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          hintText = '';
          hasHint = false;
        });
      } else {
        setState(() {
          hintText = prefix;
          hasHint = true;
        });
      }
    });
    return Padding(
      padding: const EdgeInsets.only(right: 40, bottom: 0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        child: Material(
          elevation: 10,
          color: const Color.fromARGB(255, 20, 20, 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(widget.bottomRight),
                  topRight: Radius.circular(widget.topRight))),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 40, right: 20, top: 10, bottom: 10),
            child: TextField(
              controller: widget.controller,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,

              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly,
              ],
              //maxLength: 10,
              focusNode: focusNode,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixText: hasHint
                    ? ''
                    : prefix, // perfixText does not returns as part of the user's input
                prefixStyle: const TextStyle(
                  color: Colors.white38,
                  fontSize: 18,
                ),
                hintText: hasHint ? prefix : '',
                hintStyle: const TextStyle(
                  color: Colors.white38,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
