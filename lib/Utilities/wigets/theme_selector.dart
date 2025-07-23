import 'package:ecommerce_app/Utilities/Theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSelector extends StatefulWidget {
  @override
  _ThemeSelectorState createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector>
    with TickerProviderStateMixin {
  late String selected;
  late AnimationController _animationController;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  final List<ThemeOption> options = [
    ThemeOption(
      name: "Light",
      icon: Icons.light_mode,
      lightGradient: LinearGradient(
        colors: [Color(0xFFFFD54F), Color(0xFFFF8A65)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      darkGradient: LinearGradient(
        colors: [Color(0xFFFFB74D), Color(0xFFFF7043)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    ThemeOption(
      name: "System",
      icon: Icons.settings_system_daydream,
      lightGradient: LinearGradient(
        colors: [Color(0xFF64B5F6), Color(0xFF42A5F5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      darkGradient: LinearGradient(
        colors: [Color(0xFF5C6BC0), Color(0xFF3F51B5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    ThemeOption(
      name: "Dark",
      icon: Icons.dark_mode,
      lightGradient: LinearGradient(
        colors: [Color(0xFF5C6BC0), Color(0xFF3F51B5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      darkGradient: LinearGradient(
        colors: [Color(0xFF7986CB), Color(0xFF5C6BC0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
    getTheme();
  }
getTheme()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selected = await prefs.getString("theme")??"System";
    setState(() {

    });
}
  @override
  void dispose() {
    _animationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  Alignment _getAlignment() {
    switch (selected) {
      case "Light":
        return Alignment.centerLeft;
      case "System":
        return Alignment.center;
      case "Dark":
        return Alignment.centerRight;
      default:
        return Alignment.center;
    }
  }

  LinearGradient _getSelectedGradient(bool isDark) {
    ThemeOption option = options.firstWhere(
      (option) => option.name == selected,
    );
    return isDark ? option.darkGradient : option.lightGradient;
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            height: 70,
            width: 290,
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: isDark ? Color(0xFF2C2C2C) : Colors.white,
              border: isDark
                  ? Border.all(color: Color(0xFF404040), width: 1)
                  : null,
              boxShadow: isDark
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: Offset(0, 8),
                      ),
                      BoxShadow(
                        color: Color(0xFF3A3A3A),
                        blurRadius: 15,
                        spreadRadius: -5,
                        offset: Offset(0, -8),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: Offset(0, 8),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 15,
                        spreadRadius: -5,
                        offset: Offset(0, -8),
                      ),
                    ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Animated background highlight with gradient
                AnimatedAlign(
                  alignment: _getAlignment(),
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOutCubic,
                  child: Container(
                    width: 90,
                    height: 58,
                    decoration: BoxDecoration(
                      gradient: _getSelectedGradient(isDark),
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color: _getSelectedGradient(
                            isDark,
                          ).colors.first.withOpacity(0.4),
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
                // Row of option buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: options
                      .map((option) => _buildOption(option, isDark))
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOption(ThemeOption option, bool isDark) {
    bool isSelected = selected == option.name;

    return GestureDetector(
      onTap: () {
        _scaleController.forward().then((_) {
          _scaleController.reverse();
        });

        setState(() {
          selected = option.name;
        });
context.read<ThemeProvider>().changeTheme(currentTheme: selected);
        // Haptic feedback
         HapticFeedback.lightImpact();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 90,
        height: 58,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              child: Icon(
                option.icon,
                size: isSelected ? 22 : 18,
                color: isSelected
                    ? Colors.white
                    : isDark
                    ? Color(0xFF9E9E9E)
                    : Color(0xFF6C757D),
              ),
            ),
            SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 300),
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: isSelected ? 12 : 10,
                color: isSelected
                    ? Colors.white
                    : isDark
                    ? Color(0xFF9E9E9E)
                    : Color(0xFF6C757D),
                letterSpacing: 0.5,
              ),
              child: Text(option.name),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeOption {
  final String name;
  final IconData icon;
  final LinearGradient lightGradient;
  final LinearGradient darkGradient;

  ThemeOption({
    required this.name,
    required this.icon,
    required this.lightGradient,
    required this.darkGradient,
  });
}
