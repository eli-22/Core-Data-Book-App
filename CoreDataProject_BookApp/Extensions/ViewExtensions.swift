//
//  ViewExtensions.swift
//  CoreDataProject
//
//  Created by Elise on 11/21/22.
//

import Foundation
import SwiftUI

extension View {
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
}
