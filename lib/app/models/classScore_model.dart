class ClassScore {
  String classId;
  // String className;
  int score;

  ClassScore({
    required this.classId,
    required this.score,
    // required this.className,
  });

  void setClassScore(String setClassId, int setScore) {
    classId = setClassId;
    score = setScore;
  }

  void setScore(int setScore) {
    score = setScore;
  }

  void setId(String setId) {
    classId = setId;
  }

  ClassScore getClassScore() {
    return ClassScore(
      classId: classId,
      score: score,
      // className: className,
    );
  }
}
