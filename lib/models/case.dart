class Case {
  final int totalGlobalCases;
  final int totalGlobalDeaths;
  final int totalGlobalrecovered;

  Case({this.totalGlobalCases, this.totalGlobalDeaths, this.totalGlobalrecovered});

  factory Case.fromJson(Map<String, dynamic> json) {
    return Case(
      totalGlobalCases: json['cases'],
      totalGlobalDeaths: json['deaths'],
      totalGlobalrecovered: json['recovered'],
    );
  }
}
