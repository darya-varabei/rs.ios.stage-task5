import Foundation

public typealias Supply = (weight: Int, value: Int)

typealias crossJoin = (food: Supply, drink: Supply, minEnergy: Int)


public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func findMaxKilometres() -> Int {
        var result: [crossJoin] = []
        var result1: [crossJoin] = []
        var result2: [crossJoin] = []
        var result1Var: crossJoin = (food: (weight: 0, value: 0), drink: (weight: 0, value: 0), minEnergy: 0)
        var item: crossJoin
        var maxKilometers = 0
        
        for i in 0..<foods.count{
            for j in 0..<drinks.count{
                item.food = foods[i]
                item.drink = drinks[j]
                if foods[i].value < drinks[j].value{
                    item.minEnergy = foods[i].value
                }
                else{
                    item.minEnergy = drinks[j].value
                }
                result.append(item)
            }
        }
        
        var counter = 0
        var basic: [Int] = [0]
        
        for item in result{
            
            if item.food.weight + item.drink.weight <= maxWeight{
                result1.append(item)
            }
        }
        
        for i in 0..<result1.count{
            basic.append(result1[i].minEnergy)
        }
        
        maxKilometers = basic.max() ?? 0
        
        for item in result1{
            if item.minEnergy == maxKilometers{
            result1Var = item
            }
        }
        
        
        for item in result1{
            if item.drink != result1Var.drink && item.food != result1Var.food{
                result2.append(item)
            }
        }
        
        var bufferWeight = result1Var.drink.weight + result1Var.food.weight
        
        for item in result2{
            if item.food.weight + item.drink.weight <= maxWeight - bufferWeight{
                if item.food.value < item.drink.value{
                    maxKilometers += item.food.value
                }
                else{
                    maxKilometers += item.drink.value
                }
                
                bufferWeight += item.drink.weight + item.food.weight
                var temp = result2
                for j in result2{
                    if (item.drink != j.drink && item.food != j.food){
                        temp.append(j)
                    }
                }
                result2 = temp
            }
        }
        
        for item in drinks{
            if (result1Var.food.value - result1Var.drink.value >= item.value) && ((bufferWeight+item.weight) <= maxWeight){
                maxKilometers += item.value
                bufferWeight += item.weight
            }
        }
        
        for item in foods{
            if (result1Var.drink.value - result1Var.food.value > item.value) && ((bufferWeight+item.weight) <= bufferWeight){
                maxKilometers += item.value
                bufferWeight += item.weight
            }
        }

        return maxKilometers
    }
}
