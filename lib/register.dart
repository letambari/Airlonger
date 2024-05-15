import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  bool _passwordVisible = false;
  //obscureText: !_passwordVisible,

  // Function to display a snackbar for failed login attempt
  void showLoginFailedSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Function to display a snackbar for failed login attempt
  void showLoginSuccessSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.green,
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Function to handle login process
  Future<void> registerScript(BuildContext context) async {
    final String apiUrl = 'https://api.airlonger.com/api/register/';
    final String apiKey = '13db0a2eda129aa67f8b2c60e175e1fd';

    final Map<String, dynamic> requestBody = {
      'firstName': _fnameController.text,
      'lastName': _lnameController.text,
      'phone': _phoneController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
    };

    final String requestBodyJson = json.encode(requestBody);

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'API-Key': apiKey,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: requestBodyJson,
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      // If login successful, extract token and navigate to dashboard

      showLoginSuccessSnackbar(context, responseData['message']);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } else {
      // If login failed, show snackbar with error message
      showLoginFailedSnackbar(context, responseData['message']);
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //title: Text('Login'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/airlonger-logo-dark.png',
                    width: 150,
                    height: 150,
                  ),

                  SizedBox(height: 20),
                  // Email input field

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign-in',
                        style: TextStyle(
                          color: Colors.red,
                          //decoration: TextDecoration.underline,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  TextField(
                    controller: _fnameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      hintText: 'Enter your First Name',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 20),
                  TextField(
                    controller: _lnameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      hintText: 'Enter your Last Name',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 20),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      hintText: 'Enter your Phone Number',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 10),
                  // Password input field
                  TextField(
                    controller: _passwordController,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red), // Set border color
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red), // Set error border color
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible; // Toggle password visibility
                          });
                        },
                        child: Icon(
                          _passwordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey, // Change the icon color as needed
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: 20),
                  // Login button
                  ElevatedButton(
                    onPressed: () {
                      // Handle login logic here
                      String firstName = _fnameController.text;
                      String lastName = _lnameController.text;
                      String phone = _phoneController.text;
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      // Example: validate credentials
                      if (email.isNotEmpty && password.isNotEmpty) {
                        // Perform login operation
                        // For demo purposes, just print the credentials
                        registerScript(context);
                      } else {
                        showLoginFailedSnackbar(context, 'Please fill in all fields');
                      }
                    },
                    child: Text('Register',
                      style: TextStyle(
                        color: Colors.red,
                        //decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Add your forgot password logic here
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Have an account? Login Here',
                          style: TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _fnameController.dispose();
    _lnameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
