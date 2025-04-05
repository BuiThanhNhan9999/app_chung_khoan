import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StockAnalysisChecklist extends StatefulWidget {
  @override
  _StockAnalysisChecklistState createState() => _StockAnalysisChecklistState();
}

class _StockAnalysisChecklistState extends State<StockAnalysisChecklist> {
  Map<String, bool> checklist = {};
  Map<String, bool> sectionExpanded = {
    "TIẾT KIỆM": false,
    "XÁC ĐỊNH THỊ TRƯỜNG": false,
    "CHỌN CỔ PHIẾU ĐỂ PHÂN TÍCH": false,
    "PHÂN TÍCH CƠ BẢN VÀ PHÂN TÍCH KỸ THUẬT": false,
    "BÁO CÁO KINH DOANH": false,
    "MUA VÀO CỔ PHIẾU": false,
    "BÁN RA CỔ PHIẾU": false,
    "THEO DÕI CỔ PHIẾU": false,
  };

  TextEditingController stockCodeController = TextEditingController(); // Controller cho ô nhập mã cổ phiếu

  @override
  void initState() {
    super.initState();
    _loadChecklist();
    _loadStockCode();
  }

  // Tải checklist từ SharedPreferences
  Future<void> _loadChecklist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      checklist = Map<String, bool>.from((prefs.getKeys().fold({}, (prev, key) {
        prev[key] = prefs.getBool(key) ?? false;
        return prev;
      })));
    });
  }

  // Lưu checklist vào SharedPreferences
  Future<void> _saveChecklist(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Tải mã cổ phiếu đã lưu từ SharedPreferences
  Future<void> _loadStockCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    stockCodeController.text = prefs.getString('stock_code') ?? '';
  }

  // Lưu mã cổ phiếu vào SharedPreferences
  Future<void> _saveStockCode(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('stock_code', code);
  }

  int countCheckedItemsInSection(String section) {
    List<String> items = checklist.keys.where((key) => key.startsWith(section)).toList();
    return items.where((item) => checklist[item] == true).length;
  }

  Widget _buildSection(String title, List<dynamic> items) {
    return ExpansionTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      children: items.map<Widget>((item) {
        if (item is String) {
          return CheckboxListTile(
            title: Text(
              item,
              style: TextStyle(
                color: checklist[item] ?? false ? Colors.grey : Colors.black, // Đổi màu chữ nếu checkbox được tick
              ),
            ),
            value: checklist[item] ?? false,
            onChanged: (bool? value) {
              setState(() {
                checklist[item] = value ?? false;
                _saveChecklist(item, value ?? false); // Lưu lại trạng thái của checkbox
              });
            },
          );
        } else if (item is Widget) {
          return item; // Trường hợp cho section cấp 2
        }
        return SizedBox.shrink();
      }).toList(),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phân tích cổ phiếu")),
      body: ListView(
        children: [
          // Thêm ô nhập mã cổ phiếu trên cùng
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: stockCodeController,
              decoration: InputDecoration(
                labelText: "Nhập mã cổ phiếu",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _saveStockCode(value); // Lưu lại mã cổ phiếu khi người dùng nhập
              },
            ),
          ),
          _buildSection("TIẾT KIỆM", [
            "Để giành 3-6 tháng tiền mặt",
            "60% cho cổ phiếu - 40% cho gởi tiết kiệm/ mua vàng"
          ]),
          _buildSection("XÁC ĐỊNH THỊ TRƯỜNG", [
            "Thị trường tốt (PE < 16 lần) - đầu tư cổ phiếu ngành sản xuất, xây dựng, ngân hàng...",
            "Thị trường xấu (PE > 16 lần) - đầu tư cổ phiếu tiêu dùng thiết yếu, năng lượng...",
            "Công ty đang phân tích có vốn hoá lớn (> 10,000 tỷ đồng)",
            "Công ty đang phân tích có vốn hoá vừa (1,000 - 10,000 tỷ đồng)",
            "Công ty đang phân tích thuộc công ty chia cổ tức nhiều",
            "Công ty đang phân tích thuộc công ty lớn dự đoán được lợi nhuận",
            "Công ty lớn tăng trưởng (công ty công nghệ mang tính chu kỳ)"
          ]),
          _buildSection("CHỌN CỔ PHIẾU ĐỂ PHÂN TÍCH", [
            "Xu hướng dòng tiền trên SSI",
            "Khuyến nghị mua cổ phiếu trên TCBS",
            "Các tin tức chính thống",
            "Sản phẩm chúng ta tiêu dùng"
          ]),
          _buildSection("PHÂN TÍCH CƠ BẢN VÀ PHÂN TÍCH KỸ THUẬT", [
            _buildSection("BÁO CÁO KINH DOANH", [
              "*Tỷ lệ Lợi nhuận GỘP > 25% trong 10 năm (tỷ lệ Lợi nhuận phải tăng mỗi năm)",
              "*EPS tăng đều (tăng bao nhiêu %)",
              "*PE gần = tỷ lệ tăng trưởng EPS/ Lợi nhuận Ròng",
              "*Chú trọng chi phí quảng cáo, nghiên cứu và khấu hao tài sản"
            ]),
            _buildSection("BÁO CÁO LƯU CHUYỂN TIỀN TỆ", [
              "*Lưu chuyển tiền thuần trong kỳ tăng hàng năm là OK"
            ]),
            _buildSection("BÁO CÁO CÂN ĐỐI KẾ TOÁN", [
              "*Tiền mặt / Tổng tài sản từ 10-15% là OK (công ty công nghệ từ 10-20%)",
              "*Doanh thu phải tăng nhanh hơn các khoản phải thu",
              "*Tốc độ luân chuyển hàng tồn kho cao",
              "*Xem xét lợi thế thương mại (giá trị của thương hiệu)"
            ]),
            "1. Doanh thu, Lợi nhuận và Lưu chuyển tiền từ HOẠT ĐỘNG KINH DOANH tăng đều từ 5-10 năm không?",
            "2. Biên Lợi nhuận RÒNG, Lợi nhuận GỘP lớn hơn các công ty cùng ngành không? (CÔNG TY CÔNG NGHỆ dễ thay đổi) - năm cuối - *DẤU HIỆU: Thương hiệu uy tín, Chất lượng sản phẩm và dịch vụ tốt, Có bằng sáng chế và bí quyết kinh doanh, Có lượng lớn khách hàng trung thành, Quy mô khổng lồ và dẫn đầu thị trường",
            "3. Công ty có kế hoạch tăng trưởng trong tương lai - *DẤU HIỆU: Phát triển các dòng sản phẩm mới, phát triển công nghệ mới, Mở rộng công suất hoạt động, Mở rộng thị trường kinh doanh, có nhiều cửa hàng - chi nhánh mới, thị trường phân phối rộng lớn...",
            "4. Nợ dài hạn < 3 lần Lợi nhuận sau thuế (không áp dụng cho NGÂN HÀNG) - năm cuối",
            "5. ROE > 15% trong 5-10 năm",
            "6. Ban lãnh đạo nắm giữ lượng lớn cổ phiếu hoặc mua thêm cổ phiếu công ty - *DẤU HIỆU: Ban lãnh đạo tốt, không được kém - 3 giám đốc cấp cao cùng mua cổ phiếu công ty",
            "7. Đường 50 MA cắt lên đường 150 MA và cả 2 đường đều hướng lên",
            "8 Giá cổ phiếu hiện tại nhỏ hơn giá trị thật"
          ]),
          _buildSection("MUA VÀO CỔ PHIẾU", [
            "50 MA cắt lên 150 MA (hoặc 200 MA) - *DẤU HIỆU: Không mua 8-10 cổ phiếu trong cùng 1 thời điểm - Không mua hơn 2 cổ phiếu cùng nhóm ngành - Luôn giữ lại 10% là tiền mặt/ giá giảm có thể mua thêm - ỔN ĐỊNH THÌ ĐẦU TƯ, BẤT ỔN THÌ GIỮ TIỀN LẠI"
          ]),
          _buildSection("BÁN RA CỔ PHIẾU", [
            "50 MA cắt xuống 150 MA (hoặc 200 MA)",
            "Giá giảm 5-8% so với giá mua",
            "Giá giảm 5-8% so với đỉnh gần nhất",
            "Hai người điều hành bán ra cổ phiếu của họ",
            "Biên lợi nhuận sụt giảm so với đối thủ",
            "Khoản phải thu tăng nhanh hơn doanh thu",
            "Không thoả 8 tiêu chí của 1 cổ phiếu"
          ]),
          _buildSection("THEO DÕI CỔ PHIẾU", [
            "MUA VÀO: Sử dụng lệnh điều kiện >= Giá Sàn/ Giá tham chiếu => Mua với giá MP",
            "Bán lỗ 5%: sử dụng lệnh điều kiện <= Giá bán lỗ 5% => Bán với giá MP",
            "Chốt lời 6.5%: sử dụng lệnh dừng mức 6.5% => Bán 50% cổ phiếu giá MP",
            "Chốt lời > 10%: sử dụng lệnh dừng mức 10% => Bán 50% cổ phiếu còn lại giá MP",
            "Chốt lời 5% dưới đỉnh: sử dụng lệnh Trailling Top (5%) => Bán với giá MP",
            "Theo dõi biểu đồ giá mỗi tuần 1 lần",
            "Theo dõi BCTC mỗi quý 1 lần",
            "Cài đặt thông báo tự động trên APP",
            "Xem sổ lệnh/// - Xem biểu đồ giá/// - Xem tài sản tăng/ giảm tới 5% chưa?"
          ]),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Danh sách các mục con bên trong phần 'PHÂN TÍCH CƠ BẢN VÀ PHÂN TÍCH KỸ THUẬT'
                List<String> keysForBasicAndTechAnalysis = [
                  "*Tỷ lệ Lợi nhuận GỘP > 25% trong 10 năm (tỷ lệ Lợi nhuận phải tăng mỗi năm)",
                  "*EPS tăng đều (tăng bao nhiêu %)",
                  "*PE gần = tỷ lệ tăng trưởng EPS/ Lợi nhuận Ròng",
                  "*Chú trọng chi phí quảng cáo, nghiên cứu và khấu hao tài sản",
                  "*Lưu chuyển tiền thuần trong kỳ tăng hàng năm là OK",
                  "*Tiền mặt / Tổng tài sản từ 10-15% là OK (công ty công nghệ từ 10-20%)",
                  "*Doanh thu phải tăng nhanh hơn các khoản phải thu",
                  "*Tốc độ luân chuyển hàng tồn kho cao",
                  "*Xem xét lợi thế thương mại (giá trị của thương hiệu)",
                  "1. Doanh thu, Lợi nhuận và Lưu chuyển tiền từ HOẠT ĐỘNG KINH DOANH tăng đều từ 5-10 năm không?",
                  "2. Biên Lợi nhuận RÒNG, Lợi nhuận GỘP lớn hơn các công ty cùng ngành không? (CÔNG TY CÔNG NGHỆ dễ thay đổi) - năm cuối - *DẤU HIỆU: Thương hiệu uy tín, Chất lượng sản phẩm và dịch vụ tốt, Có bằng sáng chế và bí quyết kinh doanh, Có lượng lớn khách hàng trung thành, Quy mô khổng lồ và dẫn đầu thị trường",
                  "3. Công ty có kế hoạch tăng trưởng trong tương lai - *DẤU HIỆU: Phát triển các dòng sản phẩm mới, phát triển công nghệ mới, Mở rộng công suất hoạt động, Mở rộng thị trường kinh doanh, có nhiều cửa hàng - chi nhánh mới, thị trường phân phối rộng lớn...",
                  "4. Nợ dài hạn < 3 lần Lợi nhuận sau thuế (không áp dụng cho NGÂN HÀNG) - năm cuối",
                  "5. ROE > 15% trong 5-10 năm",
                  "6. Ban lãnh đạo nắm giữ lượng lớn cổ phiếu hoặc mua thêm cổ phiếu công ty - *DẤU HIỆU: Ban lãnh đạo tốt, không được kém - 3 giám đốc cấp cao cùng mua cổ phiếu công ty",
                  "7. Đường 50 MA cắt lên đường 150 MA và cả 2 đường đều hướng lên",
                  "8 Giá cổ phiếu hiện tại nhỏ hơn giá trị thật"
                ];

                // Đếm các checkbox đã được tick trong phần này
                int totalChecked = keysForBasicAndTechAnalysis
                    .where((key) => checklist[key] == true)
                    .length;

                int totalItems = keysForBasicAndTechAnalysis.length; // Tổng số mục cần kiểm tra (17)

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Kết quả"),
                    content: Text("Bạn đạt $totalChecked/$totalItems điểm trong mục 'PHÂN TÍCH CƠ BẢN VÀ PHÂN TÍCH KỸ THUẬT'. Tổng số checkbox là $totalItems."),
                    actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))],
                  ),
                );
              },
              child: Text("NỘP BÀI"),
            ),
          ),
        ],
      ),
    );
  }
}
