import 'package:flutter/material.dart';
import 'dart:math';

class GrowthRateScreen extends StatefulWidget {
  @override
  _GrowthRateScreenState createState() => _GrowthRateScreenState();
}

class _GrowthRateScreenState extends State<GrowthRateScreen> {
  // Bộ nhập liệu cho Tính toán 1
  TextEditingController pvController1 = TextEditingController();
  TextEditingController fvController1 = TextEditingController();
  TextEditingController nController1 = TextEditingController();
  String result1 = "";

  // Bộ nhập liệu cho Tính toán 2
  TextEditingController pvController2 = TextEditingController();
  TextEditingController fvController2 = TextEditingController();
  TextEditingController nController2 = TextEditingController();
  String result2 = "";

  // Bộ nhập liệu cho Tính toán 3
  TextEditingController pvController3 = TextEditingController();
  TextEditingController fvController3 = TextEditingController();
  TextEditingController nController3 = TextEditingController();
  String result3 = "";

  // Hàm tính tỷ lệ tăng trưởng độc lập
  void calculateGrowthRate(TextEditingController pvCtrl, TextEditingController fvCtrl, TextEditingController nCtrl, Function(String) setResult) {
    double? pv = double.tryParse(pvCtrl.text);
    double? fv = double.tryParse(fvCtrl.text);
    double? n = double.tryParse(nCtrl.text);

    if (pv != null && fv != null && n != null && pv > 0 && n > 0) {
      double rate = pow(fv / pv, 1 / n) - 1;
      setResult("Tỷ lệ tăng trưởng: ${(rate * 100).toStringAsFixed(2)}% mỗi kỳ");
    } else {
      setResult("Dữ liệu nhập không hợp lệ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tính Tỷ Lệ Tăng Trưởng")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tính toán 1
            Text("Tính toán 1", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: pvController1, decoration: InputDecoration(labelText: 'Giá trị hiện tại (PV)')),
            TextField(controller: fvController1, decoration: InputDecoration(labelText: 'Giá trị tương lai (FV)')),
            TextField(controller: nController1, decoration: InputDecoration(labelText: 'Số kỳ (N)')),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => calculateGrowthRate(pvController1, fvController1, nController1, (res) => setState(() => result1 = res)),
              child: Text('Tính Tỷ Lệ Tăng Trưởng 1'),
            ),
            Text(result1, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Divider(thickness: 2, height: 30),

            // Tính toán 2
            Text("Tính toán 2", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: pvController2, decoration: InputDecoration(labelText: 'Giá trị hiện tại (PV)')),
            TextField(controller: fvController2, decoration: InputDecoration(labelText: 'Giá trị tương lai (FV)')),
            TextField(controller: nController2, decoration: InputDecoration(labelText: 'Số kỳ (N)')),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => calculateGrowthRate(pvController2, fvController2, nController2, (res) => setState(() => result2 = res)),
              child: Text('Tính Tỷ Lệ Tăng Trưởng 2'),
            ),
            Text(result2, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Divider(thickness: 2, height: 30),

            // Tính toán 3
            Text("Tính toán 3", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: pvController3, decoration: InputDecoration(labelText: 'Giá trị hiện tại (PV)')),
            TextField(controller: fvController3, decoration: InputDecoration(labelText: 'Giá trị tương lai (FV)')),
            TextField(controller: nController3, decoration: InputDecoration(labelText: 'Số kỳ (N)')),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => calculateGrowthRate(pvController3, fvController3, nController3, (res) => setState(() => result3 = res)),
              child: Text('Tính Tỷ Lệ Tăng Trưởng 3'),
            ),
            Text(result3, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
