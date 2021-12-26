//
//  ColorVM.swift
//  proj181221
//
//  Created by Kira on 26/12/2021.
//

import Foundation

protocol ColorVMProtocol {
    func getColor() -> String
}

protocol ColorVMEvent: AnyObject {
    
}

final class ColorVM: ColorVMProtocol {
    
    private var index: Int = 0 {
        didSet {
            index = (index >= colorHex.count) ? 0 : index
        }
    }
    private var colorHex: [String] = [
        "#FFFF00FF",
        "#0000FFFF",
        "#FF0000FF",
        "#008000FF",
        "#EB129EFF",
        "#B947D7FF",
        "#3BBCF6FF",
        "#602D5EFF",
        "#A258A7FF",
        "#045E24FF",
        "#D3866AFF",
        "#A970BBFF",
        "#F6A679FF",
        "#AB5B19FF",
        "#6C3E50FF",
        "#DE5319FF",
        "#8413D3FF",
        "#5BE18EFF",
        "#BBC9C2FF",
        "#3D6D87FF",
        "#399A87FF",
        "#973965FF",
        "#0615A6FF",
        "#B6BD86FF",
        "#53DAC6FF",
        "#BC017DFF",
        "#B65AEEFF",
        "#458F6FFF",
        "#E12F52FF",
        "#D14886FF",
        "#CF6F17FF",
        "#152146FF",
        "#A255B0FF",
        "#D678EBFF",
        "#350FAEFF",
        "#EE80B1FF",
        "#4FCC44FF",
        "#D51B97FF",
        "#87ED64FF",
        "#D270F7FF",
        "#313472FF",
        "#3EC8C4FF",
        "#510127FF",
        "#9C61DCFF",
        "#5CE967FF",
        "#1DE55AFF",
        "#BC6B31FF",
        "#ED181EFF",
        "#2A2765FF",
        "#B45919FF",
        "#AABF17FF",
        "#1BD262FF",
        "#23028FFF",
        "#BA961BFF",
        "#051DD0FF",
        "#1923BBFF",
        "#F58F4EFF",
        "#CF1EACFF",
        "#2B42DEFF",
        "#9462A4FF",
        "#FE0AE3FF",
        "#BBD0AEFF",
        "#4B5C8DFF",
        "#3798B6FF",
        "#BD3AF6FF",
        "#BF56A7FF",
        "#9AFA4AFF",
        "#195C56FF",
        "#1787F5FF",
        "#781637FF",
        "#8A4FC3FF",
        "#B613D8FF",
        "#9F2285FF",
        "#F4EF8EFF",
        "#D245AAFF",
        "#385D48FF",
        "#A69037FF",
        "#C89A8FFF",
        "#855CE3FF",
        "#C1EFF2FF",
        "#77349FFF",
        "#A29FB2FF",
        "#40FCC3FF",
        "#B96D5CFF",
        "#FF665DFF",
        "#2BFB7CFF",
        "#C8FAC0FF",
        "#B2D84BFF",
        "#EF1CC2FF",
        "#1511F6FF",
        "#7FF66AFF",
        "#F58879FF",
        "#EB098DFF",
        "#B76A28FF",
        "#807FA5FF",
        "#C5CB61FF",
        "#A6E69FFF",
        "#780F58FF",
        "#F2A1E7FF",
        "#034285FF",
        "#EABEE2FF",
        "#C6C39DFF",
        "#CF7DFEFF",
        "#10754EFF",
        "#3C457BFF",
    ]
    
    func getColor() -> String {
        let nextIndex = self.index
        index += 1
        return colorHex[nextIndex]
    }
}
