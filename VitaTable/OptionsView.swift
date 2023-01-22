//
//  File.swift
//  VitaTable
//
//  Created by Collin Gray on 1/6/23.
//

import SwiftUI

struct OptionsView: View {
    enum Timespan: String, CaseIterable, Identifiable {
        case D, W, M
        var id: Self { self }
    }

    @State private var selectedTimespan: Timespan = .D
    
    private struct CombinedShape: Shape {
        var shapes: [any Shape]

        func path(in rect: CGRect) -> Path {
            var combinedPath = Path()

            for shape in shapes {
                let path = shape.path(in: rect)
                combinedPath.addPath(path)
            }

            return combinedPath
        }
    }
    
    private func specialButtonShape(reverse: Bool) -> some Shape {
        let reverseMultiplier = reverse ? -1.0 : 1.0
        
        let shapes: [any Shape] = [
            Capsule().offset(x: (-25 * reverseMultiplier))
//            Rectangle().offset(x: -20.0)
        ]

        return CombinedShape(shapes: shapes)
    }
    
    var body: some View {
        HStack {
            Picker("Timespan", selection: $selectedTimespan) {
                Text("D").tag(Timespan.D)
                Text("W").tag(Timespan.W)
                Text("M").tag(Timespan.M)
            }.padding(.horizontal, 60.0).pickerStyle(.segmented)
        }
    }
}
