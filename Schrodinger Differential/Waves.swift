//
//  Waves.swift
//  Test Plot Threaded
//
//  Created by IIT phys 440 on 3/2/23.
//

import  SwiftUI

class Wavefunctions: ObservableObject {
    @Published var wavefunction = [(xPoint: Double, PsiPoint: Double)] ()
    @Published var waveOneDerivative = [(xPoint: Double, PsiPrimePoint: Double)]()
    @Published var waveTwoDerivative = [(xPoint: Double, PsiTwoPrimePoint: Double)]()
}
