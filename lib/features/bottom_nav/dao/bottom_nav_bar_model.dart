import 'package:study_hub/core/constants/assets_source.dart';

class BottomNavBarModel {
  final String label;
  final String activeImage;
  final String inactiveImage;
  final String slug;

  BottomNavBarModel({
    required this.label,
    required this.activeImage,
    required this.inactiveImage,
    required this.slug,
  });

  factory BottomNavBarModel.fromJson(Map<String, dynamic> json) {
    return BottomNavBarModel(
      label: json['label'],
      activeImage: json['activeImage'],
      inactiveImage: json['inactiveImage'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'activeImage': activeImage,
      'inactiveImage': inactiveImage,
      'slug': slug,
    };
  }

  BottomNavBarModel copyWith({
    String? label,
    String? activeImage,
    String? inactiveImage,
    String? iconPath,
    String? slug,
  }) {
    return BottomNavBarModel(
      label: label ?? this.label,
      activeImage: activeImage ?? this.activeImage,
      inactiveImage: inactiveImage ?? this.inactiveImage,
      slug: slug ?? this.slug,
    );
  }
}

List<BottomNavBarModel> bottomNavModel = [
  BottomNavBarModel(
    label: "Groups",
    activeImage: AssetsSource.bottomNavAssetsSource.homeactiveIcon,
    inactiveImage: AssetsSource.bottomNavAssetsSource.homeIcon,
    slug: 'Groups',
  ),
  BottomNavBarModel(
    label: "Chat",
    activeImage: AssetsSource.bottomNavAssetsSource.chatActiveIcon,
    inactiveImage: AssetsSource.bottomNavAssetsSource.chatIcon,
    slug: 'Chat',
  ),
  BottomNavBarModel(
    label: "Notes",
    activeImage: AssetsSource.bottomNavAssetsSource.notesActiveIcon,
    inactiveImage: AssetsSource.bottomNavAssetsSource.notesIcon,
    slug: 'Notes',
  ),
  BottomNavBarModel(
    label: "Social",
    activeImage: AssetsSource.bottomNavAssetsSource.socialActiveIcon,
    inactiveImage: AssetsSource.bottomNavAssetsSource.socialIcon,
    slug: 'Social',
  ),
  BottomNavBarModel(
    label: "Profile",
    activeImage: AssetsSource.bottomNavAssetsSource.userActiveIcon,
    inactiveImage: AssetsSource.bottomNavAssetsSource.userIcon,
    slug: 'Profile',
  ),
];
