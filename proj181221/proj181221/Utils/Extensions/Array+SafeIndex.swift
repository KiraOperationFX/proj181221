//
//  Array+SafeIndex.swift
//  proj181221
//
//  Created by Kira on 26/12/2021.
//

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
