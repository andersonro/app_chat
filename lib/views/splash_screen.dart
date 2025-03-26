import 'package:app_chat/models/user_model.dart';
import 'package:app_chat/views/login_screen.dart';
import 'package:app_chat/views/room_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_chat/repositories/user_logado_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation1;
  late Animation<double> _scaleAnimation2;
  late Animation<double> _scaleAnimation3;

  bool _icon1Visible = false;
  bool _icon2Visible = false;
  bool _icon3Visible = false;
  final double _iconSize = 80.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _scaleAnimation1 = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );

    _scaleAnimation2 = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );

    _scaleAnimation3 = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );

    _startAnimations();
    _loginScreen();
  }

  _loginScreen() async {
    UserLogadoRepository userLogadoRepository = UserLogadoRepository();
    UserModel? userModel = await userLogadoRepository.getUserLogado();
    Widget page =
        userModel != null
            ? RoomSelectionScreen(userModel: userModel)
            : LoginScreen();
    Future.delayed(Duration(seconds: 6), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _icon1Visible = true;
      _animationController.reset();
      _animationController.forward();
    });

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _icon2Visible = true;
      _animationController.reset();
      _animationController.forward();
    });

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _icon3Visible = true;
      _animationController.reset();
      _animationController.forward();
    });
  }

  Widget _buildChatBubble(
    Widget child,
    Animation<double> animation,
    bool visible,
    double padding,
  ) {
    return ScaleTransition(
      scale: animation,
      child: AnimatedOpacity(
        opacity: visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: Colors.blue[300],
            borderRadius: BorderRadius.circular(20),
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              _buildChatBubble(
                Icon(Icons.message, size: _iconSize, color: Colors.white),
                _scaleAnimation1,
                _icon1Visible,
                8,
              ),
              _buildChatBubble(
                Icon(Icons.message, size: _iconSize, color: Colors.white),
                _scaleAnimation2,
                _icon2Visible,
                22,
              ),
              _buildChatBubble(
                Icon(Icons.message, size: _iconSize, color: Colors.white),
                _scaleAnimation3,
                _icon3Visible,
                8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
