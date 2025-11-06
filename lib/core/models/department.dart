class Department {
  String? facultyName;
  String? depName;
  String? facultyUrl;
  String? depUrl;

  Department({
    this.facultyName,
    this.facultyUrl,
    this.depName,
    this.depUrl,
  });

  static Department? fromJson(Map<String, dynamic> json) {
    final facdiv = json['facdiv'] ?? {};
    final depbranch = json['depbranch'] ?? {};
    if (facdiv.isEmpty && depbranch.isEmpty) {
      return null;
    }
    return Department(
      facultyName: facdiv['name'],
      facultyUrl: facdiv['url'],
      depName: depbranch['name'],
      depUrl: depbranch['url'],
    );
  }
}
