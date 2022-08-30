import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInput extends StatelessWidget {
  const OtpInput({
    Key? key,
    required this.bottomRight,
    required this.topRight,
    required TextEditingController codeController,
  })  : _codeController = codeController,
        super(key: key);

  final double bottomRight;
  final double topRight;
  final TextEditingController _codeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, bottom: 0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        child: Material(
          elevation: 10,
          color: const Color.fromARGB(255, 20, 20, 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(bottomRight),
                  topRight: Radius.circular(topRight))),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 40, right: 20, top: 10, bottom: 10),
            child: TextField(
              // onChanged: (value) async {
              // print(value);
              // if (value.length == 6) {
              //   //perform the auth verification
              //   _sendCodeToFirebase(code: value);
              //}
              // },
              textAlign: TextAlign.left,
              style: const TextStyle(
                  letterSpacing: 10, fontSize: 18, color: Colors.white38),
              decoration: const InputDecoration(
                fillColor: Colors.white,
                border: InputBorder.none,
                hintText: '000000',
                hintStyle: TextStyle(
                  color: Colors.white38,
                  fontSize: 18,
                ),
              ),
              controller: _codeController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(6),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
