import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'screens/calculator_screen.dart';
import 'screens/growth_rate_screen.dart';
import 'screens/stock_valuation_screen.dart';
import 'screens/risk_management_screen.dart';
import 'screens/stock_price_screen.dart';
import 'screens/criteria_screen.dart';
//import 'screens/clock_screen.dart';
import 'screens/browser_screen.dart';
import 'screens/advanced_calculator_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/notes_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          showUnselectedLabels: true,
        ),
      ),
      //home: MainScreen(),
      home: SplashScreen(), // Hiển thị SplashScreen khi mở app
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Đợi 3-5 giây trước khi chuyển đến MainScreen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()), // Chuyển đến màn hình chính
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Ảnh nền
          Image.asset(
            'assets/images/your_image.jpg', // Đảm bảo đã thêm đúng tên ảnh trong assets
            fit: BoxFit.cover,
          ),
          // Nội dung chữ trên ảnh nền
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "ĐIỂM KHÁC BIỆT GIỮA NHỮNG NGƯỜI THÀNH CÔNG VÀ NGƯỜI KHÁC LÀ HỌ XÁC ĐỊNH MỤC TIÊU, PHƯƠNG THỨC HOÀN THÀNH MỤC TIÊU VÀ KIÊN TRÌ THEO ĐUỔI NÓ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "KIÊU BINH TẤT BẠI",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  File? _image;

  final List<Widget> _screens = [
    CalculatorScreen(),
    GrowthRateScreen(),
    StockValuationScreen(),
    RiskManagementScreen(),
    ManHinhBangGiaChungKhoan(),
    StockAnalysisChecklist(),
  ];

  // Future<void> _openCamera() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.camera);
  //
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //   }
  // }

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // Lưu ảnh vào thư mục của ứng dụng
      final File imageFile = File(pickedFile.path);

      // Bạn có thể xử lý lưu trữ hình ảnh tại đây, ví dụ: upload lên server hoặc lưu vào thư mục cụ thể.

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ảnh đã được lưu: ${imageFile.path}")),
      );
    }
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ứng dụng Chứng khoán"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Bùi Thanh Nhân"),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            // ListTile(
            //   title: Text("Đồng hồ"),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => ClockScreen()),
            //     );
            //   },
            // ),
            // ListTile(
            //   title: Text("Mở Camera"),
            //   leading: Icon(Icons.camera_alt),
            //   onTap: () {
            //     _openCamera();
            //     Navigator.pop(context);
            //   },
            // ),
            ListTile(
              title: Text("Trình duyệt"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BrowserScreen()),
                );
              },
            ),
            ListTile(
              title: Text("Máy tính chuyên nghiệp"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdvancedCalculatorScreen()),
                );
              },
            ),
            ListTile(
              title: Text("Lịch - Ghi chú"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarScreen()),
                );
              },
            ),
            ListTile(
              title: Text("Ghi chú"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotesScreen()),
                );
              },
            ),
            _buildDrawerItem("PE của VNINDEX - Simplize", "https://simplize.vn/chi-so/VNINDEX"),
            _buildDrawerItem("PE của VNINDEX - Vndirect", "https://dstock.vndirect.com.vn/"),
            _buildDrawerItem("Tổng quan 24hMoney", "https://24hmoney.vn/stock/ACB/financial-report"),
            _buildDrawerItem("Khuyến nghị TCBS", "https://iwealthclub.com.vn/dashboard"),
            _buildDrawerItem("Trang chủ TCBS", "https://tcinvest.tcbs.com.vn/guest/login"),
            _buildDrawerItem("Vòng quay hàng tồn kho", "https://vn.investing.com/equities/mobile-world-investment-corp-ratios"),
            _buildDrawerItem("Sách dạy tester", "https://drive.google.com/drive/folders/16omUTBJgCTryZ6bmJOhknKcAn4Vzt9dj"),
            _buildDrawerItem("File phân tích NMT", "https://docs.google.com/spreadsheets/d/1CXJh8ai1HBpmaOMNFXOQvUpcrgz-MbqMbWq-npT92xM/edit?gid=1626738698#gid=1626738698"),
            _buildDrawerItem("File phân tích BÙI THANH NHÂN", "https://docs.google.com/spreadsheets/d/1V1X-XRhaa-GZIeykDPhxU8zWXvZOmTgB8RgY-DN7HBg/edit?gid=0#gid=0"),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
      //body: _image == null ? _screens[_selectedIndex] : Image.file(_image!),
      // body: _image == null
      //     ? _screens[_selectedIndex]
      //     : Column(
      //   children: [
      //     Expanded(child: _screens[_selectedIndex]),
      //     Image.file(_image!),
      //   ],
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.calculate, size: 30), label: "Máy tính"),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart, size: 30), label: "Tăng trưởng"),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up, size: 30), label: "Định giá"),
          BottomNavigationBarItem(icon: Icon(Icons.shield, size: 30), label: "Rủi ro"),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money, size: 30), label: "Bảng giá"),
          BottomNavigationBarItem(icon: Icon(Icons.checklist), label: "Tiêu chí"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        elevation: 10,
      ),
    );
  }

  Widget _buildDrawerItem(String title, String url) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WebViewScreen(url: url)),
        );
      },
    );
  }
}

class WebViewScreen extends StatefulWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ứng dụng chứng khoán")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
