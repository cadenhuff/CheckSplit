//
//  ContentView.swift
//  WeSplit
//
//  Created by Caden Huffman on 7/2/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    var useRedText: Bool {
        if(tipPercentage == 0){
            return true
        }
        return false
    }
    let tipPercentages = [0,5,10,20,25]
    var totalPlusTip: Double{
        let tipValue = checkAmount / 100 * Double(tipPercentage)
        let total = checkAmount + tipValue
        return total
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

        NavigationView{
            Form{
                Section{
                    TextField("Amount",value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of People", selection: $numberOfPeople){
                        ForEach(2..<100){
                        
                            Text("\($0) people")
                        }
                    }
                    
                }
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0..<101){
                            Text($0, format: .percent)
                            
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header:{
                    Text("How much do you want to tip?")
                }
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Amount Per Person")
                }
                Section{
                    Text(totalPlusTip, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .background(useRedText ? .red : .clear)
                } header: {
                    Text("Total Amount plus Tip")
                        
                }
                
                
                

            }
            .navigationTitle("Check")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
