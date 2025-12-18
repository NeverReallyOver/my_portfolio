import 'package:flutter/material.dart';
import 'package:my_portfolio/constants.dart';
import 'package:my_portfolio/data/portfolio_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  bool _isLoading = false;
  
  // Formspree endpoint - Replace with your Formspree form ID
  // Get your free form ID from https://formspree.io
  // Example: 'https://formspree.io/f/YOUR_FORM_ID'
  static const String _formspreeEndpoint = 'https://formspree.io/f/xbdrrqbr';

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
      path: PortfolioData.email,
      query: 'subject=Portfolio Contact&body=Hello,',
    );
    
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
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
                'Let\'s Build Something Amazing',
                style: AppTextStyles.sectionTitle.copyWith(
                  fontSize: isMobile ? 32 : 48,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 12),
              
              Text(
                'Ready to bring your idea to life? Get in touch and let\'s discuss your project!',
                style: AppTextStyles.body.copyWith(fontSize: isMobile ? 16 : 18),
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
          'I\'m available for freelance projects and always excited to work on new challenges. Whether you need a complete app, UI/UX design, or consultation, I\'m here to help bring your vision to reality.',
          style: AppTextStyles.body,
        ),
        
        const SizedBox(height: 40),
        
        // Contact methods
        _buildContactMethod(
          Icons.email,
          'Email',
          PortfolioData.email,
          () => _launchEmail(),
        ),
        const SizedBox(height: 20),
        _buildContactMethod(
          Icons.location_on,
          'Location',
          PortfolioData.location,
          null,
        ),
        const SizedBox(height: 20),
        _buildContactMethod(
          Icons.schedule,
          'Availability',
          PortfolioData.availability,
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
              () => _launchUrl(PortfolioData.githubUrl),
            ),
            _buildSocialButton(
              Icons.work,
              'LinkedIn',
              () => _launchUrl(PortfolioData.linkedinUrl),
            ),
            // _buildSocialButton(
            //   Icons.link,
            //   'Instagram',
            //   () => _launchUrl(PortfolioData.portfolioUrl),
            // ),
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
                onTap: _isLoading ? null : () async {
                  if (_formKey.currentState!.validate()) {
                    await _submitForm();
                  }
                },
                child: AnimatedContainer(
                  duration: AppDurations.medium,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    gradient: _isLoading 
                        ? null 
                        : LinearGradient(
                            colors: [AppColors.accent, AppColors.accentPurple],
                          ),
                    color: _isLoading ? AppColors.accent.withOpacity(0.7) : null,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withOpacity(_isHoveredSubmit ? 0.5 : 0.3),
                        blurRadius: _isHoveredSubmit ? 25 : 20,
                        spreadRadius: _isHoveredSubmit ? 3 : 2,
                      ),
                    ],
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Row(
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
            if (keyboardType == TextInputType.emailAddress) {
              if (!value.contains('@') || !value.contains('.')) {
                return 'Please enter a valid email';
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  Future<void> _submitForm() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Option 1: Using Formspree (Free - 50 submissions/month)
      // Replace YOUR_FORM_ID with your actual Formspree form ID from https://formspree.io
      final response = await http.post(
        Uri.parse(_formspreeEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': _nameController.text,
          'email': _emailController.text,
          'message': _messageController.text,
          '_subject': 'Portfolio Contact Form - ${_nameController.text}',
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Message sent successfully! I\'ll get back to you soon.',
                      style: AppTextStyles.body.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 4),
              behavior: SnackBarBehavior.floating,
            ),
          );
          
          // Clear form
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
        }
      } else {
        // Fallback to mailto if Formspree fails
        await _sendViaMailto();
      }
    } catch (e) {
      // Fallback to mailto if there's an error
      await _sendViaMailto();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _sendViaMailto() async {
    // Fallback: Use mailto link
    final subject = Uri.encodeComponent('Portfolio Contact - ${_nameController.text}');
    final body = Uri.encodeComponent(
      'Name: ${_nameController.text}\n'
      'Email: ${_emailController.text}\n\n'
      'Message:\n${_messageController.text}',
    );
    
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: PortfolioData.email,
      query: 'subject=$subject&body=$body',
    );
    
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Opening email client...',
              style: AppTextStyles.body.copyWith(color: Colors.white),
            ),
            backgroundColor: AppColors.accent,
          ),
        );
      }
    }
  }
}
