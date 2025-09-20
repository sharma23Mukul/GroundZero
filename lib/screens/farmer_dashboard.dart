import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:next_hack/screens/chatbot_screen.dart';

class FarmerDashboard extends StatefulWidget {
  const FarmerDashboard({super.key});

  @override
  State<FarmerDashboard> createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      extendBody: true,
      
      body: SafeArea(child: _buildBody()),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff26a69a), // Teal primary
              Color(0xff00695c), // Dark teal
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w500),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.agriculture_rounded),
              label: 'ChatBot',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.water_drop_rounded),
              label: 'Water Usage',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _homeScreen();
      case 1:
        return ChatScreen();
      case 2:
        return _waterUsageScreen();
      case 3:
        return _profileScreen();
      default:
        return _homeScreen();
    }
  }

  Widget _homeScreen() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xfff0fdfc), 
            Color(0xffe6fffa), 
            Color(0xffb2dfdb), 
          ],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff004d40).withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: const Color(0xff26a69a).withOpacity(0.1),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good Morning, Farmer!",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xff00695c),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Your farm at a glance",
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff004d40),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xff26a69a).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.agriculture_rounded,
                      color: Color(0xff26a69a),
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff26a69a), 
                    Color(0xff00897b), 
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff26a69a).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "WELL STATUS",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Water Level",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "8.2",
                                style: GoogleFonts.poppins(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Text(
                                  "meters",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.trending_down_rounded,
                                color: Colors.orange[300],
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "-0.1m from last week",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.orange[300],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                width: 60,
                                height: 140 * 0.65,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.cyan[400]!,
                                      Colors.cyan[200]!,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.cyan[400]!.withOpacity(0.3),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    "65%",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff004d40),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Capacity",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            Row(
              children: [
                const Icon(
                  Icons.touch_app_rounded,
                  color: Color(0xff00695c),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "Farm Actions",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff004d40),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(child: _modernQuickLink(
                  Icons.water_drop_rounded, 
                  "Irrigation", 
                  "Schedule",
                  const Color(0xff26a69a),
                )),
                const SizedBox(width: 12),
                Expanded(child: _modernQuickLink(
                  Icons.wb_sunny_rounded, 
                  "Weather", 
                  "Forecast",
                  const Color(0xff00897b),
                )),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _modernQuickLink(
                  Icons.eco_rounded, 
                  "Crop Health", 
                  "Monitor",
                  const Color(0xff00695c),
                )),
                const SizedBox(width: 12),
                Expanded(child: _modernQuickLink(
                  Icons.chat_rounded, 
                  "AI Assistant", 
                  "Ask Help",
                  const Color(0xff004d40),
                )),
              ],
            ),
            const SizedBox(height: 32),

            Row(
              children: [
                const Icon(
                  Icons.today_rounded,
                  color: Color(0xff00695c),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "Today's Usage",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff004d40),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(child: _modernResourceCard(
                  "Water Used", 
                  "280", 
                  "liters",
                  Icons.water_drop_outlined,
                  const Color(0xff26a69a),
                )),
                const SizedBox(width: 16),
                Expanded(child: _modernResourceCard(
                  "Cost Today", 
                  "₹45", 
                  "rupees",
                  Icons.currency_rupee_rounded,
                  const Color(0xffff7043),
                )),
              ],
            ),
            const SizedBox(height: 16),
            
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: const Color(0xff26a69a).withOpacity(0.1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xff26a69a).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.bar_chart_rounded,
                          color: Color(0xff26a69a),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Weekly Summary",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff004d40),
                              ),
                            ),
                            Text(
                              "Water usage trends",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xff00695c),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.green[200]!),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.trending_down_rounded,
                              color: Colors.green[600],
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "15% saved",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.green[600],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _weeklyStatItem("Mon", "45L", true),
                      _weeklyStatItem("Tue", "38L", false),
                      _weeklyStatItem("Wed", "52L", false),
                      _weeklyStatItem("Thu", "41L", false),
                      _weeklyStatItem("Fri", "35L", false),
                      _weeklyStatItem("Sat", "48L", false),
                      _weeklyStatItem("Sun", "40L", false),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 100), 
          ],
        ),
      ),
    );
  }

  Widget _weeklyStatItem(String day, String usage, bool isToday) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 40,
          decoration: BoxDecoration(
            color: isToday ? const Color(0xff26a69a) : const Color(0xff26a69a).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              day,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isToday ? Colors.white : const Color(0xff26a69a),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          usage,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: const Color(0xff00695c),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  

  Widget _waterUsageScreen() {
    return Center(
      child: Text(
        "Water Usage Screen",
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: const Color(0xff004d40),
        ),
      ),
    );
  }

  Widget _profileScreen() {
    return Center(
      child: Text(
        "Profile Screen",
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: const Color(0xff004d40),
        ),
      ),
    );
  }

  Widget _modernQuickLink(IconData icon, String title, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color(0xff004d40),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xff00695c),
            ),
          ),
        ],
      ),
    );
  }

  Widget _modernResourceCard(String title, String value, String unit, 
      IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "TODAY",
                  style: GoogleFonts.poppins(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color: color,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xff00695c),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff004d40),
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  unit,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xff00695c),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}