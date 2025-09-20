import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:next_hack/screens/farmer_dashboard.dart';
import 'package:next_hack/screens/research_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Aqua Manthan",
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xfff8fffe),  
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xffe0f2f1), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xff26a69a), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class AuthBackground extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const AuthBackground({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0fdfc), 
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 132, 244, 235), 
              Color.fromARGB(255, 103, 159, 148), 
              Color(0xffb2dfdb), 
            ],
          ),
        ),
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff004d40).withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff004d40), 
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color(0xff00695c), 
                    ),
                  ),
                  const SizedBox(height: 40),
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _selectedRole;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<String> _roles = ['Farmer', 'Policy Maker', 'Researcher'];

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      title: "Welcome Back!",
      subtitle: "Login to your Aqua Manthan account",
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Select your role',
              labelStyle: GoogleFonts.poppins(
                color: const Color(0xff00695c),
                fontWeight: FontWeight.w500,
              ),
            ),
            initialValue: _selectedRole,
            dropdownColor: const Color(0xfff8fffe),
            items: _roles
                .map(
                  (role) => DropdownMenuItem(
                    value: role,
                    child: Text(
                      role,
                      style: GoogleFonts.poppins(
                        color: const Color(0xff004d40),
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() => _selectedRole = value);
            },
          ),
          const SizedBox(height: 20),

          TextField(
            controller: _emailController,
            style: GoogleFonts.poppins(color: const Color(0xff004d40)),
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'you@example.com',
              labelStyle: GoogleFonts.poppins(
                color: const Color(0xff00695c),
                fontWeight: FontWeight.w500,
              ),
              hintStyle: GoogleFonts.poppins(color: const Color(0xff80cbc4)),
            ),
          ),
          const SizedBox(height: 20),

          TextField(
            controller: _passwordController,
            obscureText: true,
            style: GoogleFonts.poppins(color: const Color(0xff004d40)),
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: GoogleFonts.poppins(
                color: const Color(0xff00695c),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff26a69a),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                shadowColor: const Color(0xff004d40).withValues(alpha: .3),
              ),
              onPressed: () {
                final email = _emailController.text.trim();
                final password = _passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter valid inputs!"),
                      backgroundColor: Color.fromARGB(148, 244, 67, 54),
                    ),
                  );
                } 
                else if(_selectedRole.toString() == 'Farmer'){
                  Get.to(FarmerDashboard());

                }
                
                else if(_selectedRole.toString() == 'Researcher') {
                  Get.to(() => const ResearcherDashboard());
                }
              },
              child: Text(
                "Login",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                );
              },
              child: Text(
                "New user? Register here",
                style: GoogleFonts.poppins(
                  color: const Color(0xff00695c), 
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _selectedRole;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final List<String> _roles = ['Farmer', 'Policy Maker', 'Researcher/NGO'];

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      title: "Join Ground Zero 🌱",
      subtitle: "Create your free account to get started",
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Select your role',
              labelStyle: GoogleFonts.poppins(
                color: const Color(0xff00695c),
                fontWeight: FontWeight.w500,
              ),
            ),
            initialValue: _selectedRole,
            dropdownColor: const Color(0xfff8fffe),
            items: _roles
                .map(
                  (role) => DropdownMenuItem(
                    value: role,
                    child: Text(
                      role,
                      style: GoogleFonts.poppins(
                        color: const Color(0xff004d40),
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() => _selectedRole = value);
            },
          ),
          const SizedBox(height: 20),

          TextField(
            controller: _nameController,
            style: GoogleFonts.poppins(color: const Color(0xff004d40)),
            decoration: InputDecoration(
              labelText: 'Full Name',
              labelStyle: GoogleFonts.poppins(
                color: const Color(0xff00695c),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),

          TextField(
            controller: _emailController,
            style: GoogleFonts.poppins(color: const Color(0xff004d40)),
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'you@example.com',
              labelStyle: GoogleFonts.poppins(
                color: const Color(0xff00695c),
                fontWeight: FontWeight.w500,
              ),
              hintStyle: GoogleFonts.poppins(color: const Color(0xff80cbc4)),
            ),
          ),
          const SizedBox(height: 20),

          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            style: GoogleFonts.poppins(color: const Color(0xff004d40)),
            decoration: InputDecoration(
              labelText: 'Phone Number',
              labelStyle: GoogleFonts.poppins(
                color: const Color(0xff00695c),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),

          TextField(
            controller: _passwordController,
            obscureText: true,
            style: GoogleFonts.poppins(color: const Color(0xff004d40)),
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: GoogleFonts.poppins(
                color: const Color(0xff00695c),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),

          TextField(
            controller: _confirmPasswordController,
            obscureText: true,
            style: GoogleFonts.poppins(color: const Color(0xff004d40)),
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              labelStyle: GoogleFonts.poppins(
                color: const Color(0xff00695c),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff26a69a),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                shadowColor: const Color(0xff004d40).withOpacity(0.3),
              ),
              onPressed: () {},
              child: Text(
                "Create Account",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Already have an account? Login",
                style: GoogleFonts.poppins(
                  color: const Color(0xff00695c), 
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
