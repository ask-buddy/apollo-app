import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiUtilites {
  static GeminiUtilites shared = GeminiUtilites();
  static String apiKey = "AIzaSyAaId5V1ZcXcjbJIDU8LMoHS_upOh-WZnM";

  final String _explainerPrompt = """
  input adalah soal matematika yang perlu diselesaikan. Tolong jelaskan langkah-langkah penyelesaiannya secara detail , mulai dari konsep dasar hingga penyelesaian soal dengan penjelasaan seperti kepada teman dan tentu menggunakan bahasa indonesia. Berikut adalah struktur atau section yang saya harapkan:

  1. **Memahami Konsep Dasar**:
   - Jelaskan definisi dan istilah yang relevan dengan soal.
   - Berikan contoh kontekstual yang relevan dengan konsep tersebut dengan kehidupan sehari hari dan pemanfaatannya. 

  2. **Menjelaskan Teori dan Rumus**:
   - Jelaskan teori di balik konsep yang diperlukan untuk menyelesaikan soal.
   - Tunjukkan bagaimana rumus diturunkan jika memungkinkan.
   - Gunakan diagram atau visualisasi jika diperlukan.

  3. **Langkah-langkah Penyelesaian Soal**:
   - Identifikasi informasi yang diberikan dalam soal.
   - Tentukan apa yang diminta dalam soal.
   - Diskusikan strategi yang bisa digunakan untuk menyelesaikan soal.

  4. **Penyelesaian Soal Langkah demi Langkah**:
   - Berikan solusi langkah demi langkah dengan penjelasan yang detail.
   - Tunjukkan cara menuliskan setiap langkah dengan jelas.

  Selalu gunakan struktur yang sama untuk setiap soal, 

  saya mengharapkan output markdown di rubah menjadi format tag html yang sesuai seperti header ## diganti dengan <h3>, cetak tebal **text** menjadi <b>textb</b>, bullet, penomoran dan yang lainnya juga dibungkus dengan tag format html yang sesuai, 

  kemudian khusus untuk notasi matematika selain di bungkus tag html juga di tulis dalam format latex  yang dibungkus dengan \\( angka format latex \\) dan tidak perlu menggunakan tag latex seperti \begin{aligned} atau yang lainnya.

  contoh hasil format latex yang saya harapkan contohnya seperti ini <li>\\( \frac{3m - 5}{m - 3} = 3 \\)</li>

  """;

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
