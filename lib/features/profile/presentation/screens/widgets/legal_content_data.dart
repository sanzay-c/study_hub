import 'package:study_hub/features/profile/presentation/legal_content_screen.dart';

class LegalContentData {
  static const String termsLastUpdated = 'April 18, 2026';
  static const String privacyLastUpdated = 'April 18, 2026';

  static const List<LegalSection> termsSections = [
    LegalSection(
      heading: '1. Acceptance of Terms',
      body:
          'By creating an account or using Study Hub, you agree to be bound by these Terms. Study Hub is a platform designed for students to collaborate, share resources, and manage study groups.',
    ),
    LegalSection(
      heading: '2. Academic Integrity',
      body:
          'Study Hub is committed to fostering a learning environment. You agree not to use the platform for academic dishonesty, including but not limited to sharing exam answers, plagiarism, or any activity that violates your institution\'s code of conduct.',
    ),
    LegalSection(
      heading: '3. User-Generated Content',
      body:
          'You retain ownership of the study notes and materials you upload. However, by uploading content, you grant Study Hub a non-exclusive, royalty-free license to host, display, and distribute that content to other users of the platform.',
    ),
    LegalSection(
      heading: '4. Community Guidelines',
      body:
          'When participating in Group Chats or Social features, you must remain respectful. Harassment, hate speech, or sharing of copyrighted educational material without permission is strictly prohibited.',
    ),
    LegalSection(
      heading: '5. Account Security',
      body:
          'You are responsible for protecting your password. If you choose to delete your account, you understand that this action is permanent and your data cannot be recovered.',
    ),
    LegalSection(
      heading: '6. Limitation of Liability',
      body:
          'Study Hub is provided "as is". We are not responsible for the accuracy of study materials uploaded by users or for any academic consequences resulting from the use of the app.',
    ),
  ];

  static const List<LegalSection> privacySections = [
    LegalSection(
      heading: '1. Information Collection',
      body:
          'We collect your username, email, full name, and any profile images you upload. We also collect the study materials you share to enable the core functionality of the app.',
    ),
    LegalSection(
      heading: '2. Push Notifications',
      body:
          'We use FCM (Firebase Cloud Messaging) tokens to send you real-time updates about group messages and social interactions. You can opt-out at any time in settings.',
    ),
    LegalSection(
      heading: '3. Data Storage & Usage',
      body:
          'Your data is stored securely in our cloud database. We use this information to personalize your study feed, manage your groups, and allow other students to follow your academic journey.',
    ),
    LegalSection(
      heading: '4. Account Deletion',
      body:
          'We respect your right to privacy. When you delete your account, we perform a hard delete of your user profile and associated personal data from our active databases.',
    ),
    LegalSection(
      heading: '5. Cookies and Caching',
      body:
          'We use local storage and caching on your device to ensure a smooth, fast experience, especially when accessing your study notes and chat history offline.',
    ),
    LegalSection(
      heading: '6. Policy Updates',
      body:
          'We may update this policy to reflect changes in our app features. We will notify you of any significant changes via the email provided in your account.',
    ),
  ];
}