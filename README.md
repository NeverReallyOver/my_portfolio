# Flutter Developer Portfolio

A stunning, modern portfolio website built with Flutter for showcasing your Flutter development skills and attracting freelance clients.

## 🎨 Features

- **Modern Design**: Eye-catching design with gradient colors, glassmorphism effects, and smooth animations
- **Fully Responsive**: Works seamlessly on mobile, tablet, and desktop
- **Animated Components**: Floating elements, particle effects, and micro-interactions
- **Customizable**: Easy-to-update data structures for personalizing content
- **Flutter Web Ready**: Optimized for web deployment
- **Clean Architecture**: Well-organized code structure for easy maintenance

## 🚀 Sections

1. **Hero Section**: Full-screen introduction with animated background and floating elements
2. **About Me**: Showcase your Flutter expertise with beautiful cards
3. **Skills**: Interactive skill cards with proficiency levels and category filters
4. **Experience**: Timeline-based experience section with placeholders for growth
5. **Services**: Highlight your Flutter development services
6. **Contact**: Functional contact form with social links

## 📝 Customization Guide

### 1. Update Personal Information

Edit `lib/data/portfolio_data.dart`:

```dart
static const String name = 'Your Name Here';
static const String email = 'your.email@example.com';
static const String location = 'Your City, Country';
// ... update other fields
```

### 2. Update Hero Section

Edit `lib/widgets/hero_section.dart`:
- Line 212: Update your name
- Line 225: Update location and availability

### 3. Add Your Profile Image

Replace the placeholder in hero section:
- Add your profile image to `assets/images/profile.png`
- Update line 382 in `hero_section.dart`

### 4. Update Skills

Edit `lib/widgets/skills_section.dart`:
- Lines 12-21: Add/modify your skills
- Adjust proficiency levels (0.0 to 1.0)
- Add new categories as needed

### 5. Update Experience

Edit `lib/widgets/experience_section.dart`:
- Lines 38-85: Update with your actual experience
- Remove placeholder entries
- Add new experiences as your career grows

### 6. Update Services

Edit `lib/widgets/education_section.dart`:
- Modify service offerings to match what you provide
- Update pricing or features

### 7. Update Contact Information

Edit `lib/widgets/contact_section.dart`:
- Line 29: Update your email
- Lines 170-200: Add your social media links

### 8. Update Colors (Optional)

Edit `lib/constants.dart`:
- Modify color values to match your brand
- Adjust text styles and sizes

## 🔧 Running the Project

### Development
```bash
flutter run -d chrome
```

### Build for Web
```bash
flutter build web --release
```

## 📦 Dependencies

- `flutter` - Flutter SDK
- `google_fonts` - Beautiful Google Fonts
- `animated_text_kit` - Text animations
- `url_launcher` - Launch URLs and emails

## 🎯 Future Enhancements (Placeholders Ready)

- [ ] Add portfolio projects gallery
- [ ] Add client testimonials
- [ ] Add blog section
- [ ] Add certifications
- [ ] Add downloadable resume
- [ ] Add dark/light mode toggle
- [ ] Add language switcher
- [ ] Add analytics integration

## 📱 Mobile Menu

The mobile menu is currently a TODO. Implement it by:
1. Creating a drawer or modal menu
2. Adding navigation links to sections
3. Updating the menu icon handler in `hero_section.dart`

## 🌐 Deployment

### GitHub Pages
1. Build: `flutter build web --release`
2. Deploy the `build/web` folder to GitHub Pages

### Firebase Hosting
```bash
firebase init hosting
flutter build web --release
firebase deploy
```

### Netlify/Vercel
- Connect your repository
- Set build command: `flutter build web --release`
- Set publish directory: `build/web`

## 💡 Tips

1. **Images**: Add your images to `assets/images/` and update `pubspec.yaml`
2. **Animations**: Adjust animation speeds in `constants.dart` (AppDurations)
3. **SEO**: Update `web/index.html` with proper meta tags
4. **Performance**: Use `const` constructors for better performance
5. **Testing**: Test on multiple devices and browsers

## 📸 Screenshots

Add screenshots of your portfolio here once deployed!

## 🤝 Contributing

This is a personal portfolio template. Feel free to fork and customize for your own use!

## 📄 License

This project is open source and available for personal and commercial use.

## ✨ Credits

Built with ❤️ using Flutter

---

**Ready to impress clients? Update your info and deploy your portfolio today!** 🚀
