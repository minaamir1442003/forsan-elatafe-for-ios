import 'package:flutter/material.dart';
import 'package:forsan_eltafe/core/appcolors.dart';
import 'package:forsan_eltafe/features/MedicalUnit/screen/MedicalUnitPage.dart';
import 'package:forsan_eltafe/features/Profile/screen/ProfilePage.dart';
import 'package:forsan_eltafe/features/Resort/screen/ResortPage.dart';
import 'package:forsan_eltafe/features/home/screen/home.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int initialIndex;  // 👈 أضف هذا
  
  const CustomBottomNavigationBar({
    super.key,
    this.initialIndex = 0,  // القيمة الافتراضية 0 (الرئيسية)
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int _selectedIndex;

  final List<Widget> _screens = [
    HomePage(),
    MedicalUnitPage(),
    ResortPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;  // 👈 استخدم القيمة اللي جات من الخارج
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 25,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNavItem(Icons.person, "حسابي", 3),
                    _buildNavItem(Icons.villa, "المنتجع", 2),
                    _buildNavItem(Icons.local_hospital, "الوحدة", 1),
                    _buildNavItem(Icons.home, "الرئيسية", 0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 5),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 4,
            width: isSelected ? 40 : 0,
            decoration: BoxDecoration(
              color: Appcolors.accentColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 10),
          AnimatedScale(
            scale: isSelected ? 1.1 : 1,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              icon,
              size: 28,
              color: isSelected
                  ? Appcolors.primaryColor
                  : Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              fontFamily: 'Cairo',
              color: isSelected
                  ? Appcolors.primaryColor
                  : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:forsan_eltafe/core/appcolors.dart';
// import 'package:forsan_eltafe/features/MedicalUnit/screen/MedicalUnitPage.dart';
// import 'package:forsan_eltafe/features/Profile/screen/ProfilePage.dart';
// import 'package:forsan_eltafe/features/Resort/screen/ResortPage.dart';
// import 'package:forsan_eltafe/features/home/screen/home.dart';

// class CustomBottomNavigationBar extends StatefulWidget {
//   final int initialIndex;

//   const CustomBottomNavigationBar({
//     super.key,
//     this.initialIndex = 0,
//   });

//   @override
//   State<CustomBottomNavigationBar> createState() =>
//       _CustomBottomNavigationBarState();
// }

// class _CustomBottomNavigationBarState
//     extends State<CustomBottomNavigationBar> {
//   late int _selectedIndex;

//   final List<Widget> _screens = [
//     HomePage(),
//     MedicalUnitPage(),
//     ResortPage(),
//     ProfilePage(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _selectedIndex = widget.initialIndex;
//   }

//   void _onTap(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       /// 🔹 Screens
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: _screens,
//       ),

//       /// 🔥 LUXURY BOTTOM BAR
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//         decoration: BoxDecoration(
//           color: Appcolors.primaryColor, // 👈 dark navy background
//           borderRadius: BorderRadius.circular(30),
//           boxShadow: [
//             BoxShadow(
//               color: Appcolors.primaryColor.withOpacity(0.25),
//               blurRadius: 25,
//               offset: const Offset(0, 10),
//             ),
//           ],
//         ),
      
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildItem(Icons.home, "الرئيسية", 0),
//             _buildItem(Icons.local_hospital, "الوحدة", 1),
//             _buildItem(Icons.villa, "المنتجع", 2),
//             _buildItem(Icons.person, "حسابي", 3),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildItem(IconData icon, String label, int index) {
//     bool isSelected = _selectedIndex == index;

//     return GestureDetector(
//       onTap: () => _onTap(index),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 250),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? Appcolors.accentColor.withOpacity(0.15)
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               icon,
//               size: 26,
//               color: isSelected
//                   ? Appcolors.accentColor
//                   : Colors.white.withOpacity(0.7),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 11,
//                 fontWeight: FontWeight.w600,
//                 fontFamily: 'Cairo',
//                 color: isSelected
//                     ? Appcolors.accentColor
//                     : Colors.white.withOpacity(0.6),
//               ),
//             ),

//             const SizedBox(height: 4),

//             /// 🔥 indicator ذهبي تحت الأيقونة
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 250),
//               height: 3,
//               width: isSelected ? 18 : 0,
//               decoration: BoxDecoration(
//                 color: Appcolors.accentColor,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:forsan_eltafe/core/appcolors.dart';
// import 'package:forsan_eltafe/features/MedicalUnit/screen/MedicalUnitPage.dart';
// import 'package:forsan_eltafe/features/Profile/screen/ProfilePage.dart';
// import 'package:forsan_eltafe/features/Resort/screen/ResortPage.dart';
// import 'package:forsan_eltafe/features/home/screen/home.dart';

// class CustomBottomNavigationBar extends StatefulWidget {
//   final int initialIndex;

//   const CustomBottomNavigationBar({
//     super.key,
//     this.initialIndex = 0,
//   });

//   @override
//   State<CustomBottomNavigationBar> createState() =>
//       _CustomBottomNavigationBarState();
// }

// class _CustomBottomNavigationBarState
//     extends State<CustomBottomNavigationBar> {
//   late int _selectedIndex;

//   final List<Widget> _screens = [
//     HomePage(),
//     MedicalUnitPage(),
//     ResortPage(),
//     ProfilePage(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _selectedIndex = widget.initialIndex;
//   }

//   void _onTap(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfff6f6f6),

//       body: IndexedStack(
//         index: _selectedIndex,
//         children: _screens,
//       ),

//       /// 🔥 MODERN SEGMENTED NAV BAR
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(bottom: 3.0),
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//           padding: const EdgeInsets.all(6),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(40),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.08),
//                 blurRadius: 15,
//                 offset: const Offset(0, 6),
//               ),
//             ],
//           ),
        
//           child: Row(
//             children: [
//               _segment(Icons.home, "الرئيسية", 0),
//               _segment(Icons.local_hospital, "الوحدة", 1),
//               _segment(Icons.villa, "المنتجع", 2),
//               _segment(Icons.person, "حسابي", 3),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _segment(IconData icon, String label, int index) {
//     bool selected = _selectedIndex == index;

//     return Expanded(
//       child: GestureDetector(
//         onTap: () => _onTap(index),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 250),
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           decoration: BoxDecoration(
//             color: selected
//                 ? Appcolors.accentColor.withOpacity(0.15)
//                 : Colors.transparent,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 icon,
//                 size: 24,
//                 color: selected
//                     ? Appcolors.accentColor
//                     : Colors.grey.shade500,
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Cairo',
//                   color: selected
//                       ? Appcolors.primaryColor
//                       : Colors.grey.shade500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }