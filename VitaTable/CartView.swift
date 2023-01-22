//
//  CartView.swift
//  VitaTable
//
//  Created by Collin Gray on 1/6/23.
//

import SwiftUI

struct CartView: View {
    struct cartItem: Identifiable {
        let id = UUID()
        let name: String
        var count: Int = 1
        
        mutating func incrementCount()  {
            count += 1
        }
        
        mutating func decrementCount() {
            count -= 1
        }
    }
    
    @State var isEditMode: EditMode = .inactive
    
    @State private var addedItems: [cartItem] = [
        cartItem(name: "🥨 Pretzel"),
        cartItem(name: "🥑 Avocado", count: 3),
//        cartItem(name: "🫐 Blueberries"),
//        cartItem(name: "🍣 Sushi"),
//        cartItem(name: "🥜 Peanuts"),
//        cartItem(name: "🍺 Beer"),
//        cartItem(name: "🥫 Tomato Soup"),
//        cartItem(name: "🥝 Kiwi"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango"),
//        cartItem(name: "🥭 Mango")
    ]
    
    struct DrawnItem: View {
        @Binding var item: cartItem
        @Binding var mode: EditMode
        
        var body: some View {
            HStack {
                Text((item.count > 1) ? "\(item.name) x\(item.count)" : item.name)
                
                if (mode == .active) {
                    Stepper(value: $item.count, in: 1...99) { }
                }
            }
        }
    }
        
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach($addedItems) { addedItem in
                        DrawnItem(item: addedItem, mode: $isEditMode)
                    }.onDelete { addedItems.remove(atOffsets: $0) }
                }
                .listStyle(PlainListStyle())
                .toolbar{ EditButton() }
                .environment(\.editMode, self.$isEditMode)
                .cornerRadius(globalRadius)

                if (addedItems.isEmpty) {
                    Text("No items have been scanned yet")
                        .font(.footnote)
                }
            }
            .navigationTitle("Recently added")
            .navigationBarTitleDisplayMode(.inline)
        }
        .padding(.top)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
