import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:next_hack/screens/result_screen.dart';

class SearchPanelScreen extends StatefulWidget {
  const SearchPanelScreen({super.key});

  @override 
  State<SearchPanelScreen> createState() => _SearchPanelScreenState();
}

class _SearchPanelScreenState extends State<SearchPanelScreen> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  
  String? selectedDataset;
  String? selectedCategory = "Admin";
  String? selectedState;
  String? selectedDistrict;
  String? selectedAgency;

  DateTime? startDate;
  DateTime? endDate;

  final List<String> datasets = ["GroundWater Level", "Rainfall", "Atmospheric Pressure"];
  final List<String> categories = ["Admin", "Technical", "Research"];
  final List<String> states = ["Maharashtra", "Punjab", "Gujarat", "Delhi"];
  final List<String> districts = ["New Delhi", "North Delhi", "South Delhi"];
  final List<String> agencies = ["CGWB", "CGWA", "CGWC"];

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff26a69a),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xff004d40),
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
          _startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        } else {
          endDate = picked;
          _endDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0fdfc), 
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 32),
                  _buildDatasetSection(),
                  const SizedBox(height: 20),
                  _buildLocationSection(),
                  const SizedBox(height: 24),
                  _buildDateSection(),
                  const SizedBox(height: 32),
                  _buildButtons(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xff26a69a).withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xff26a69a).withOpacity(0.3),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.analytics_rounded,
              size: 80,
              color: Color(0xff26a69a),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Get Your Prediction!",
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xff004d40),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Configure parameters for water level prediction",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xff00695c),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatasetSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Dataset Configuration",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xff004d40),
          ),
        ),
        const SizedBox(height: 16),
        _buildDropdown(
          value: selectedDataset,
          items: datasets,
          hint: "Select Dataset",
          label: "Dataset",
          onChanged: (val) => setState(() => selectedDataset = val),
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Location Details",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xff00695c),
          ),
        ),
        const SizedBox(height: 12),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _buildDropdown(
                  value: selectedCategory,
                  items: categories,
                  hint: "Category",
                  label: "Category",
                  onChanged: (val) => setState(() => selectedCategory = val),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdown(
                  value: selectedState,
                  items: states,
                  hint: "State",
                  label: "State",
                  onChanged: (val) => setState(() => selectedState = val),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _buildDropdown(
                  value: selectedDistrict,
                  items: districts,
                  hint: "District",
                  label: "District",
                  onChanged: (val) => setState(() => selectedDistrict = val),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdown(
                  value: selectedAgency,
                  items: agencies,
                  hint: "Agency",
                  label: "Agency",
                  onChanged: (val) => setState(() => selectedAgency = val),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date Range",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xff00695c),
          ),
        ),
        const SizedBox(height: 12),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _buildDateField(
                  controller: _startDateController,
                  label: "Start Date",
                  hint: "Start ...",
                  onTap: () => _selectDate(context, true),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDateField(
                  controller: _endDateController,
                  label: "End Date",
                  hint: "End D...",
                  onTap: () => _selectDate(context, false),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff26a69a),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              shadowColor: const Color(0xff004d40).withOpacity(0.3),
            ),
            onPressed: () {
              if (selectedDataset != null) {
                Get.to(() => const ResultScreen());
                _showSuccessDialog();
              } else {
                _showErrorSnackBar("Please select a dataset!");
              }
            },
            child: Text(
              "Generate Prediction",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xff26a69a).withOpacity(0.3),
              width: 2,
            ),
          ),
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xff26a69a),
              padding: const EdgeInsets.all(16),
            ),
            onPressed: _resetForm,
            icon: const Icon(Icons.refresh_rounded, size: 24),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required String hint,
    required String label,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(
        hint,
        style: GoogleFonts.poppins(
          color: const Color(0xff80cbc4),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: GoogleFonts.poppins(
              color: const Color(0xff004d40),
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          color: const Color(0xff00695c),
          fontWeight: FontWeight.w500,
        ),
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      dropdownColor: const Color(0xfff8fffe),
      style: GoogleFonts.poppins(color: const Color(0xff004d40)),
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required VoidCallback onTap,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      style: GoogleFonts.poppins(color: const Color(0xff004d40)),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: GoogleFonts.poppins(
          color: const Color(0xff00695c),
          fontWeight: FontWeight.w500,
        ),
        hintStyle: GoogleFonts.poppins(
          color: const Color(0xff80cbc4),
        ),
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        suffixIcon: const Icon(
          Icons.calendar_today_rounded,
          color: Color(0xff26a69a),
          size: 20,
        ),
      ),
    );
  }

  void _resetForm() {
    setState(() {
      selectedDataset = null;
      selectedCategory = "Admin";
      selectedState = null;
      selectedDistrict = null;
      selectedAgency = null;
      startDate = null;
      endDate = null;
    });

    _startDateController.clear();
    _endDateController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Form reset successfully!",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: const Color(0xff26a69a),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              message,
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.red[400],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xff26a69a).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_outline,
                size: 48,
                color: Color(0xff26a69a),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Prediction Generated!",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xff004d40),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Your water level prediction has been generated successfully.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xff00695c),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff26a69a),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "View Results",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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