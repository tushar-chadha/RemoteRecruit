import SwiftUI

extension Color {
    static let appBackground = Color(
        uiColor: UIColor { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor(red: 18/255, green: 18/255, blue: 20/255, alpha: 1)
            : UIColor(red: 247/255, green: 248/255, blue: 250/255, alpha: 1)
        }
    )
}

enum AppColors {
    // MARK: Brand
    static let primary = Color.accentColor
    
    // MARK: Backgrounds
    static let background = Color.appBackground
    static let secondaryBackground = Color(uiColor: .secondarySystemGroupedBackground)
    static let cardBackground = Color(uiColor: .systemBackground)
    
    // MARK: Text
    static let textPrimary = Color(uiColor: .label)
    static let textSecondary = Color(uiColor: .secondaryLabel)
    
    // MARK: Borders
    static let border = Color(uiColor: .separator)
    
    // MARK: States
    static let success = Color.green
    static let warning = Color.orange
    static let error = Color.red
    
    // MARK: Chips
    static let chipBackground = primary.opacity(0.12)
    static let chipText = primary
}

enum AppShadow {
    static let card = Color.black.opacity(0.08)
    static let floating = Color.black.opacity(0.16)
}
