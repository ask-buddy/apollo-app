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
- **Estimasi kesulitan : **
- **Estimasi waktu : **
Estimasi Dihitung dari seberapa rumit soal tersebut dan ada berapa kombinasi materi di dalam soal tersebut

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
