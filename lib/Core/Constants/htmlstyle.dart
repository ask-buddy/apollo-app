class ABStyle {
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
            .mata-pelajaran{
              padding: 8px 12px;

              border-radius: 8px;
              font-weight: bold;
              margin-bottom: 30px
            }
            .materi-topics{
            padding: 6px 8px;

              border-radius: 8px;
              font-size : 12px;
              font-weight: semibold;

            .tingkat-kesulitan-mudah{
              padding: 6px 8px;

              border-radius: 8px;
              font-size : 12px;
              font-weight: semibold;
              font-style: italic;
              }
            .tingkat-kesulitan-sedang{
              padding: 6px 8px;

              border-radius: 8px;
              font-size : 12px;
              font-weight: semibold;
              font-style: italic;
              }
            }
            .tingkat-kesulitan-sulit{
              padding: 6px 8px;

              border-radius: 8px;
              font-size : 12px;
              font-weight: semibold;
              font-style: italic;
              }
            }
          </style>
  """;
}
