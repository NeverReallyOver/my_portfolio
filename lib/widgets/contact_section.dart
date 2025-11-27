import 'package:flutter/material.dart';
import 'package:my_portfolio/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  
  bool _isHoveredSubmit = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'your.email@example.com', // Replace with your email
      query: 'subject=Portfolio Contact&body=Hello,',
    );
    
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 60 : 100,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
        ),
      ),
      child: Column(
        children: [
          // Section header
          Column(
            children: [
              Text(
                'Let\'s Work Together',
                style: AppTextStyles.sectionTitle.copyWith(
                  fontSize: isMobile ? 32 : 48,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 12),
              
              Text(
                'Have a project in mind? Let\'s create something amazing together!',
                style: AppTextStyles.body.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          
          const SizedBox(height: 60),
          
          // Contact content
          isMobile
              ? Column(
                  children: [
                    _buildContactInfo(isMobile),
                    const SizedBox(height: 40),
                    _buildContactForm(isMobile),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildContactInfo(isMobile),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      flex: 3,
                      child: _buildContactForm(isMobile),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get In Touch',
          style: AppTextStyles.subHeader.copyWith(
            fontSize: isMobile ? 28 : 32,
          ),
        ),
        
        const SizedBox(height: 24),
        
        Text(
          'I\'m always open to discussing new projects, creative ideas, or opportunities to be part of your vision.',
          style: AppTextStyles.body,
        ),
        
        const SizedBox(height: 40),
        
        // Contact methods
        _buildContactMethod(
          Icons.email,
          'Email',
          'your.email@example.com',
          () => _launchEmail(),
        ),
        const SizedBox(height: 20),
        _buildContactMethod(
          Icons.location_on,
          'Location',
          'Your City, Country',
          null,
        ),
        const SizedBox(height: 20),
        _buildContactMethod(
          Icons.schedule,
          'Availability',
          'Open to freelance projects',
          null,
        ),
        
        const SizedBox(height: 40),
        
        // Social links
        Text(
          'Follow Me',
          style: AppTextStyles.subHeader.copyWith(fontSize: 20),
        ),
        
        const SizedBox(height: 20),
        
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildSocialButton(
              Icons.code,
              'GitHub',
              () {}, // Add your GitHub URL
            ),
            _buildSocialButton(
              Icons.work,
              'LinkedIn',
              () {}, // Add your LinkedIn URL
            ),
            _buildSocialButton(
              Icons.link,
              'Portfolio',
              () {}, // Add your portfolio URL
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactMethod(IconData icon, String label, String value, VoidCallback? onTap) {
    return MouseRegion(
      cursor: onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.accent.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.accent, AppColors.accentPurple],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: AppTextStyles.subHeader.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                Icon(
                  Icons.arrow_forward,
                  color: AppColors.accent,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: AppColors.accent.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.accent, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.button.copyWith(
                  fontSize: 14,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactForm(bool isMobile) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.accent.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.1),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send Message',
              style: AppTextStyles.subHeader.copyWith(fontSize: 24),
            ),
            
            const SizedBox(height: 30),
            
            // Name field
            _buildTextField(
              controller: _nameController,
              label: 'Your Name',
              hint: 'John Doe',
              icon: Icons.person,
            ),
            
            const SizedBox(height: 20),
            
            // Email field
            _buildTextField(
              controller: _emailController,
              label: 'Your Email',
              hint: 'john@example.com',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            
            const SizedBox(height: 20),
            
            // Message field
            _buildTextField(
              controller: _messageController,
              label: 'Your Message',
              hint: 'Tell me about your project...',
              icon: Icons.message,
              maxLines: 5,
            ),
            
            const SizedBox(height: 30),
            
            // Submit button
            MouseRegion(
              onEnter: (_) => setState(() => _isHoveredSubmit = true),
              onExit: (_) => setState(() => _isHoveredSubmit = false),
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Implement form submission
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Thank you! I\'ll get back to you soon.',
                          style: AppTextStyles.body.copyWith(color: Colors.white),
                        ),
                        backgroundColor: AppColors.accent,
                      ),
                    );
                  }
                },
                child: AnimatedContainer(
                  duration: AppDurations.medium,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.accent, AppColors.accentPurple],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withOpacity(_isHoveredSubmit ? 0.5 : 0.3),
                        blurRadius: _isHoveredSubmit ? 25 : 20,
                        spreadRadius: _isHoveredSubmit ? 3 : 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Send Message',
                        style: AppTextStyles.button.copyWith(fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.send, size: 20, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body.copyWith(
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary.withOpacity(0.5),
            ),
            prefixIcon: Icon(icon, color: AppColors.accent, size: 20),
            filled: true,
            fillColor: AppColors.secondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.accent.withOpacity(0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.accent.withOpacity(0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.accent,
                width: 2,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
