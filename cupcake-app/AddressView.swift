//
//  AddressView.swift
//  cupcake-app
//
//  Created by Sree on 24/10/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    var body: some View {
        Form{
            Section{
                TextField("Name",text: $order.data.name)
                TextField("Steet Address",text: $order.data.streetAddress)
                TextField("City",text: $order.data.city)
                TextField("Zip",text: $order.data.zip)
            }
            
            Section{
                NavigationLink(
                    destination: checkoutView(order: order)){
                    Text("Checkout ")
                }
            }.disabled(order.hasValidAddress == false)
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
