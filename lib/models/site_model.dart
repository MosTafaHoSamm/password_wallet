class SiteModel {
  String? siteName;
  String? siteCategory;
  String? sitePassword;
  String? siteImage;

  SiteModel(
      {required this.siteName,
      required this.siteCategory,
      required this.sitePassword,
      required this.siteImage,
      });

  SiteModel.fromJson(Map<String, dynamic> json) {
    siteName = json['siteName'];
    siteCategory = json['siteCategory'];
    sitePassword = json['sitePassword'];
    siteImage = json['siteImage'];
  }
}
