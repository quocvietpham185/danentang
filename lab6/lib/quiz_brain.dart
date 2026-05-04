// lib/quiz_brain.dart

class Question {
  String questionText;
  bool questionAnswer;

  Question(this.questionText, this.questionAnswer);
}

class QuizBrain {
  int _questionNumber =
      0; // Biến private (bắt đầu bằng dấu _) để bảo vệ dữ liệu

  // Danh sách các câu hỏi
  final List<Question> _questionBank = [
    Question('Đà Nẵng là thành phố trực thuộc trung ương?', true),
    Question('Sông Hàn chảy qua thủ đô Hà Nội?', false),
    Question('Cầu Rồng có thể phun lửa và phun nước?', true),
    Question('Bà Nà Hills nằm ở tỉnh Quảng Nam?', false),
  ];

  // Lấy câu hỏi hiện tại
  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  // Lấy đáp án của câu hỏi hiện tại
  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  // Chuyển sang câu hỏi tiếp theo
  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  // Kiểm tra xem đã hết câu hỏi chưa
  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  // Khởi động lại trò chơi
  void reset() {
    _questionNumber = 0;
  }
}
