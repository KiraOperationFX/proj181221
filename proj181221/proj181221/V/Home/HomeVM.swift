//
//  HomeVM.swift
//  proj181221
//
//  Created by Kira on 25/12/2021.
//

import Foundation

protocol HomeVMProtocol {
    func countTotalItem() -> Int
    func getData(index: Int) -> HomeM?
}

protocol HomeVMEvent: AnyObject {
    
}

final class HomeVM: HomeVMProtocol {
    private var homeData: [HomeM] = [
        HomeM(icon: R.image.vfdsbvbefs()!, label: "Color Titration"),
        HomeM(icon: R.image.gvbefsfvaaev()!, label: "Brightness"),
        HomeM(icon: R.image.fearsgversaav()!, label: "Touch"),
        HomeM(icon: R.image.vfdbvsfbvfsbrs()!, label: "Gravity"),
        HomeM(icon: R.image.fveargvesarbve()!, label: "Biometrics"),
        HomeM(icon: R.image.cdsvaewvddws()!, label: "Vibration"),
        HomeM(icon: R.image.vdasvawrbvarw()!, label: "Torch")
    ]
    
    init() {
        
    }
    
    func getData(index: Int) -> HomeM? {
        return homeData[safeIndex: index]
    }
    
    func countTotalItem() -> Int {
        return homeData.count
    }
    
}
