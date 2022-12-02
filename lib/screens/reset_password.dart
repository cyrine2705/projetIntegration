import 'package:flutter/material.dart';


class EnterNewPasswordPage extends StatefulWidget {
  const EnterNewPasswordPage({super.key});


  @override
  State<EnterNewPasswordPage> createState() => _EnterNewPasswordPageState();
}

class _EnterNewPasswordPageState extends State<EnterNewPasswordPage> {

  final TextEditingController passwordResetCodeController = TextEditingController();

  bool loginButton = false;



  @override
  void dispose(){
    super.dispose();
    this.passwordResetCodeController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 200),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [

          Text(
            "Enter new password to reset your account",
            textAlign: TextAlign.center,
          ),

          Text("  "),

          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "New password",
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 8, 221, 193)))
            ),
            controller: passwordResetCodeController, 
            onChanged: (text){this.activateResetPassword();},
          ),

          Text("   "),

          SizedBox(
            width: double.infinity,
            height: 30,
            child:  ElevatedButton(
              
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 8, 221, 193)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius:  BorderRadius.circular(20))
                )
              ),


              child: Text("Next"),
              onPressed: this.loginButton ? null : () => this.passwordReset()
            )
          ),


        ],
      )
    );
  }


  void activateResetPassword(){
    setState(){
      if(this.passwordResetCodeController.text != "") this.loginButton = true;
    }
  }

  void passwordReset(){

  }
  

}