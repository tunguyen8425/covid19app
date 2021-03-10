<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class HospitalSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('hospitals')->insert([
            'name' => "Bệnh viện Từ Dũ",
            'address' => '284 Cống Quỳnh, Phường Phạm Ngũ Lão, Quận 1, Hồ Chí Minh',
            'description' => 'Bệnh viện Từ Dũ là một bệnh viện phụ sản ở Thành phố Hồ Chí Minh, Việt Nam. Với gần 100 năm làm việc và phát triển, Bệnh viện Từ Dũ là nơi ra đời của rất nhiều thế hệ em bé sinh ra ở tại Thành phố Hồ Chí Minh.',
            'map_address' => '10.7688346,106.6836659',
            'far' => '0',
        ]);
        DB::table('hospitals')->insert([
            'name' => "Bệnh viện Bình Dân",
            'address' => '371 Điện Biên Phủ, Phường 4, Quận 3, Hồ Chí Minh',
            'description' => 'Bệnh viện Bình Dân là bệnh viện chuyên khoa hạng I và là tuyến trung ương về phẫu thuật tổng quát và niệu khoa với trang thiết bị hiện đại, phát triển nhiều lĩnh vực chuyên sâu do các giáo sư, phó giáo sư, tiến sĩ, bác sĩ chuyên gia đảm trách.',
            'map_address' => '10.7740246,106.6812751',
            'far' => '1',
        ]);
        DB::table('hospitals')->insert([
            'name' => "Bệnh viện Quận Thủ Đức",
            'address' => '29 Phú Châu, Tam Phú, Thủ Đức, Hồ Chí Minh',
            'description' => 'Bệnh viện quận Thủ Đức là đơn vị khám chữa bệnh trực thuộc quận/ huyện hạng I (theo tiêu chí của Bộ Y tế)',
            'map_address' => '10.8646225,106.7454627',
            'far' => '3',
        ]);
        DB::table('hospitals')->insert([
            'name' => "Bệnh viện Quận 9",
            'address' => '387 Lê Văn Việt, Tăng Nhơn Phú A, Quận 9, Hồ Chí Minh',
            'description' => 'Bệnh viện Quận 9 là cơ sở khám bệnh, chữa bệnh, tiếp nhận mọi người bệnh đến cấp cứu, chữa bệnh nội trú và ngoại trú theo chế độ chính sách nhà nước quy định. Tổ chức khám sức khoẻ và chứng nhận sức khỏe theo quy định của nhà nước.',
            'map_address' => '10.8449235,106.7901471',
            'far' => '2',
        ]);
    }
}
