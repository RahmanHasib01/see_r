import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:see_r/home_page.dart';
import 'package:see_r/signup.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class MyClickableText extends StatelessWidget {
  const MyClickableText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Do not have an account?  ',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 13,
        ),
        children: [
          TextSpan(
            text: 'Sign up',
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupPage()),
                );
              },
          ),
        ],
      ),
    );
  }
}

class _SigninPageState extends State<SigninPage> {
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
              Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 100, bottom: 0)),
                  Image.asset(
                    'assets/images/logo.png',
                    width: 52,
                    height: 51,
                    alignment: const Alignment(0, 0),
                  ),
                  Text(
                    'WELCOME TO SEE-R',
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 320,
                    height: 530,
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
                              'Sign in',
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
                                // Perform Signin logic here
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
                                  'Sign in with google',
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
                            padding: EdgeInsets.only(top: 25, bottom: 0),
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
                                top: 12, left: 25, right: 25, bottom: 0),
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
                                top: 0, left: 25, right: 25, bottom: 20),
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
                          const Column(
                            //
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 5),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all<Size>(
                                const Size(200, 25),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 220, 228, 180),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Perform Signin logic here
                                // Use _emailController.text to access the entered email
                                // Use _passwordController.text to access the entered password
                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text)
                                    .then((userCredential) {
                                  // Login successful, navigate to the homepage or desired screen
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()),
                                  );
                                }).catchError((error) {
                                  // Handle login error if necessary
                                  print('Login Error: $error');
                                });
                              }
                            },
                            child: const Text(
                              'Login',
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
                              text: 'forgot password?',
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
