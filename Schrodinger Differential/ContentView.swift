//
//  ContentView.swift
//  Schrodinger Differential
//
//  Created by IIT phys 440 on 3/8/23.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    
    @ObservedObject var functionalInstance = Functional()
    @ObservedObject var potentialInstance = Potentials()
    @ObservedObject var waveFunctionInstance = Wavefunctions()
    
    @State var Checkbool:Bool = false
    @State var Input = ""
    @State var Select = 0
    
    
    var xMin = 0.0
    var xMax = 10.0
    var Emin = 0.0
    var EminString = "0"
    var Emax = 30.0
    var EmaxString = "10"
    var Estep = 0.05
    var step = 10.0
    var hBarBase = 1.112121
    var psi0 = 0.0
   
  
    
    var hbar = 0.1973269804
    var mElectron = 510998.950
    var Potential = 0.0
    
    var deltaX = 0.01
    var infinity = 10000000.0
    @State var deltaXString = ""
    
    var body: some View {
        VStack {
            Button("Execute Function") {
               
                findWaveFunctions()
            }
            .padding()
        }
    }
    
    
    
    
        func findWaveFunctions() {
        // Define the functionality of your function here
        
        let schrodingerConstant = ((-2 * mElectron) / pow(hbar, 2.0)) * pow(1E-4,2)
        
        
        
        potentialInstance.infiniteSquareWellPotential(xMin: xMin, xMax: xMax, xstep: deltaX)
        print("Button clicked, function executed!")
  //      print(potentialInstance.x, potentialInstance.potential)
        
        
        
        

        
        
        
        let numberOfXSteps = Int((xMax - xMin ) / deltaX )
            let psiOfXMax = 0.0
        
        
        for energy in stride(from: Emin, through: Emax, by: Estep){
            
          
            waveFunctionInstance.wavefunction = []
            waveFunctionInstance.waveOneDerivative = []
            waveFunctionInstance.waveTwoDerivative = []
           
            
            
            waveFunctionInstance.wavefunction.append((xPoint: xMin, PsiPoint: 0.0))
            waveFunctionInstance.waveOneDerivative.append((xPoint: xMin, PsiPrimePoint: 7.0))
            
            let psindoubleprime = schrodingerConstant * waveFunctionInstance.wavefunction[0].PsiPoint * (energy - potentialInstance.potential[0])
            waveFunctionInstance.waveTwoDerivative.append((xPoint: xMin, PsiTwoPrimePoint: psindoubleprime))
            

 
            for i in 1...(numberOfXSteps)  {
                let x = xMin + Double(i) * deltaX
                let psiOfI = waveFunctionInstance.wavefunction[i-1].PsiPoint + waveFunctionInstance.waveOneDerivative[i-1].PsiPrimePoint * deltaX
                waveFunctionInstance.wavefunction.append((xPoint: x, PsiPoint: psiOfI))
                let psiPrimeOfI = waveFunctionInstance.waveOneDerivative[i-1].PsiPrimePoint + waveFunctionInstance.waveTwoDerivative[i-1].PsiTwoPrimePoint * deltaX
                waveFunctionInstance.waveOneDerivative.append((xPoint: x, PsiPrimePoint: psiPrimeOfI))
                let psiTwoPrimeOfI = schrodingerConstant * waveFunctionInstance.wavefunction[i-1].PsiPoint * (energy - potentialInstance.potential[i-1])
                waveFunctionInstance.waveTwoDerivative.append((xPoint: x, PsiTwoPrimePoint: psiTwoPrimeOfI))
                
                
                
                
                
            }
            let myCount = waveFunctionInstance.wavefunction.count
            let Functional = waveFunctionInstance.wavefunction[myCount-1].PsiPoint - psiOfXMax
            functionalInstance.functionalData.append((energyPoint: energy, FunctionalPoint: Functional))
            
            
            
            
        }
            print(functionalInstance.functionalData)
            
            
    }
    
    
    
    
    
    
    
    
    
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


