class ABStyle {
  ABStyle._();

  static const String mainStyle = """
          <style>
            body {
              line-height: 1.6; /* Mengatur jarak antar baris */
            }
            h2, h3 {
              margin-top: 20px; /* Mengatur jarak atas judul */
              margin-bottom: 10px; /* Mengatur jarak bawah judul */
            }
            p {
              margin-bottom: 15px; /* Mengatur jarak bawah paragraf */
            }
            ul {
              list-style-type: disc; /* Menggunakan bullet pada setiap list */
              margin-left: 20px; /* Menambahkan indentasi pada list */
            }
            ol {
              list-style-type: decimal; /* Menggunakan nomor pada setiap list */
              margin-left: 20px; /* Menambahkan indentasi pada list */
            }
          </style>
  """;
}
