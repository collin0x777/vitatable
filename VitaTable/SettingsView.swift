//
//  SettingsView.swift
//  VitaTable
//
//  Created by Collin Gray on 1/6/23.
//

import SwiftUI

struct SettingsView: View {
    
    struct NutritionalTarget: Identifiable {
        let id: Int
        let name: String
        let units: String
        let min: Float
        let max: Float
        let step: Float
        var value: Float
    }
    
    @State var vibrateOnScan = true
    
    
    enum Theme {
        case system, light, dark
    }
    @State var selectedTheme: Theme = Theme.system
    
    enum Preset {
        case cutting, balanced, bulking
    }
    @State var selectedPreset: Preset? = Preset.balanced
    
    @State var nutritionalTargets = [
        NutritionalTarget(id: 0, name: "Calories", units: "", min: 1000, max: 5000, step: 100, value: 2000),
        NutritionalTarget(id: 1, name: "Protein", units: "g", min: 50, max: 300, step: 10, value: 75),
        NutritionalTarget(id: 2, name: "Fat", units: "g", min: 20, max: 100, step: 5, value: 40),
        NutritionalTarget(id: 3, name: "Carbohydrates", units: "g", min: 100, max: 500, step: 10, value: 250),
        NutritionalTarget(id: 4, name: "Fiber", units: "g", min: 25, max: 40, step: 5, value: 30),
        NutritionalTarget(id: 5, name: "Sugar", units: "g", min: 0, max: 100, step: 10, value: 25),
        NutritionalTarget(id: 6, name: "Saturated Fat", units: "g", min: 0, max: 20, step: 2, value: 8),
        NutritionalTarget(id: 7, name: "Cholesterol", units: "mg", min: 0, max: 300, step: 25, value: 300),
        NutritionalTarget(id: 8, name: "Sodium", units: "mg", min: 0, max: 2400, step: 100, value: 1500),
        NutritionalTarget(id: 9, name: "Vitamin A", units: "IU", min: 1000, max: 5000, step: 250, value: 5000),
        NutritionalTarget(id: 10, name: "Vitamin C", units: "mg", min: 75, max: 200, step: 25, value: 100),
        NutritionalTarget(id: 11, name: "Vitamin D", units: "IU", min: 400, max: 1000, step: 50, value: 600),
        NutritionalTarget(id: 12, name: "Vitamin E", units: "IU", min: 15, max: 50, step: 5, value: 30),
        NutritionalTarget(id: 13, name: "Vitamin K", units: "mcg", min: 75, max: 200, step: 25, value: 120),
        NutritionalTarget(id: 14, name: "Thiamin", units: "mg", min: 1, max: 2, step: 0.1, value: 1.5),
        NutritionalTarget(id: 15, name: "Riboflavin", units: "mg", min: 1, max: 2, step: 0.1, value: 1.7),
        NutritionalTarget(id: 16, name: "Niacin", units: "mg", min: 10, max: 50, step: 2, value: 20),
        NutritionalTarget(id: 17, name: "Vitamin B6", units: "mg", min: 1, max: 2, step: 0.1, value: 1.3),
        NutritionalTarget(id: 18, name: "Folate", units: "mcg", min: 400, max: 800, step: 50, value: 600),
        NutritionalTarget(id: 19, name: "Vitamin B12", units: "mcg", min: 2.4, max: 10, step: 0.5, value: 2.4),
        NutritionalTarget(id: 20, name: "Calcium", units: "mg", min: 1000, max: 2000, step: 100, value: 1000),
        NutritionalTarget(id: 21, name: "Iron", units: "mg", min: 8, max: 18, step: 1, value: 18),
        NutritionalTarget(id: 22, name: "Magnesium", units: "mg", min: 400, max: 800, step: 50, value: 420),
        NutritionalTarget(id: 23, name: "Phosphorus", units: "mg", min: 700, max: 1000, step: 50, value: 700),
        NutritionalTarget(id: 24, name: "Potassium", units: "mg", min: 3500, max: 4700, step: 100, value: 3500),
        NutritionalTarget(id: 25, name: "Zinc", units: "mg", min: 8, max: 15, step: 1, value: 11),
        NutritionalTarget(id: 26, name: "Copper", units: "mg", min: 0.9, max: 2, step: 0.1, value: 1.2),
        NutritionalTarget(id: 27, name: "Manganese", units: "mg", min: 2, max: 5, step: 0.5, value: 2.3),
        NutritionalTarget(id: 28, name: "Selenium", units: "mcg", min: 55, max: 200, step: 10, value: 55),
    ]
    
