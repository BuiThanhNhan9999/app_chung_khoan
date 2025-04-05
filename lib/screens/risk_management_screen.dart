import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/calculate_button.dart';
import '../widgets/result_display.dart';
import '../utils/risk_management_logic.dart';

class RiskManagementScreen extends StatefulWidget {
  @override
  _RiskManagementScreenState createState() => _RiskManagementScreenState();
}

class _RiskManagementScreenState extends State<RiskManagementScreen> {
  final TextEditingController capitalController = TextEditingController();
  final TextEditingController buyPriceController = TextEditingController();
  final TextEditingController riskTargetController = TextEditingController();
  final TextEditingController percentGrowthController = TextEditingController();

  String stopLossPrice = "";
  String takeProfit65Price = "";
  String takeProfit10Price = "";
  String numShares = "";
  String numStocksHold = "";
  String numInvestments = "";

  void _calculateRisk() {
    setState(() {
      final result = calculateRiskManagement(
        capitalController.text,
        buyPriceController.text,
        riskTargetController.text,
        percentGrowthController.text,
      );

      stopLossPrice = result["stopLoss"]!;
      takeProfit65Price = result["takeProfit65"]!;
      takeProfit10Price = result["takeProfit10"]!;
      numShares = result["numShares"]!;
      numStocksHold = result["numStocksHold"]!;
      numInvestments = result["numInvestments"]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quản lý rủi ro")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(label: "Số tiền vốn", controller: capitalController),
            CustomTextField(label: "Giá mua cổ phiếu A", controller: buyPriceController),
            SizedBox(height: 10),
            ResultDisplay(label: "Giá cắt lỗ 5%", value: stopLossPrice),
            ResultDisplay(label: "Giá chốt lời 6.5%", value: takeProfit65Price),
            ResultDisplay(label: "Giá chốt lời 10%", value: takeProfit10Price),
            SizedBox(height: 10),
            CustomTextField(label: "Rủi ro mục tiêu (%)", controller: riskTargetController),
            CustomTextField(label: "Số % vốn muốn tăng lên", controller: percentGrowthController),
            SizedBox(height: 10),
            CalculateButton(label: "Tính toán rủi ro", onPressed: _calculateRisk),
            SizedBox(height: 10),
            ResultDisplay(label: "Số lượng cổ phiếu A có thể mua", value: numShares),
            ResultDisplay(label: "Số mã cổ phiếu có thể nắm giữ", value: numStocksHold),
            ResultDisplay(label: "Số vụ đầu tư trên 1 năm", value: numInvestments),
          ],
        ),
      ),
    );
  }
}
