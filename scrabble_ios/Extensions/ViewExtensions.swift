//
//  ViewExtensions.swift
//  scrabble_ios
//
//  Created by Максим Троицкий on 15.06.2024.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func hSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    func vSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}
