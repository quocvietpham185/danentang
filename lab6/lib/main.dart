// lib/main.dart
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

// Khởi tạo bộ câu hỏi
QuizBrain quizBrain = QuizBrain();

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF141E30), Color(0xFF243B55)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: QuizPage(),
            ),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // Danh sách lưu trữ các Icon (dấu tick xanh hoặc dấu X đỏ)
  List<Icon> scoreKeeper = [];
  int score = 0;

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      // 1. Kiểm tra xem đã hoàn thành toàn bộ câu hỏi chưa
      if (quizBrain.isFinished() == true) {
        // Hiện thông báo bằng thư viện rflutter_alert
        Alert(
          context: context,
          type: AlertType.success,
          title: 'HOÀN THÀNH!',
          desc: 'Bạn đã đạt $score / ${scoreKeeper.length + 1} điểm.',
          style: const AlertStyle(
            isCloseButton: false,
            titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            descStyle: TextStyle(fontSize: 18),
          ),
          buttons: [
            DialogButton(
              onPressed: () {
                // Đóng popup
                Navigator.pop(context);
                // Reset mọi thứ lại từ đầu
                setState(() {
                  quizBrain.reset();
                  scoreKeeper = [];
                  score = 0;
                });
              },
              width: 120,
              color: const Color(0xFF243B55),
              radius: BorderRadius.circular(20),
              child: const Text(
                "CHƠI LẠI",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ).show();
      }
      // 2. Nếu chưa hết câu hỏi, tiến hành kiểm tra đáp án
      else {
        if (userPickedAnswer == correctAnswer) {
          score++;
          scoreKeeper.add(const Icon(Icons.check_circle, color: Colors.greenAccent, size: 28));
        } else {
          scoreKeeper.add(const Icon(Icons.cancel, color: Colors.redAccent, size: 28));
        }
        quizBrain.nextQuestion(); // Chuyển câu tiếp theo
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Phần hiển thị câu hỏi
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  )
                ]
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26.0, 
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 10),

        // Nút TRUE
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00C853), // Nền xanh mượt
                foregroundColor: Colors.white,
                elevation: 8,
                shadowColor: Colors.greenAccent.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Đúng',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),

        // Nút FALSE
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD50000), // Nền đỏ mượt
                foregroundColor: Colors.white,
                elevation: 8,
                shadowColor: Colors.redAccent.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Sai',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),

        // Thanh hiển thị tiến độ (Score Keeper)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          child: Container(
            constraints: const BoxConstraints(minHeight: 45.0),
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(25),
            ),
            child: scoreKeeper.isEmpty 
                ? const Center(
                    child: Text(
                      'Bắt đầu trả lời!',
                      style: TextStyle(color: Colors.white54, fontSize: 16),
                    ),
                  )
                : Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: scoreKeeper,
                  ),
          ),
        ),
      ],
    );
  }
}
