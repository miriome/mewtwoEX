import 'package:flutter/material.dart';
import 'package:mewtwo/base/widgets/miromie_title.dart';

class ForgetPasswordPage extends StatelessWidget {
const ForgetPasswordPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          
          
          children: [
            SizedBox(height: 72,),
            MiromieTitle(fontSize: 72),
            SizedBox(height: 72,),
            Text("Please send an email to hello@miromie.com to request for a password reset, indicating the email that you signed up with", style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
    );
  }
}