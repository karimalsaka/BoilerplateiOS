// MARK: - ColorName

/// defines the names of the colors used in the app's design system
enum ColorName: String, CaseIterable {

    // MARK: Background
    
    ///The main background color
    case primaryBackground = "Background/primaryBackground"
    
    /// Used for other elemets on top of the main background
    case secondaryBackground = "Background/secondaryBackground"

    // MARK: Text

    ///The main text color
    case primaryText = "Text/primaryText"
    
    /// Used to highlight certain text
    case secondaryText = "Text/secondaryText"
    
    // MARK: Control
    
    ///The text color for a primary control's normal state
    case primaryControlText = "Control/primaryControlText"
    
    ///The background color of a primary control's normal state
    case primaryControlBackground = "Control/primaryControlBackground"
    
    ///The text color of a disabled control's state
    case disabledControlText = "Control/disabledControlText"
    
    ///The background color of a disabled control's state
    case disabledControlBackground = "Control/disabledControlBackground"
    
    ///The background color of a secondary control's state
    case secondaryControlBackground = "Control/secondaryControlBackground"
}
