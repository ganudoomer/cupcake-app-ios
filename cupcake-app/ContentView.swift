//
//  ContentView.swift
//  cupcake-app
//
//  Created by Sree on 24/10/21.
//

import SwiftUI




struct ContentView: View {
    @ObservedObject var order = Order()
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Picker("Select you cake type",selection: $order.type){
                        ForEach(0..<Order.types.count){
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.quantity, in: 3...20){
                        Text("Number of cakes \(order.quantity)")
                    }
                    
                    Section{
                        Toggle(isOn: $order.specialRequestEnabled.animation()){
                            Text("Any special request ?")
                        }
                        if order.specialRequestEnabled {
                            Toggle(isOn: $order.extraFrosting){
                                Text("Add extra frosting")
                            }
                            Toggle(isOn: $order.addSprinkles){
                                Text("Add extra sprinkles")
                            }
                        }
                    }
                    Section{
                        NavigationLink(destination: AddressView(order: order)){
                            Text("Delivery Details")
                        }
                    }
                    
                }
            }.navigationBarTitle("Cupckae corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @ObservedObject var order = Order()
    static var previews: some View {
        ContentView()
    }
}
