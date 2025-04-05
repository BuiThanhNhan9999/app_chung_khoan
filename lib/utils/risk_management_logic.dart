Map<String, String> calculateRiskManagement(
    String capital, String buyPrice, String riskTarget, String percentGrowth) {
  double cap = double.tryParse(capital) ?? 0;
  double buy = double.tryParse(buyPrice) ?? 0;
  double risk = (double.tryParse(riskTarget) ?? 0) / 100;
  double growth = (double.tryParse(percentGrowth) ?? 0) / 100;

  // Tính toán
  double stopLoss = buy - (buy * 0.05);
  double takeProfit65 = buy + (buy * 0.065);
  double takeProfit10 = buy + (buy * 0.10);

  double lossPerShare = buy - stopLoss; // Số tiền lỗ cho mỗi cổ phiếu
  double riskAmount = cap * risk; // Rủi ro của mã cổ phiếu A

  double numShares = riskAmount / lossPerShare; // Số lượng cổ phiếu có thể mua
  double numStocksHold = cap / (numShares * buy); // Số mã cổ phiếu có thể nắm giữ
  double numInvestments = growth / 0.0057; // Số vụ đầu tư trên 1 năm

  return {
    "stopLoss": stopLoss.toStringAsFixed(2),
    "takeProfit65": takeProfit65.toStringAsFixed(2),
    "takeProfit10": takeProfit10.toStringAsFixed(2),
    "numShares": numShares.isFinite ? numShares.toStringAsFixed(2) : "0",
    "numStocksHold": numStocksHold.isFinite ? numStocksHold.toStringAsFixed(2) : "0",
    "numInvestments": numInvestments.isFinite ? numInvestments.toStringAsFixed(2) : "0",
  };
}
