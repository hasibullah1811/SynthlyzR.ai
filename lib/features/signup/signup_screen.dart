import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SynthlyzR.ai'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [Text('First Columns')],
        ),
      ),
    );
  }
}
