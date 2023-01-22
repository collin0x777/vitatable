//
//  MainView.swift
//  VitaTable
//
//  Created by Collin Gray on 1/6/23.
//

import SwiftUI

let globalRadius: CGFloat = 10

struct MainView: View {
    @State var infoPopover = false
    
    var body: some View {
        NavigationStack {
            
            VStack {
                ScannerView()
                MetricsView()
                OptionsView()
                CartView()
            }
            .padding(.all)
            .navigationTitle("VitaTable")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear").padding(.all)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button {
                        infoPopover = true
                    } label: {
                        Image(systemName: "info.circle").padding(.all)
                    }.sheet(
                        isPresented: $infoPopover,
                        content: {
                            NavigationView {
                                InfoView()
                                    .toolbar {
                                        Button("Done") {
                                            infoPopover = false
                                        }
                                    }
                            }
                        }
                    )
                }
            }
        }.preferredColorScheme(.none) // todo: take this from state
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
