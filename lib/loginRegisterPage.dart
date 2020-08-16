import 'package:blog_app/authentication.dart';
import 'package:blog_app/dialogBox.dart';
import 'package:flutter/material.dart';

class LoginRegisterPage extends StatefulWidget {
  LoginRegisterPage({
    this.auth,
    this.onSignedIn,
  });
  final AuthImplementation auth;
  final VoidCallback onSignedIn;
  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

enum FormTytpe { login, register }

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  DialogBox dialogBox = DialogBox();

  final formKey = GlobalKey<FormState>();
  FormTytpe _formTytpe = FormTytpe.login;
  String _email = "";
  String _password = "";
  //method
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formTytpe == FormTytpe.login) {
          String userId = await widget.auth.signIn(_email, _password);
          //dialogBox.information(context, "Kudos!!", "Great to see you again.");
          print("login userId = " + userId);
        } else {
          String userId = await widget.auth.signUp(_email, _password);
          //dialogBox.information(context, "Congratulations",
          // "Your blog has been created successfully.");
          print("Register userId = " + userId);
        }

        widget.onSignedIn();
      } catch (e) {
        dialogBox.information(context, "Error", e.toString());
        print("Error = " + e.toString());
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formTytpe = FormTytpe.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formTytpe = FormTytpe.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F5F7),
      appBar: AppBar(
        title: Text("Flutter Blog App"),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createInputs() + createButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> createInputs() {
    return [
      SizedBox(height: 10.0),
      logo(),
      SizedBox(
        height: 20.0,
      ),
      Expanded(
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Email'),
          validator: (value) {
            return value.isEmpty ? 'Opps! Email is Required' : null;
          },
          onSaved: (value) {
            return _email = value;
          },
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
      Expanded(
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: (value) {
            return value.isEmpty ? 'You cant ignore the password! buddy' : null;
          },
          onSaved: (value) {
            return _password = value;
          },
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
    ];
  }

  Widget logo() {
    return Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 90.0,
        child: Image.asset('assets/images/chatee.png'),
      ),
    );
  }

  List<Widget> createButtons() {
    if (_formTytpe == FormTytpe.login) {
      return [
        RaisedButton(
          child: Text(
            "Login",
            style: TextStyle(fontSize: 20.0),
          ),
          color: Color(0xFF3EBACE),
          onPressed: validateAndSubmit,
        ),
        SizedBox(
          height: 20.0,
        ),
        FlatButton(
          child: Text(
            "Not having an account? Create account?",
            style: TextStyle(fontSize: 14.0),
          ),
          color: Color(0xFF3EBACE),
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return [
        RaisedButton(
          child: Text(
            "Create Account?",
            style: TextStyle(fontSize: 20.0),
          ),
          color: Color(0xFF3EBACE),
          onPressed: validateAndSubmit,
        ),
        SizedBox(
          height: 20.0,
        ),
        FlatButton(
          child: Text(
            "Already have an account? Login",
            style: TextStyle(fontSize: 14.0),
          ),
          color: Color(0xFF3EBACE),
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}
