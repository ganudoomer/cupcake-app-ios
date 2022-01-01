//
//  checkoutView.swift
//  cupcake-app
//
//  Created by Sree on 24/10/21.
//

import SwiftUI

struct checkoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var titleMessage = ""
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(decorative:"cupcakes")
                        
                        .resizable().scaledToFit().frame(width: geo.size.width)
                    Text("Your order is $\(self.order.cost,specifier: "%.2f")").font(.title)
                    Button("Place"){
                        self.placeOrder()
                    }.padding()
                }
            }
        }.navigationBarTitle("Check out",displayMode: .inline).alert(isPresented: $showingConfirmation, content: {
            Alert(title: Text(titleMessage),message: Text(confirmationMessage),dismissButton: .default(Text("Ok")))
        })
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to enode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json",forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) {
            data, resonse , error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unkown error")")
                self.confirmationMessage = error?.localizedDescription ?? "Unkown error"
                self.titleMessage = "Error"
                self.showingConfirmation = true
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(Order.self,from:data){
                self.confirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on the way \(decodedOrder.data.city) "
                self.titleMessage = "Thank you"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server ")
            }
        }.resume()
    }
}

struct checkoutView_Previews: PreviewProvider {
    static var previews: some View {
        checkoutView(order: Order())
    }
}
