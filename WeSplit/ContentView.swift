//
//  ContentView.swift
//  WeSplit
//
//  Created by Leo  on 30.10.23.
//

// ContentView.swift contains the initial user interface (UI) for your program, and is where we’ll be doing all the work in this project.



import SwiftUI  // import all that comes with the SwiftUI framework

struct ContentView: View {  // View is a protocol by SwiftUI -> buttons etc.
  
    @State private var checkAmount = 0.0 // @State automaticly watches for chances
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var total: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")) // checkt die lokale Währung, guckt ob ein Identifier dafür vorliegt. Wenn ja, spuckt er den aus (wie hier €), wenn nicht gehen wir auf Nummer sicher und geben USD aus
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                //    .pickerStyle(.navigationLink) another possebility
                }
                
                Section("How much do you want to tip?") {
                    
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<100) {
                            Text("\($0) % tip")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total Amount") {
                    Text(total, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                
                Section("Total per Person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit") // you have to attache this to the thing inside the NavigationStack
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview { // just for design time -> when it's shiped it get's deleeted
    ContentView()
}
