import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/custom_text_field.dart';
import '../widgets/calculate_button.dart';
import '../widgets/result_display.dart';

class StockValuationScreen extends StatefulWidget {
  @override
  _StockValuationScreenState createState() => _StockValuationScreenState();
}

class _StockValuationScreenState extends State<StockValuationScreen> {
  TextEditingController pvController = TextEditingController();
  TextEditingController fvController = TextEditingController();
  TextEditingController nController = TextEditingController();
  TextEditingController safeRateController = TextEditingController();
  TextEditingController sharesController = TextEditingController();
  String finalStockValue = "";

  void calculateStockValue() {
    double? pv = double.tryParse(pvController.text);
    double? fv = double.tryParse(fvController.text);
    double? n = double.tryParse(nController.text);
    double? safeRate = double.tryParse(safeRateController.text);
    double? shares = double.tryParse(sharesController.text);

    if (pv != null && fv != null && n != null && safeRate != null && shares != null && pv > 0 && n > 0 && shares > 0) {
      double adjustedSafeRate = safeRate / 100; // Chia Tỷ lệ an toàn cho 100
      double rate = pow(fv / pv, 1 / n) - 1;

      List<double> futureValues = [];
      List<double> discountFactors = [];
      double discountedSum = 0;

      double currentValue = fv;
      for (int i = 1; i <= 10; i++) {
        currentValue *= (1 + rate);
        futureValues.add(currentValue);
        double discountFactor = 1 / pow(1 + adjustedSafeRate, i);
        discountFactors.add(discountFactor);
        discountedSum += currentValue * discountFactor;
      }

      double stockValue = discountedSum / (shares / 1000);
      setState(() {
        finalStockValue = "Giá trị cổ phiếu: ${stockValue.toStringAsFixed(2)} VNĐ";
      });
    } else {
      setState(() {
        finalStockValue = "Dữ liệu nhập không hợp lệ";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Định Giá Cổ Phiếu")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(controller: pvController, label: 'Giá trị hiện tại (PV)'),
              CustomTextField(controller: fvController, label: 'Giá trị tương lai (FV)'),
              CustomTextField(controller: nController, label: 'Số kỳ (N)'),
              CustomTextField(controller: safeRateController, label: 'Tỷ lệ an toàn (%)'),
              CustomTextField(controller: sharesController, label: 'Số lượng cổ phiếu lưu hành'),
              CalculateButton(label: 'Tính giá trị cổ phiếu', onPressed: calculateStockValue),
              ResultDisplay(label: "Kết quả", value: finalStockValue),
            ],
          ),
        ),
      ),
    );
  }
}
