import SwiftUI

enum AppColors {
    // Brand
    static let primary = Color.blue
    
    // Backgrounds
    static let background = Color(
        red: 247/255,
        green: 248/255,
        blue: 250/255
    )
    static let cardBackground = Color.white
    
    // Text
    static let textPrimary = Color.black
    static let textSecondary = Color(
        red: 107/255,
        green: 114/255,
        blue: 128/255
    )
    
    // Borders
    static let border = Color(
        red: 229/255,
        green: 231/255,
        blue: 235/255
    )
    
    // States
    static let success = Color.green
    static let warning = Color.orange
    static let error = Color.red
    
    // Chips
    static let chipBackground = Color.blue.opacity(0.08)
    static let chipText = Color.blue
}

enum AppShadow {
    static let card = Color.black.opacity(0.05)
    static let floating = Color.black.opacity(0.12)
}
