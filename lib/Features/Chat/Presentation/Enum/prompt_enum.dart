enum PromptEnum {
  generateSimiliarQuestion,
  solveNewQuestion,
  checkAnswer,
  actExamInfo,
  normalPrompt
}

// Map to convert enum to string and vice versa
class PromptEnumHelper {
  static const Map<PromptEnum, String> _enumToString = {
    PromptEnum.generateSimiliarQuestion: 'generateSimiliarQuestion',
    PromptEnum.solveNewQuestion: 'solveNewQuestion',
    PromptEnum.checkAnswer: 'checkAnswer',
    PromptEnum.actExamInfo: 'actExamInfo',
    PromptEnum.normalPrompt: 'normalPrompt',
  };

  static const Map<String, PromptEnum> _stringToEnum = {
    'generateSimiliarQuestion': PromptEnum.generateSimiliarQuestion,
    'solveNewQuestion': PromptEnum.solveNewQuestion,
    'checkAnswer': PromptEnum.checkAnswer,
    'actExamInfo': PromptEnum.actExamInfo,
    'normalPrompt': PromptEnum.normalPrompt,
  };

  static String toAbsoluteString(PromptEnum value) {
    return _enumToString[value]!;
  }

  static PromptEnum fromString(String value) {
    return _stringToEnum[value] ?? PromptEnum.normalPrompt;
  }
}
