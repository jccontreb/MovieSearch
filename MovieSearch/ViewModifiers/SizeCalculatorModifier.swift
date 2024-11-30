//
//  SizeCalculatorModifier.swift
//  MovieSearch
//
//  Created by jcontreras on 29/11/24.
//

import SwiftUI

// MARK: - SizeCalculatorModifier

fileprivate struct SizeCalculatorModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding var size: CGSize
    
    // MARK: - Methods
    
    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { geometry in
                    Color.clear
                        .onAppear { size = geometry.size }
                }
            }
    }
    
}

// MARK: - View

extension View {
    
    func saveSize(in size: Binding<CGSize>) -> some View {
        self.modifier(SizeCalculatorModifier(size: size))
    }
    
}

