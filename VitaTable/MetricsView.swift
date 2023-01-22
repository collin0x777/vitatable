//
//  MetricsView.swift
//  VitaTable
//
//  Created by Collin Gray on 1/6/23.
//

import SwiftUI
import Charts

struct MetricsView: View {
    struct ValuePerCategory {
        var category: String
        var value: Double
    }

    let macronutrientData: [ValuePerCategory] = [
        .init(category: "Protein", value: 1),
        .init(category: "Carbs", value: 2),
        .init(category: "Fats", value: 3),
        .init(category: "Fiber", value: 4),
        .init(category: "E", value: 5),
        .init(category: "F", value: 100),
        .init(category: "R", value: 100)
    ]
    
    let mineralData: [ValuePerCategory] = [
        .init(category: "Calcium", value: 1),
        .init(category: "Chlorine", value: 2),
        .init(category: "Magnesium", value: 3),
        .init(category: "Phosphorous", value: 4),
        .init(category: "Potassium", value: 5),
        .init(category: "Sodium", value: 100),
        .init(category: "Iron", value: 100)
    ]
    
    let vitaminData: [ValuePerCategory] = [
        .init(category: "A", value: 1),
        .init(category: "C", value: 2),
        .init(category: "D", value: 3),
        .init(category: "E", value: 4),
        .init(category: "B6", value: 100),
        .init(category: "B12", value: 3),
        .init(category: "Folate", value: 5)
    ]
    
    var body: some View {
        TabView {
            VStack {
                HStack {
                    Text("Macronutrients").font(.headline)
                    Spacer()
                }
                Chart(macronutrientData, id: \.category) { item in
                    BarMark(
                        x: .value("Category", item.category),
                        y: .value("Value", item.value)
                    )
                    RuleMark(y: .value("Average nutrients", 4))
                        .foregroundStyle(.red)
                }
                .chartYAxis(.hidden)
            }
            VStack {
                HStack {
                    Text("Minerals").font(.headline)
                    Spacer()
                }
                Chart(mineralData, id: \.category) { item in
                    BarMark(
                        x: .value("Category", item.category),
                        y: .value("Value", item.value)
                    )
                    RuleMark(y: .value("Average nutrients", 4))
                        .foregroundStyle(.red)
                }
                .chartYAxis(.hidden)
            }
            VStack {
                HStack {
                    Text("Vitamins").font(.headline)
                    Spacer()
                }
                Chart(vitaminData, id: \.category) { item in
                    BarMark(
                        x: .value("Category", item.category),
                        y: .value("Value", item.value)
                    )
                    RuleMark(y: .value("Average nutrients", 4))
                        .foregroundStyle(.red)
                }
                .chartYAxis(.hidden)
            }
        }.padding().tabViewStyle(.page(indexDisplayMode: .never))
    }
}
