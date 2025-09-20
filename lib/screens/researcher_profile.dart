import 'package:flutter/material.dart';

class ResearcherProfileScreen extends StatefulWidget {
  const ResearcherProfileScreen({super.key});

  @override
  State<ResearcherProfileScreen> createState() => _ResearcherProfileScreenState();
}

class _ResearcherProfileScreenState extends State<ResearcherProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF1E3A8A),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.brown],
                  ),
                ),
                child: const ProfileHeader(),
              ),
            ),
          ),
          
          SliverPersistentHeader(
            pinned: true,
            delegate: TabBarDelegate(
              TabBar(
                controller: _tabController,
                indicatorColor: const Color(0xFF3B82F6),
                labelColor: const Color(0xFF1E3A8A),
                unselectedLabelColor: Colors.grey[600],
                tabs: const [
                  Tab(text: 'Overview'),
                  Tab(text: 'Research'),
                  Tab(text: 'Publications'),
                  Tab(text: 'Tools'),
                ],
              ),
            ),
          ),
          
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: const [
                OverviewTab(),
                ResearchTab(),
                PublicationsTab(),
                ToolsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Dr. Priyanshu Kumar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Senior Hydrogeologist',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('15', 'Years Exp.'),
                _buildStatItem('47', 'Publications'),
                _buildStatItem('12', 'Projects'),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            'About',
            'Specialized in groundwater level analysis and aquifer management with over 15 years of experience. Currently leading research on sustainable water resource management and climate impact assessment on groundwater systems.',
            Icons.info_outline,
          ),
          
          _buildSection(
            'Expertise',
            '',
            Icons.star_outline,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildChip('Hydrogeology'),
                _buildChip('GIS Analysis'),
                _buildChip('Water Quality'),
                _buildChip('Remote Sensing'),
                _buildChip('Data Modeling'),
                _buildChip('Climate Impact'),
              ],
            ),
          ),
          
          _buildContactInfo(),
          
          _buildAchievements(),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content, IconData icon, {Widget? child}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF3B82F6)),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (content.isNotEmpty)
              Text(
                content,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            if (child != null) child,
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
      backgroundColor: const Color(0xFF3B82F6).withOpacity(0.1),
      labelStyle: const TextStyle(color: Color(0xFF1E3A8A)),
    );
  }

  Widget _buildContactInfo() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.contact_mail, color: Color(0xFF3B82F6)),
                SizedBox(width: 8),
                Text(
                  'Contact Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildContactItem(Icons.email, 'priyanshu@example.com'),
            _buildContactItem(Icons.phone, '28278723878'),
            _buildContactItem(Icons.location_on, 'India'),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(text, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.emoji_events, color: Color(0xFF3B82F6)),
                SizedBox(width: 8),
                Text(
                  'Recent Achievements',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildAchievementItem('Best Research Paper Award 2023', 'International Hydrogeology Conference'),
            _buildAchievementItem('Grant Recipient', 'NSF Groundwater Research Initiative - \$2.5M'),
            _buildAchievementItem('Editorial Board Member', 'Journal of Groundwater Science'),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

class ResearchTab extends StatelessWidget {
  const ResearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildProjectCard(
            'Climate Impact on Aquifer Systems',
            'Analyzing long-term effects of climate change on groundwater recharge rates',
            'Active',
            '2022-2025',
            Colors.green,
            0.75,
          ),
          _buildProjectCard(
            'Urban Groundwater Quality Assessment',
            'Comprehensive study of contaminant sources in metropolitan groundwater',
            'In Progress',
            '2023-2024',
            Colors.orange,
            0.45,
          ),
          _buildProjectCard(
            'AI-Driven Water Level Prediction',
            'Machine learning models for groundwater level forecasting',
            'Planning',
            '2024-2026',
            Colors.blue,
            0.15,
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(String title, String description, String status, 
      String timeline, Color statusColor, double progress) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  timeline,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
            ),
          ],
        ),
      ),
    );
  }
}

class PublicationsTab extends StatelessWidget {
  const PublicationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildPublicationCard(
            'Sustainable Groundwater Management in Arid Regions',
            'Nature Water Sciences, 2023',
            'Johnson, S., et al.',
            'Impact Factor: 4.2',
            156,
          ),
          _buildPublicationCard(
            'Machine Learning Approaches for Aquifer Characterization',
            'Journal of Hydrology, 2023',
            'Johnson, S., Miller, P., Chen, L.',
            'Impact Factor: 3.8',
            89,
          ),
          _buildPublicationCard(
            'Climate Change Effects on Groundwater Recharge',
            'Water Resources Research, 2022',
            'Johnson, S., Brown, A.',
            'Impact Factor: 4.6',
            234,
          ),
        ],
      ),
    );
  }

  Widget _buildPublicationCard(String title, String journal, String authors, 
      String impact, int citations) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              journal,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              authors,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  impact,
                  style: const TextStyle(
                    color: Color(0xFF3B82F6),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '$citations citations',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ToolsTab extends StatelessWidget {
  const ToolsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildToolCard(
            'Groundwater Level Predictor',
            'AI-powered tool for forecasting water levels',
            Icons.trending_up,
            Colors.blue,
          ),
          _buildToolCard(
            'Aquifer Health Monitor',
            'Real-time monitoring and analysis dashboard',
            Icons.monitor_heart,
            Colors.green,
          ),
          _buildToolCard(
            'Data Visualization Suite',
            'Interactive charts and maps for groundwater data',
            Icons.bar_chart,
            Colors.purple,
          ),
          _buildToolCard(
            'Quality Assessment Tool',
            'Comprehensive water quality analysis platform',
            Icons.water_drop,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildToolCard(String title, String description, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  TabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(TabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}