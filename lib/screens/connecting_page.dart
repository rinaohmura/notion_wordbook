// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notion_wordbook/widgets/custom_textfield.dart';
import 'package:url_launcher/url_launcher.dart';

// 🌎 Project imports:
import 'package:notion_wordbook/viewmodels/wordbook_info.dart';

class ConnectingPage extends StatelessWidget {
  final _focusNode = FocusNode();
  final apiKeyController = TextEditingController();
  final dbIDController = TextEditingController();

  ConnectingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Focus(
        focusNode: _focusNode,
        child: GestureDetector(
          onTap: _focusNode.requestFocus,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
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
            body: SingleChildScrollView(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
                child: Column(
                  children: [
                    CustomTextField(
                      labelName: 'APIKeyを入力',
                      controller: apiKeyController,
                      obscure: true,
                    ),
                    CustomTextField(
                      labelName: 'DBのIDを入力',
                      controller: dbIDController,
                      obscure: true,
                    ),
                    ConnectButton(
                      apiKeyController: apiKeyController,
                      dbIDController: dbIDController,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () async {
                          await launch(
                            'https://torkralle.notion.site/Notion-Wordbook-d93132a576d846b0b3b5c10aa0c24908',
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 20,
                          ),
                          color: const Color.fromARGB(255, 233, 225, 240),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'API',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(text: 'や'),
                                      TextSpan(
                                        text: 'DB',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(text: 'のキーが分からない方はこちら'),
                                    ],
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.launch_outlined,
                                color: Color.fromARGB(141, 0, 0, 0),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class ConnectButton extends HookConsumerWidget {
  final TextEditingController apiKeyController, dbIDController;
  const ConnectButton({
    Key? key,
    required this.apiKeyController,
    required this.dbIDController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        await ref
            .read(wordbookInfoProvider.notifier)
            .setDBInfo(apiKeyController.text, dbIDController.text);
        Navigator.of(context).popUntil(ModalRoute.withName('/'));
      },
      child: Container(
        color: Colors.purple[600],
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 25,
        ),
        child: const Text(
          '連携',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
