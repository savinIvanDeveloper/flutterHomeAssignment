class Department {
  String? facultyName;
  String? depName;
  String? facultyUrl;
  String? depUrl;
  String? sectionName;
  String? sectionUrl;

  Department({
    this.facultyName,
    this.facultyUrl,
    this.depName,
    this.depUrl,
    this.sectionName,
    this.sectionUrl
  });

  static Department? fromJson(Map<String, dynamic> json) {
    final facdiv = json['facdiv'] ?? {};
    final depbranch = json['depbranch'] ?? {};
    final section = json['section'] ?? {};
    if (facdiv.isEmpty && depbranch.isEmpty && section.isEmpty) {
      return null;
    }
    return Department(
      facultyName: facdiv['name'],
      facultyUrl: facdiv['url'],
      depName: depbranch['name'],
      depUrl: depbranch['url'],
      sectionName: section['name'],
      sectionUrl: section['url']
    );
  }
}