    @State var restoreDefaults = false
    @State var deleteData = false
        
    struct NutritionalTargetStepper: View {
        @Binding var target: NutritionalTarget
        
        var body: some View {
            Stepper(
                "\(String(format: "%g", target.value))\(target.units) \(target.name)",
                value: $target.value,
                in: target.min...target.max,
                step: target.step
            )
        }
    }
    
    struct PresetButton: View {
        @Binding var selectedPreset: Preset?
        let label: String
        let iconName: String
        let personalPreset: Preset
        
        @State var customTargetsPresent = false
                
        var body: some View {
            
            
            Button {
                customTargetsPresent = (selectedPreset == nil)
                
                if (!customTargetsPresent) {
                    selectedPreset = Optional.some(personalPreset)
                }
                
                
            } label: {
                VStack {
                    Image(systemName: iconName)
                        .foregroundColor(selectedPreset == personalPreset ? .blue : .gray)
                        .font(.largeTitle)
                    Text(label)
                        .foregroundColor(selectedPreset == personalPreset ? Color(UIColor.systemBackground) : Color.primary)
                        .padding(.horizontal, 10.0)
                        .padding(.vertical, 5.0)
                        .background(
                            Capsule()
                                .foregroundColor(selectedPreset == personalPreset ? .blue : Color(UIColor.secondarySystemGroupedBackground))
                        )
                }
            }
            .buttonStyle(.borderless)
            .alert(isPresented: $customTargetsPresent) {
                Alert(
                    title: Text("Choosing this preset will clear your custom targets, would you like to continue?"),
                    message: Text("This action cannot be undone"),
                    primaryButton: .default(Text("Continue"), action: {
                        selectedPreset = Optional.some(personalPreset)
                    }),
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("General") {
                    Toggle(isOn: $vibrateOnScan) {
                        Text("Vibrate on scan")
                    }
                    Picker(selection: $selectedTheme, label: Text("Theme")) {
                        Text("System").tag(Theme.system)
                        Text("Light").tag(Theme.light)
                        Text("Dark").tag(Theme.dark)
                    }
                }
                
                Section("Nutrition target presets") {
                    HStack {
                        PresetButton(selectedPreset: $selectedPreset, label: "Cutting", iconName: "gauge.low", personalPreset: Preset.cutting)
                        Spacer()
                        PresetButton(selectedPreset: $selectedPreset, label: "Balanced", iconName: "gauge.medium", personalPreset: Preset.balanced)
                        Spacer()
                        PresetButton(selectedPreset: $selectedPreset, label: "Bulking", iconName: "gauge.high", personalPreset: Preset.bulking)
                    }
                }
                
                Section(header: Text("Custom Nutrition Targets"), footer: Text("Hello")) {
                    
                    ForEach($nutritionalTargets) { nutritionalTarget in
                        NutritionalTargetStepper(target: nutritionalTarget)
                    }
                    
//                    Button("Restore defaults") {
//                        restoreDefaults = true
//                    }.alert(isPresented: $restoreDefaults) {
//                        Alert(
//                            title: Text("Are you sure that you want to restore all default targets?"),
//                            message: Text("This action cannot be undone"),
//                            primaryButton: .default(Text("Restore")),
//                            secondaryButton: .cancel()
//                        )
//                    }
                }
                
                
                Button("Delete scanned items", role: .destructive) {
                    deleteData = true
                }.alert(isPresented: $deleteData) {
                    Alert(
                        title: Text("Are you sure that you want to delete all scanned items?"),
                        message: Text("This action cannot be undone"),
                        primaryButton: .destructive(Text("Delete")),
                        secondaryButton: .cancel()
                    )
                }
            }.navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
