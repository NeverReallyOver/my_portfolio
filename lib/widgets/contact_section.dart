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
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 80,
      ),
      color: AppColors.surface,
      child: Column(
        children: [
          // Section header
          Column(
            children: [
              Text(
                '// 06',
                style: AppTextStyles.accent.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Let's Work Together",
                style: AppTextStyles.sectionTitle.copyWith(
                  fontSize: isMobile ? 28 : 40,
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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
            boxShadow: AppShadows.card,
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppColors.accent, size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                const Icon(
                  Icons.open_in_new,
                  color: AppColors.textMuted,
                  size: 14,
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.textSecondary, size: 16),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.body.copyWith(
                  fontSize: 13,
                  color: AppColors.textSecondary,
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
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
          boxShadow: AppShadows.featured,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send a Message',
              style: AppTextStyles.subHeader.copyWith(fontSize: 20),
            ),

            const SizedBox(height: 24),
            
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
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: _isLoading ? null : () async {
                  if (_formKey.currentState!.validate()) {
                    await _submitForm();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _isLoading
                        ? AppColors.accent.withValues(alpha: 0.6)
                        : AppColors.accent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: _isLoading
                      ? const Center(
                          child: SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Send Message',
                              style: AppTextStyles.button.copyWith(
                                fontSize: 14,
                                color: AppColors.bg,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.send, size: 14, color: AppColors.bg),
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
              color: AppColors.textSecondary.withValues(alpha: 0.5),
            ),
            prefixIcon: Icon(icon, color: AppColors.accent, size: 20),
            filled: true,
            fillColor: AppColors.secondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.accent.withValues(alpha: 0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.accent.withValues(alpha: 0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
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
