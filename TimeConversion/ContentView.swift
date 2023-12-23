//
//  ContentView.swift
//  TimeConversion
//
//  Created by Woodrow Martyr on 23/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = ""
    @State private var outputUnit = ""
    @State private var inputValue = 0
    @FocusState private var inputFieldIsFocused:Bool
    
    let units = ["seconds", "minutes", "hours", "days"]
    
    var inSeconds: Int {
        switch inputUnit {
        case "minutes":
            return inputValue * 60
        case "hours":
            return inputValue * 3600
        case "days":
            return inputValue * 86400
        default:
            return inputValue
        }
    }
    
    var finalValue: Double {
        switch outputUnit {
        case "minutes":
            return Double(inSeconds) / 60
        case "hours":
            return Double(inSeconds) / 3600
        case "days":
            return Double(inSeconds) / 86400
        default:
            return Double(inSeconds)
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Enter Time") {
                    TextField("Value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputFieldIsFocused)
                    Picker("Input Time Unit", selection: $inputUnit) {
                        ForEach(units, id:\.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Result") {
                    Text(finalValue, format: .number)
                    Picker("Output Time Unit", selection: $outputUnit) {
                        ForEach(units, id:\.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
            }
            .navigationTitle("Time Converter")
            .toolbar {
                if inputFieldIsFocused {
                    Button("Done") {
                        inputFieldIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
