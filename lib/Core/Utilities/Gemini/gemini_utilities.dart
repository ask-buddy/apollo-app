import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiUtilites {
  static GeminiUtilites shared = GeminiUtilites();
  static String apiKey = "AIzaSyAaId5V1ZcXcjbJIDU8LMoHS_upOh-WZnM";

  final String _explainerPrompt = """
Input adalah soal matematika yang perlu diselesaikan. Soal matematika yang di berikan bisa lebih dari satu soal,  berikan penjelasan langkah-langkah penyelesaiannya dengan penjelasaan menarik seperti menjelaskan kepada teman dan  menggunakan bahasa indonesia. Berikut adalah struktur penjelasan atau section yang saya harapkan:

Terdapat 2 bagian besar : 
bagian pertama fokus memberikan jawaban sebagai berikut :
Jika terdapat lebih dari soal berikan keterangan Nomor Soal, jika soal hanya satu tidak perlu diberikan keterangan nomor soal
- **Mata pelajaran atau subject dari soal**
- **Materi atau topics matematika pada soal yang akan di bahas**
- **Langkah - langkah penyelesaian soal step by step dengan struktur **
    - Diketahui, atau Identifikasi informasi yang diberikan dalam soal.
    - Ditanyakan, Tentukan apa yang diminta dalam soal.
    - Strategi, Diskusikan strategi yang bisa digunakan untuk menyelesaikan soal.
    - Eksekusi Langkah - langkah penyelesaian soal 
       gunakan list bullet pada Langkah penyelesaian soal, pastikan ketika terdapat = atau : pada satu section langkah-langkah, gunakan baris baru.

- **Estimasi kesulitan : **
Gunakan kerangka kerja Bloom Taksonomi untuk menentukan tingkat kesulitan soal, dan konversikan menjadi angka dengan range dari 1 sampai 5:
gunakan range angka 1 atau 2 jika Mudah (kelas: tingkat-kesulitan-mudah)
gunakan angka 3 jika Sedang (kelas: tingkat-kesulitan-sedang)
gunakan range 4 atau 5 jika Sulit (kelas: tingkat-kesulitan-sulit)
Gunakan tag <span> dengan atribut kelas yang sesuai.

- **Estimasi waktu : **
Berikan estimasi waktu yang dibutuhkan untuk menyelesaikan soal dengan menghitungnya memperhatikan kerangka kerja bloom taksonomi.

Bagian ke dua adalah penjelasan detail yang berisi
- **Konsep dasar yang dibutuhkan**:
- **Memahami Konsep Dasar**:
    - Jelaskan definisi dan istilah yang relevan dengan soal.
- **Contoh penggunaan dalam kehidupan **:
    - Berikan contoh kontekstual yang relevan konsep tersebut dengan kehidupan sehari hari dan pemanfaatannya. 

Dalam menjawab Selalu gunakan struktur yang sama untuk setiap soal.

Saya mengharapkan output markdown di rubah menjadi format tag html yang sesuai seperti header ## diganti dengan <h3>, sub heading dengan <h4>, cetak tebal **text** menjadi <b>textb</b>, bullet, penomoran dan tag lainnya juga dibungkus dengan tag format html yang sesuai.
Pada bagian mata pelajaran gunakan tag span bukan <h3> dan berikan attribut kelas mata-pelajaran di tag htmlnya, dan untuk materi atau topics gunakan tag span bukan <h3> dan berikan attribut kelas materi-topics.

Pada bagian Estimasi kesulitan gunakan tag html span dan berikan attribut kelas tingkat-kesulitan-mudah untuk mudah, tingkat-kesulitan-sedang untuk sedang dan tingkat-kesulitan-sulit untuk sulit.

kemudian khusus untuk semua notasi matematika selain di bungkus tag html juga di tulis dalam format latex  yang dibungkus dengan backslash kurung tutup angka format latex backslash kurung tutupdan jangan menggunakan tag latex seperti \\begin{aligned} atau tag latex yang lainnya.

Contoh hasil format latex yang saya harapkan contohnya seperti ini <li>backslash kurung buka \\frac{3m - 5}{m - 3} = 3 backslash kurung tutup</li>

  """;

<<<<<<< HEAD
  final String _generateQuestionPrompt = "You are a Mathematician AI and excellent in math. Please create similar problems based on the provided SAT or ACT question using the original language and format from the assignment instructions. Respond by generating a unique and different question that matches the given language and format exactly, ensuring it is clear and properly formatted without any additional text or explanations. Each problem should use numbers between 1 and 100. Paraphrase and vary the context of the problems while maintaining the same question style and mathematical complexity. For example, if the original question involves algebraic expressions with square roots, change the context to a real-world scenario such as comparing lengths in different units, calculating areas, or determining volumes, but ensure the mathematical operations remain similar. ";
=======
  final String _generateQuestionPrompt =
      "You are a Mathematician AI and excellent in math. Please create similar problems based on the provided SAT or ACT question using the original language and format from the assignment instructions. Respond by generating a unique and different question that matches the given language and format exactly, ensuring it is clear and properly formatted without any additional text or explanations. Each problem should use numbers between 1 and 100. Paraphrase and vary the context of the problems while maintaining the same question style and mathematical complexity. For example, if the original question involves algebraic expressions with square roots, change the context to a real-world scenario such as comparing lengths in different units, calculating areas, or determining volumes, but ensure the mathematical operations remain similar. ";
>>>>>>> 0a5567f991107742a25cdf9a335f89b75714c19f

  final _modelGemini15pro = GenerativeModel(
    model: 'gemini-1.5-pro-latest',
    apiKey: apiKey,
  );
}

// Explainer
extension GeminiExplainer on GeminiUtilites {
  Future<String> generateExplanation(File image) async {
    final content = [
      Content.multi([
        TextPart(_explainerPrompt),
        DataPart("image/jpeg", image.readAsBytesSync())
      ])
    ];

    final response = await _modelGemini15pro.generateContent(content);
    return response.text ?? "No Response Provided";
  }
}

// GenerateQuestion
extension GeminiGenerateQuestion on GeminiUtilites {
  Future<String> generateQuestion(File image) async {
    final content = [
      Content.multi([
        TextPart(_generateQuestionPrompt),
        DataPart("image/jpeg", image.readAsBytesSync())
      ])
    ];

    final response = await _modelGemini15pro.generateContent(content);
    return response.text ?? "No Response Provided";
  }
}
