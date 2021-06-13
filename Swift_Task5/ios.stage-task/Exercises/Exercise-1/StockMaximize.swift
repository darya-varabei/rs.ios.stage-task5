import Foundation

class StockMaximize {

    func countProfit(prices: [Int]) -> Int {
        var totalProfit: Int = 0
        var startCount: Int = 0
        var finishCount: Int = 0
        
        if prices.isEmpty || prices.count == 1{
            return 0
        }
        else{
            for i in 0...prices.count - 1 {
                if (i != prices.count - 1 && prices[i] > prices[i+1]) || (i == prices.count - 1){
                    finishCount = i
                    for j in startCount...finishCount{
                        totalProfit = totalProfit + prices[finishCount] - prices[j]
                    }
                    startCount = i + 1
                }
            }
        }
        return totalProfit
    }
}
