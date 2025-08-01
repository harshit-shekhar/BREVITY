import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'dart:ui';
import 'package:brevity/controller/cubit/theme/theme_cubit.dart';
import 'package:brevity/models/theme_model.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Widget _buildGlassContainer({
    required BuildContext context,
    required Widget child,
    double? opacity,
    EdgeInsets? margin,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final baseColor = isDarkMode ? Colors.white : Colors.black;

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: theme.cardColor.withOpacity(isDarkMode ? 0.5 : 0.8),
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        border: Border.all(color: baseColor.withOpacity(0.12), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: child,
        ),
      ),
    );
  }

  void _copyToClipboard(String text, String type) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$type copied to clipboard'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green.withOpacity(0.8),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.read<ThemeCubit>().currentTheme;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              appTheme.primaryColor.withOpacity(0.2),
              theme.colorScheme.background,
              theme.colorScheme.background,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildAppBar(appTheme),
                const Gap(24),
                _buildContactSection(appTheme),
                const Gap(20),
                _buildFooter(appTheme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(AppTheme appTheme) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: _buildGlassContainer(
        context: context,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Theme.of(context).colorScheme.onSurface,
                size: 20,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),
            const Gap(8),
            Text(
              'Contact Us',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection(AppTheme appTheme) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: _buildGlassContainer(
        context: context,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: appTheme.primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.support_agent_rounded,
                    color: appTheme.primaryColor,
                    size: 20,
                  ),
                ),
                const Gap(12),
                Text(
                  'Get in Touch',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Gap(16),
            Text(
              'For support, feedback, or questions about the app, reach out to our development team.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                height: 1.4,
              ),
            ),
            const Gap(24),
            _buildContactCard(
              name: 'Samarth Sharma',
              role: 'Co-Developer',
              email: 'saysamarth26@gmail.com',
              phone: '+91 8800894252',
              theme: appTheme,
            ),
            const Gap(16),
            _buildContactCard(
              name: 'Yash',
              role: 'Co-Developer',
              email: 'yashmalihan3@gmail.com',
              phone: '+91 8882462047',
              theme: appTheme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required String name,
    required String role,
    required String email,
    required String phone,
    required AppTheme theme,
  }) {
    final uiTheme = Theme.of(context);
    final isDarkMode = uiTheme.brightness == Brightness.dark;
    final baseColor = isDarkMode ? Colors.white : Colors.black;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: uiTheme.colorScheme.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: baseColor.withOpacity(0.08), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: theme.primaryColor.withOpacity(0.2),
                child: Text(
                  name.split(' ').map((n) => n[0]).take(2).join(),
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: uiTheme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      role,
                      style: TextStyle(
                        color: theme.primaryColor.withOpacity(0.8),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(16),
          _buildContactItem(
            icon: Icons.email_outlined,
            label: 'Email',
            value: email,
            onTap: () => _copyToClipboard(email, 'Email'),
            theme: theme,
          ),
          const Gap(8),
          _buildContactItem(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: phone,
            onTap: () => _copyToClipboard(phone, 'Phone number'),
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
    required AppTheme theme,
  }) {
    final uiTheme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Icon(icon, color: theme.primaryColor.withOpacity(0.7), size: 16),
            const Gap(8),
            Text(
              label,
              style: uiTheme.textTheme.bodyMedium?.copyWith(
                color: uiTheme.colorScheme.onSurface.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(8),
            Expanded(
              child: Text(
                value,
                style: uiTheme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            Icon(
              Icons.copy,
              color: theme.primaryColor.withOpacity(0.5),
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(AppTheme appTheme) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: _buildGlassContainer(
        context: context,
        padding: const EdgeInsets.all(16),
        opacity: 0.04,
        child: Row(
          children: [
            Icon(
              Icons.schedule_outlined,
              color: appTheme.primaryColor.withOpacity(0.7),
              size: 16,
            ),
            const Gap(8),
            Expanded(
              child: Text(
                'We typically respond within 1-2 business days',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
