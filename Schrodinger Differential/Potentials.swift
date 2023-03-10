//
//  Potentials.swift
//  Assignment 5 - Schrodinger Eqn 
//
//  Created by IIT phys 440 on 3/8/23.
//

import SwiftUI

class Potentials: ObservableObject {
    @Published var potential = [Double]()
    @Published var x = [Double]()
    var infinity = 10000000.0
    
    func infiniteSquareWellPotential(xMin: Double, xMax: Double, xstep: Double) {
        
        x.append(xMin)
        potential.append(infinity)
        
        
        
        for X in stride(from: xMin+xstep, to: xMax, by: xstep){
            
            x.append(X)
            potential.append(0.0)
           
        }
        x.append(xMax)
        potential.append(infinity)
    
    }
}

