# VBC-WS Church App 🙏

> A modern, scalable Flutter application for Vietnamese Baptist Church in Winston-Salem, connecting members with events, discipleship classes, and community resources.

## 🎯 What Makes This Different

Most church apps are static PDFs wrapped in mobile UI. **This one is alive**—powered by Firebase, updated in real-time, and built for elderly Vietnamese speakers who need simplicity, not complexity.

## ✨ Key Features

### Dynamic Event Management
- **Real-time updates** from Firebase Firestore—no app updates needed to change schedules
- Events automatically sorted and filtered by active status
- Beautiful image galleries from Firebase Storage
- Vietnamese date formatting (T6, CN, etc.)

### Three-Level Discipleship System
- **Courses** → **Locations** → **Classes** with intelligent grouping
- Classes auto-group by city from location data
- One-tap contact (phone/email detection with `url_launcher`)
- Only shows locations with actual classes—no empty states

### Smart Architecture
```
├── domain/     # Business logic (pure Dart, no Firebase)
├── data/       # Firebase integration (models, repositories)  
└── presentation/ # UI components (pages, widgets)
```
**Why it matters**: Easy to test, maintain, and scale. Change Firebase to Supabase? Touch one layer.

### Responsive Design
- **Adaptive AppBar**: 4 icons on desktop → 2 icons on tablet → menu on mobile
- No overflow errors on small screens (tested down to 180px width)
- Works perfectly for elderly users on any device

### Smart Image Loading
- Automatically detects Firebase URLs vs local assets
- Caching with `cached_network_image` for performance
- Graceful fallbacks when images fail
- CORS-configured Firebase Storage

## 🔒 Security

**Public Read, Admin Write** model:
- Anyone can view events and classes
- Only authenticated admins (email-based) can modify data
- Data validation in Firestore rules (type checking, required fields)
- No sensitive data exposed client-side

## 🌍 Built For Vietnamese Speakers

- Time formatting: `T6, 6:00pm – 7:00pm` (Vietnamese day abbreviations)
- UI text in Vietnamese (Lịch Nhóm, Môn Đồ Hóa, etc.)
- Large, clear fonts for elderly users
- Intuitive navigation with visual cards

## 🚀 Tech Stack

- **Flutter 3.x** - Cross-platform (iOS, Android, Web)
- **Firebase Firestore** - Real-time database with offline support
- **Firebase Storage** - Image hosting with CDN
- **Clean Architecture** - Separation of concerns, SOLID principles
- **Material Design 3** - Modern, accessible UI

## 📦 Project Structure

```
lib/
├── core/
│   ├── constants/     # Firebase field names, centralized
│   └── utils/         # Time formatters, image helpers
├── data/
│   ├── models/        # Firebase serialization
│   └── repositories/  # Data access layer
├── domain/
│   ├── entities/      # Pure business objects
│   └── repositories/  # Abstract contracts
└── presentation/
    ├── pages/         # Screens (Events, Discipleship, Home)
    └── widgets/       # Reusable components (SmartImage, modals)
```

## 🔥 What Problem Did This Solve?

**Before**: Church staff manually updating printed schedules, members missing events, confusion about class times

**After**: 
- ✅ Staff updates Firebase once → all members see it instantly
- ✅ Members tap a contact to call/email directly
- ✅ Classes grouped clearly by location (no more "Which Wake Forest location?")
- ✅ Old hardware supported (responsive design, image optimization)

## 🎨 Design Philosophy

1. **Elder-first**: Large touch targets, high contrast, clear hierarchy
2. **Offline-ready**: Firestore persistence—works without internet after first load
3. **Maintainable**: Change a feature? Touch one file, not ten
4. **Scalable**: Add prayer requests, sermons, giving—same patterns

## 📱 Screenshots

*Events page with Firebase-powered real-time updates*  
*Discipleship classes organized by location with one-tap contact*  
*Responsive home page working on mobile, tablet, and desktop*

## 🛠️ Setup

```bash
# Clone and install dependencies
git clone <repo-url>
cd church_app
flutter pub get

# Configure Firebase
flutterfire configure

# Run
flutter run
```

See [Firebase Setup Guide](docs/firebase-setup.md) for detailed Firestore rules and structure.

## 📋 Schema-Driven Development

Data models are defined in JSON Schema format in `/schemas/`. See [Schema Development Guide](docs/schema-development.md) for:
- How to define new schemas
- Running code generators
- Naming conventions
- Extending generated models

## 📈 What's Next?

- [ ] Push notifications for event reminders
- [ ] Prayer request submission system
- [ ] Online giving integration
- [ ] Sermon archive with audio player
- [ ] Admin dashboard (web-only) for content management

***

**Built with ❤️ for Vietnamese Baptist Church, Winston-Salem**  
*Empowering community through technology*