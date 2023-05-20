import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'signin.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class MyClickableText extends StatelessWidget {
  const MyClickableText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Already have an account?  ',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 13,
        ),
        children: [
          TextSpan(
            text: 'Sign in',
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SigninPage()),
                );
              },
          ),
        ],
      ),
    );
  }
}

class _SignupPageState extends State<SignupPage> {
  bool darkMode = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevent the UI from moving when the keyboard appears
      backgroundColor: darkMode
          ? const Color.fromARGB(255, 168, 172, 125)
          : Colors.grey[300],
      body: GestureDetector(
        // Wrap the body with GestureDetector to handle tapping outside the text fields
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Hide the keyboard when tapping outside the text fields
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bgimage.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 30, bottom: 40)),
              Image.asset(
                'assets/images/logo.png',
                width: 52,
                height: 51,
                alignment: Alignment.center,
              ),
              Text(
                'WELCOME TO SEE-R',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    width: 300,
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: darkMode
                              ? const Color.fromARGB(52, 0, 0, 0)
                              : const Color.fromARGB(100, 0, 0, 0),
                          offset: const Offset(5, 5),
                          blurRadius: 10,
                        ),
                        BoxShadow(
                          color: darkMode
                              ? const Color.fromARGB(172, 238, 241, 213)
                              : const Color.fromARGB(146, 254, 250, 224),
                          offset: const Offset(-5, -5),
                          blurRadius: 10,
                        ),
                      ],
                      color: darkMode
                          ? const Color.fromARGB(255, 168, 172, 125)
                          : const Color.fromARGB(255, 254, 250, 224),
                    ),
                    alignment: Alignment.topCenter,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 0, top: 20),
                            child: Text(
                              'Create an account',
                              style: TextStyle(
                                fontFamily: 'opensans',
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Column(
                            //
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 15),
                                child: MyClickableText(),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: const MaterialStatePropertyAll<Size>(
                                Size(200, 30),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 220, 228, 180),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Perform signup logic here
                                // Use _emailController.text to access the entered email
                                // Use _passwordController.text to access the entered password
                              }
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: FaIcon(
                                    FontAwesomeIcons.google,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ),

                                SizedBox(
                                    width:
                                        8), // Add some spacing between the icon and text
                                Text(
                                  'Sign up with google',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontFamily: 'opensans',
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 0),
                            child: Text(
                                '------------------------   or   ------------------------',
                                style: TextStyle(
                                  fontFamily: 'opensans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w100,
                                  color: Colors.black,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, left: 15, right: 15, bottom: 0),
                            child: TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, left: 15, right: 15, bottom: 20),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: const MaterialStatePropertyAll<Size>(
                                Size(200, 25),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 220, 228, 180),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Perform signup logic here
                                // Use _emailController.text to access the entered email
                                // Use _passwordController.text to access the entered password
                              }
                            },
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'opensans',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              text:
                                  'By clicking "Get started", you are agreeing to our terms of service and privacy policy',
                              style: TextStyle(
                                fontFamily: 'opensans',
                                fontSize: 10,
                                fontWeight: FontWeight.w100,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
