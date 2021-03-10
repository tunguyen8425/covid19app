import 'package:healthpro/src/model/survey.dart';
import 'package:healthpro/src/model/hospital.dart';

class AppData {
  static List<Hospital> productList = [
    Hospital(
        id:1,
        name: 'Bệnh Viện 175',
        address: '782 Nguyễn Kiệm, Quận Gò Vấp',
        far: 0.2,
        isliked: '782 Nguyễn Kiệm, Quận Gò Vấp',
        image: 'assets/benhviendakhoathuduc.jpg',
        category: "Trending Now"),
    Hospital(
        id:2,
        name: 'Bệnh Viện Điều Dưỡng – Phục Hồi Chức Năng – Điều Trị Bệnh Nghề Nghiệp',
        address: '125/61 Âu Dương Lân, P.2, Quận 8',
        far: 0.5,
        isliked: '125/61 Âu Dương Lân, P.2, Quận 8',
        image: 'assets/benhvien175.png',
        category: "Trending Now"),
    Hospital(
        id:3,
        name: 'Bệnh Viện Điều Dưỡng – Phục Hồi Chức Năng Bưu Điện 2 ',
        address: '68 KP2 Nguyễn Duy Hiệu, P.Thảo Điền, Quận 2',
        far: 0.8,
        isliked: '68 KP2 Nguyễn Duy Hiệu, P.Thảo Điền, Quận 2',
        image: 'assets/benhvienquan9.jpg',
        category: "Trending Now"),
    Hospital(
        id:4,
        name: 'Bệnh Viện Phụ Sản Quốc Tế Sài Gòn (SIHOSPITAL)',
        address: '63 Bùi Thị Xuân, P.PNL, Quận 1',
        far: 0.9,
        isliked: '63 Bùi Thị Xuân, P.PNL, Quận 1',
        image: 'assets/benhviendakhoathuduc.jpg',
        category: "Trending Now"),
    Hospital(
        id:5,
        name: 'Bệnh Viện Trường ĐH Y Dược – Khoa Y Học Cổ Truyền',
        address: '221B Hoàng Văn Thụ, P.8, Quận Phú Nhuận',
        far: 1.0,
        isliked: '221B Hoàng Văn Thụ, P.8, Quận Phú Nhuận',
        image: 'assets/benhviendakhoathuduc.jpg',
        category: "Trending Now"),
  ];

  static List<Survey> surveyList = [
    Survey(
        id:1,
        name: "Corona",
        image: "assets/virus.png",
        date: "20/04/2020"
    ),
    Survey(
        id:2,
        name: "Sars",
        image: "assets/virus.png",
        date: "05/04/2020"
    ),
  ];
  static List<String> showThumbnailList = [
    "assets/shoe_thumb_5.png",
    "assets/shoe_thumb_1.png",
    "assets/shoe_thumb_4.png",
    "assets/shoe_thumb_3.png",
  ];
  static String description = "Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey.";
}
