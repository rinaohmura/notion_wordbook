// 🐦 Flutter imports:
import 'package:flutter/material.dart';

bool _isObscure = true;

class ConnectingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 80,
          elevation: 10,
          title: const Text(
            'Notionと連携',
            style: TextStyle(
              fontSize: 27,
            ),
          ),
          backgroundColor: Colors.purple[800],
        ),
        body: Container(
          margin: EdgeInsets.only(top: 80, left: 30, right: 30),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              InputDecorator(labelName: 'API Key'),
              InputDecorator(labelName: 'DB Key'),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                margin: EdgeInsets.only(top: 20),
                color: Color.fromARGB(255, 233, 225, 240),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        children: [
                          TextSpan(
                              text: 'API',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: 'や'),
                          TextSpan(
                              text: 'DB',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: 'のキーが分からない方はこちら'),
                        ],
                      ),
                    ),
                    Icon(Icons.launch_outlined)
                  ],
                ),
              )
            ],
          ),
        ),
      );
}

class InputDecorator extends StatelessWidget {
  const InputDecorator({
    Key? key,
    required this.labelName,
  }) : super(key: key);

  final String labelName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(right: 155, bottom: 25),
            child: Text(
              labelName + 'を入力',
              style: TextStyle(
                fontSize: 27,
              ),
            ),
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
              labelText: labelName,
              labelStyle: TextStyle(fontSize: 16),
              // The MaterialStateProperty's value is a text style that is orange
              // by default, but the theme's error color if the input decorator
              // is in its error state.
              floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                  (Set<MaterialState> states) {
                final Color color = states.contains(MaterialState.error)
                    ? Theme.of(context).errorColor
                    : Colors.purple;
                return TextStyle(color: color, fontSize: 20);
              }),
              suffixIcon: IconButton(
                onPressed: () {
                  _isObscure = !_isObscure;
                },
                icon: Icon(_isObscure
                    ? Icons.visibility_off
                    : Icons.visibility), //icon切り替え
                color: Color.fromARGB(160, 0, 0, 0),
              ),
            ),
            validator: (String? value) {
              if (value == null || value == '') {
                return 'Enter ' + labelName;
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.always,
          ),
        ],
      ),
    );
  }
}

//       // アイコンがタップされたら現在と反対の状態をセットする
//       onPressed: () {
//         // setState(() {
//         _isObscure = !_isObscure;
//         // });
//       },
