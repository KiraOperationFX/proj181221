//
//  HomeVM.swift
//  proj181221
//
//  Created by Kira on 25/12/2021.
//

import Foundation

protocol HomeVMProtocol {
    func getData(index: Int) -> HomeM?
}

protocol HomeVMEvent: AnyObject {
    
}

final class HomeVM: HomeVMProtocol {
    private var homeData: [HomeM] = [
        HomeM(icon: R.image.vfdsbvbefs()!, label: "Color Titration"),
        HomeM(icon: R.image.gvbefsfvaaev()!, label: "Brightness"),
        HomeM(icon: R.image.vegrsesagreas()!, label: "Touch"),
        HomeM(icon: R.image.cdsvaewvddws()!, label: "Vibration"),
        HomeM(icon: R.image.fveargvesarbve()!, label: "Biometrics")
    ]
    
    init() {
        
    }
    
    func getData(index: Int) -> HomeM? {
        return homeData[safeIndex: index]
    }
    
}
