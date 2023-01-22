//
//  InfoView.swift
//  VitaTable
//
//  Created by Collin Gray on 1/21/23.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        NavigationView {
            Text("Hello")
        }
        .navigationTitle(Text("Info"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
