//
//  Duration.swift
//  Learning Journey App
//
//  Created by SAFIA  on 05/06/1448 AH.
//
enum Duration: String, CaseIterable {
    case week
    case month
    case year
    
    var maxFreezes: Int {
           switch self {
           case .week:  2
           case .month: 8
           case .year:  96
           }
       }

       var days: Int {
           switch self {
           case .week:  7
           case .month: 30
           case .year:  365
           }
       }
}
