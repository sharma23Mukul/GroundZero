import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:next_hack/screens/login_register_screen.dart';

class AquiferSenseScreen extends StatefulWidget {
  const AquiferSenseScreen({super.key});

  @override
  State<AquiferSenseScreen> createState() => _AquiferSenseScreenState();
}

class _AquiferSenseScreenState extends State<AquiferSenseScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    _slideAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOutBack),
    );

    _controller.forward();  
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              Color.fromARGB(255, 132, 244, 235), // Light aqua
              Color.fromARGB(255, 103, 159, 148), // Slightly darker aqua
              Color(0xffb2dfdb), // Soft teal
            ],
          ),
        ),
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff004d40).withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 
                  Column(
                    children: [
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff26a69a).withOpacity(0.1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xff26a69a).withOpacity(0.3),
                              width: 3,
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Image.asset(
                            "assets/images/water.png",
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(_slideAnimation),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Text(
                            "Ground Zero",
                            style: GoogleFonts.poppins(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),

                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.2),
                          end: Offset.zero,
                        ).animate(_slideAnimation),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Text(
                            "Sustainable Water Management at Your Fingertips",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff00695c),
                              height: 1.3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(-0.1, 0),
                          end: Offset.zero,
                        ).animate(_slideAnimation),
                        child: const CompactFeatureTile(
                          icon: Icons.insights,
                          title: "Real-time Insights",
                          subtitle: "Track water levels and depletion trends",
                          color: Color(0xff26a69a),
                        ),
                      ),
                      const SizedBox(height: 12),

                      SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(-0.1, 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: _controller,
                                curve: const Interval(
                                  0.4,
                                  1.0,
                                  curve: Curves.easeOutBack,
                                ),
                              ),
                            ),
                        child: const CompactFeatureTile(
                          icon: Icons.smart_toy_outlined,
                          title: "AI Assistant",
                          subtitle: "Get actionable advice on water use",
                          color: Color(0xff00897b),
                        ),
                      ),
                      const SizedBox(height: 12),

                      SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(-0.1, 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: _controller,
                                curve: const Interval(
                                  0.5,
                                  1.0,
                                  curve: Curves.easeOutBack,
                                ),
                              ),
                            ),
                        child: const CompactFeatureTile(
                          icon: Icons.dashboard_outlined,
                          title: "Analytics Dashboard",
                          subtitle: "Advanced tools for researchers",
                          color: Color(0xff00695c),
                        ),
                      ),
                    ],
                  ),

                  SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(0, 0.2),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: _controller,
                            curve: const Interval(
                              0.6,
                              1.0,
                              curve: Curves.easeOutBack,
                            ),
                          ),
                        ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => const LoginScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff26a69a),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                          shadowColor: const Color(
                            0xff004d40,
                          ).withValues(alpha: .3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Get Started",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CompactFeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const CompactFeatureTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: .1), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 30, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: const Color(0xff004d40),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xff00695c).withValues(alpha: .8),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
