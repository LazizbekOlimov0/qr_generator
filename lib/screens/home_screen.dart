import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<bool> selectedPattern = [true, false, false, false];
  String selectedColor = 'Blue';
  String selectedLogo = 'Logo 1';
  int selectedFormat = 0;

  final List<String> colors = ['Blue', 'Red', 'Green'];
  final List<String> logos = ['Logo 1', 'Logo 2', 'Logo 3'];

  TextEditingController controller = TextEditingController();
  TextEditingController patternController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  
  bool createdQR = false;

  @override
  Widget build(BuildContext context) {

    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: sizeHeight,
            width: sizeWidth,
            padding: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
            color: Color(0xFF0A043C),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                (createdQR) ? QrImageView(
                  data: controller.text,
                  version: QrVersions.auto,
                  backgroundColor: Colors.white,
                  size: 200,
                ) : Text("QR code not generated",style: TextStyle(color: Colors.white,fontSize: 32)),
                Row(
                  children: [
                    Text("PATTERN", style: TextStyle(color: Colors.white)),
                    Spacer(),
                    Icon(Icons.expand_more, color: Colors.white),
                  ],
                ),
                ToggleButtons(
                  isSelected: selectedPattern,
                  onPressed: (index) {
                    setState(() {
                      for (int i = 0; i < selectedPattern.length; i++) {
                        selectedPattern[i] = i == index;
                      }
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  selectedColor: Colors.white,
                  color: Colors.white38,
                  fillColor: Colors.indigo[700],
                  children: [
                    Icon(Icons.dashboard),
                    Icon(Icons.stairs),
                    Icon(Icons.ac_unit),
                    Icon(Icons.toys),
                  ],
                ),
                Row(
                  children: [
                    Text("COLOR", style: TextStyle(color: Colors.white)),
                    Spacer(),
                    DropdownButton<String>(
                      dropdownColor: Colors.indigo.shade500,
                      value: selectedColor,
                      icon: Icon(Icons.expand_more, color: Colors.white),
                      style: TextStyle(color: Colors.white),
                      underline: SizedBox(),
                      onChanged: (value) {
                        setState(() {
                          selectedColor = value!;
                        });
                      },
                      items: colors.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("LOGO", style: TextStyle(color: Colors.white)),
                    Spacer(),
                    DropdownButton<String>(
                      dropdownColor: Colors.indigo.shade500,
                      value: selectedLogo,
                      icon: Icon(Icons.expand_more, color: Colors.white),
                      style: TextStyle(color: Colors.white),
                      underline: SizedBox(),
                      onChanged: (value) {
                        setState(() {
                          selectedLogo = value!;
                        });
                      },
                      items: logos.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ToggleButtons(
                      borderRadius: BorderRadius.circular(10),
                      isSelected: [selectedFormat == 0, selectedFormat == 1, selectedFormat == 2],
                      onPressed: (index) {
                        setState(() {
                          selectedFormat = index;
                        });
                      },
                      fillColor: Colors.indigo.shade500,
                      selectedColor: Colors.white,
                      color: Colors.white38,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text("PNG"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text("JPG"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text("SVG"),
                        ),
                      ],
                    ),
                  ],
                ),
                TextField(
                  controller: controller,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "your mail address...",
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: (){
                    setState(() {
                      if(controller.text.isNotEmpty) createdQR = true;
                    });
                  },
                  height: sizeWidth * 0.12,
                  minWidth: sizeWidth,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  color: Colors.blue.shade400,
                  child: Text("Download Code",style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

