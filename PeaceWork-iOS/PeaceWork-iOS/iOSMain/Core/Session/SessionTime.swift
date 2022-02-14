//
//  SessionTime'.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/28/21.
//

import Foundation

//MARK: - Session Time --------------------------------------
struct SessionTime {
    static let sharedInstance = SessionTime()
    enum TimeFormat {
        case yyyy_dd_MM_hh_mm
        case hh_mm
    }
    
    /// Get current time
    /// - Parameter format: specifies desired date-time format
    /// - Returns: current date based on format
    func getTime(format: TimeFormat) -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        switch format {
        case .yyyy_dd_MM_hh_mm:
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy/dd/MM hh:mm", options: 0, locale: Locale.current)
            let dateStr =  dateFormatter.string(from: currentDate)
            return dateStr
        case .hh_mm:
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "hh:mm", options: 0, locale: Locale.current)
            let dateStr =  dateFormatter.string(from: currentDate)
            return dateStr
            
        
        }
    }
    func getTimeFromDate(format: TimeFormat, currentDate: Date) -> String {
            let dateFormatter = DateFormatter()
            switch format {
            case .yyyy_dd_MM_hh_mm:
                dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy/dd/MM hh:mm", options: 0, locale: Locale.current)
                let dateStr =  dateFormatter.string(from: currentDate)
                return dateStr
            case .hh_mm:
                dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "hh:mm", options: 0, locale: Locale.current)
                let dateStr =  dateFormatter.string(from: currentDate)
                return dateStr
                
            
            }
        }
    private init(){ }
}
