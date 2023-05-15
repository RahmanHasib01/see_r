import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode
          ? const Color.fromARGB(255, 168, 172, 125)
          : Colors.grey[300],
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgimage.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 40, bottom: 20)),
            Image.asset(
              'assets/images/logo.png',
              width: 52,
              height: 51,
              alignment: Alignment.center,
            ),
            const Text(
              'WELCOME TO SEE-R',
              style: TextStyle(
                fontFamily: 'opensans',
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 280,
                  height: 470,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
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
                  child: Icon(
                    Icons.android,
                    size: 80,
                    color: darkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
