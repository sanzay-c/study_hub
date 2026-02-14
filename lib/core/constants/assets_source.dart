interface class SplashAssetsSource {
  static const String _baseUrl = 'assets/svg/splash_icon/';
  String bookIcon = '${_baseUrl}book.svg';
  String chatIcon = '${_baseUrl}chat.svg';
  String personIcon = '${_baseUrl}network.svg';
}

interface class AuthAssetsSource {
  static const String _baseUrl = 'assets/svg/auth_icons/';
  String authPersonIcon= '${_baseUrl}person_icon.svg';
  String mailIcon = '${_baseUrl}mail_icon.svg';
  String lockIcon = '${_baseUrl}lock_icon.svg';
}

interface class BottomNavAssetsSource {
  static const String _baseUrl = 'assets/svg/common_icons/';
  String homeIcon = '${_baseUrl}home.svg';
  String homeactiveIcon = '${_baseUrl}home_active.svg';

  String chatIcon = '${_baseUrl}chat_inactive.svg';
  String chatActiveIcon = '${_baseUrl}chat_active.svg';

  String notesIcon = '${_baseUrl}notes.svg';
  String notesActiveIcon = '${_baseUrl}note_active.svg';

  String socialIcon = '${_baseUrl}social_inactive.svg';
  String socialActiveIcon = '${_baseUrl}social_active.svg';

  String userIcon = '${_baseUrl}user_inactive.svg';
  String userActiveIcon = '${_baseUrl}user_active.svg';
}

interface class AppIconsSource {
  static const String _baseUrl = 'assets/svg/app_icons/';
  String cameraIcon = '${_baseUrl}camera.svg';
  String infoIcon = '${_baseUrl}info.svg';
  String logoutIcon = '${_baseUrl}logout_all.svg';
  String moonIcon = '${_baseUrl}moon.svg';
  String notificationIcon = '${_baseUrl}notification.svg';
  String privacyIcon = '${_baseUrl}privacy.svg';
  String sunIcon = '${_baseUrl}sun.svg';
  String userPersonIcon = '${_baseUrl}user_person.svg';
  String arrowForward = '${_baseUrl}arrow.svg';
  String sendIcon = '${_baseUrl}send_icon.svg';
  String paperClip = '${_baseUrl}paper_clip.svg';
  String uploadIcon = '${_baseUrl}upload_icon.svg';
  String closeIcon = '${_baseUrl}close_icon.svg';
  String addIcon = '${_baseUrl}add_icon.svg';
  String crownIcon = '${_baseUrl}crown.svg';
  String downloadIcon = '${_baseUrl}download_icon.svg';
  String personFollowIcon = '${_baseUrl}person_follow.svg';
  String personFollowingIcon = '${_baseUrl}person_following.svg';
  String noInternetIcon = '${_baseUrl}no_internet_icon.svg';
  String retryIcon = '${_baseUrl}retry_icon.svg';
  String messageIcon = '${_baseUrl}message_icon.svg';
  String calendarIcon = '${_baseUrl}calendar_icon.svg';
  String searchIcon = '${_baseUrl}search_icon.svg';
}

class AssetsSource {
  AssetsSource._();
  
  static SplashAssetsSource get splashAssetsSource => SplashAssetsSource();
  static AuthAssetsSource get authAssetsSource => AuthAssetsSource();
  static BottomNavAssetsSource get bottomNavAssetsSource => BottomNavAssetsSource();
  static AppIconsSource get appIcons => AppIconsSource();
}

// Usage:
// AssetsSource.social.facebook.logoIcon