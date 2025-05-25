
import 'dart:convert';

BasicSettingsInfoModel basicSettingsInfoModelFromJson(String str) =>
    BasicSettingsInfoModel.fromJson(json.decode(str));

String basicSettingsInfoModelToJson(BasicSettingsInfoModel data) =>
    json.encode(data.toJson());

class BasicSettingsInfoModel {
  final Message message;
  final Data data;
  final String type;

  BasicSettingsInfoModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory BasicSettingsInfoModel.fromJson(Map<String, dynamic> json) =>
      BasicSettingsInfoModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
        "type": type,
      };
}

class Data {
  final BasicSettings basicSettings;
  final AllLogo allLogo;
  final WebLinks webLinks;
  final List<Language> languages;
  final List<SplashScreen> splashScreen;
  final List<OnboardScreen> onboardScreens;
  final AppImagePaths appImagePaths;
  final AppImagePaths imageAssets;

  Data({
    required this.basicSettings,
    required this.allLogo,
    required this.webLinks,
    required this.languages,
    required this.splashScreen,
    required this.onboardScreens,
    required this.appImagePaths,
    required this.imageAssets,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        basicSettings: BasicSettings.fromJson(json["basic_settings"]),
        allLogo: AllLogo.fromJson(json["all_logo"]),
        webLinks: WebLinks.fromJson(json["web_links"]),
        languages: List<Language>.from(
            json["languages"].map((x) => Language.fromJson(x))),
        splashScreen: List<SplashScreen>.from(
            json["splash_screen"].map((x) => SplashScreen.fromJson(x))),
        onboardScreens: List<OnboardScreen>.from(
            json["onboard_screens"].map((x) => OnboardScreen.fromJson(x))),
        appImagePaths: AppImagePaths.fromJson(json["app_image_paths"]),
        imageAssets: AppImagePaths.fromJson(json["image_assets"]),
      );

  Map<String, dynamic> toJson() => {
        "basic_settings": basicSettings.toJson(),
        "all_logo": allLogo.toJson(),
        "web_links": webLinks.toJson(),
        "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
        "splash_screen":
            List<dynamic>.from(splashScreen.map((x) => x.toJson())),
        "onboard_screens":
            List<dynamic>.from(onboardScreens.map((x) => x.toJson())),
        "app_image_paths": appImagePaths.toJson(),
        "image_assets": imageAssets.toJson(),
      };
}

class AllLogo {
  final String siteLogoDark;
  final String siteLogo;
  final String siteFavDark;
  final String siteFav;

  AllLogo({
    required this.siteLogoDark,
    required this.siteLogo,
    required this.siteFavDark,
    required this.siteFav,
  });

  factory AllLogo.fromJson(Map<String, dynamic> json) => AllLogo(
        siteLogoDark: json["site_logo_dark"],
        siteLogo: json["site_logo"],
        siteFavDark: json["site_fav_dark"],
        siteFav: json["site_fav"],
      );

  Map<String, dynamic> toJson() => {
        "site_logo_dark": siteLogoDark,
        "site_logo": siteLogo,
        "site_fav_dark": siteFavDark,
        "site_fav": siteFav,
      };
}

class AppImagePaths {
  final String baseUrl;
  final String pathLocation;
  final String defaultImage;

  AppImagePaths({
    required this.baseUrl,
    required this.pathLocation,
    required this.defaultImage,
  });

  factory AppImagePaths.fromJson(Map<String, dynamic> json) => AppImagePaths(
        baseUrl: json["base_url"],
        pathLocation: json["path_location"],
        defaultImage: json["default_image"],
      );

  Map<String, dynamic> toJson() => {
        "base_url": baseUrl,
        "path_location": pathLocation,
        "default_image": defaultImage,
      };
}

class BasicSettings {
  final int id;
  final String siteName;
  final String siteTitle;
  final String currencyCode;
  final String timezone;

  BasicSettings({
    required this.id,
    required this.siteName,
    required this.siteTitle,
    required this.currencyCode,
    required this.timezone,
  });

  factory BasicSettings.fromJson(Map<String, dynamic> json) => BasicSettings(
        id: json["id"],
        siteName: json["site_name"],
        siteTitle: json["site_title"],
        currencyCode: json["currency_code"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "site_name": siteName,
        "site_title": siteTitle,
        "currency_code": currencyCode,
        "timezone": timezone,
      };
}

class Language {
  final int id;
  final String name;
  final String code;
  final int status;

  Language({
    required this.id,
    required this.name,
    required this.code,
    required this.status,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "status": status,
      };
}

class OnboardScreen {
  final String title;
  final String subTitle;
  final String image;
  final int status;

  OnboardScreen({
    required this.title,
    required this.subTitle,
    required this.image,
    required this.status,
  });

  factory OnboardScreen.fromJson(Map<String, dynamic> json) => OnboardScreen(
        title: json["title"],
        subTitle: json["sub_title"],
        image: json["image"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "sub_title": subTitle,
        "image": image,
        "status": status,
      };
}

class SplashScreen {
  final String image;
  final String version;

  SplashScreen({
    required this.image,
    required this.version,
  });

  factory SplashScreen.fromJson(Map<String, dynamic> json) => SplashScreen(
        image: json["image"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "version": version,
      };
}

class WebLinks {
  final String privacyPolicy;
  final String aboutUs;
  final String contactUs;

  WebLinks({
    required this.privacyPolicy,
    required this.aboutUs,
    required this.contactUs,
  });

  factory WebLinks.fromJson(Map<String, dynamic> json) => WebLinks(
        privacyPolicy: json["privacy-policy"],
        aboutUs: json["about-us"],
        contactUs: json["contact-us"],
      );

  Map<String, dynamic> toJson() => {
        "privacy-policy": privacyPolicy,
        "about-us": aboutUs,
        "contact-us": contactUs,
      };
}

class Message {
  final List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
