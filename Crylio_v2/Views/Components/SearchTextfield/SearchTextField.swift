//
//  SearchTextField.swift
//  SearchTextField
//
//  Created by Alejandro Pasccon on 4/20/16.
//  Copyright © 2016 Alejandro Pasccon. All rights reserved.
//

import UIKit


open class BaseTextField: UITextField, UITextFieldDelegate {
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        self.addTarget(self, action: #selector(SearchTextField.textFieldDidChange), for: .editingChanged)
        self.addTarget(self, action: #selector(SearchTextField.textFieldDidBeginEditing), for: .editingDidBegin)
        self.addTarget(self, action: #selector(SearchTextField.textFieldDidEndEditing), for: .editingDidEnd)
        self.addTarget(self, action: #selector(SearchTextField.textFieldDidEndEditingOnExit), for: .editingDidEndOnExit)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SearchTextField.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SearchTextField.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SearchTextField.keyboardDidChangeFrame(_:)), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
        
        print(423948923482309)
    }
    
    @objc open func textFieldDidChange() {
    }

    @objc open func textFieldDidBeginEditing() {
        print("ok")
    }
    
    @objc open func textFieldDidEndEditing() {
    }
    
    @objc open func textFieldDidEndEditingOnExit() {
    }
    
}

open class SearchTextField: BaseTextField {
    
    ////////////////////////////////////////////////////////////////////////
    // Public interface
    
    /// Maximum number of results to be shown in the suggestions list
    open var maxNumberOfResults = 0
    
    /// Maximum height of the results list
    open var maxResultsListHeight = 0
    
    /// Indicate if this field has been interacted with yet
    open var interactedWith = false
    
    /// Indicate if keyboard is showing or not
    open var keyboardIsShowing = false

    /// How long to wait before deciding typing has stopped
    open var typingStoppedDelay = 0.8
    
    /// Set your custom visual theme, or just choose between pre-defined SearchTextFieldTheme.lightTheme() and SearchTextFieldTheme.darkTheme() themes
    open var theme = SearchTextFieldTheme.lightTheme() {
        didSet {
            tableView?.reloadData()
            
            if let placeholderColor = theme.placeholderColor {
                if let placeholderString = placeholder {
                    self.attributedPlaceholder = NSAttributedString(string: placeholderString, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
                }
                
                self.placeholderLabel?.textColor = placeholderColor
            }
           
            if let hightlightedFont = self.highlightAttributes[.font] as? UIFont {
                self.highlightAttributes[.font] = hightlightedFont.withSize(self.theme.font.pointSize)
            }
        }
    }
    
    /// Show the suggestions list without filter when the text field is focused
    open var startVisible = false
    
    /// Show the suggestions list without filter even if the text field is not focused
    open var startVisibleWithoutInteraction = false {
        didSet {
            if startVisibleWithoutInteraction {
                textFieldDidChange()
            }
        }
    }
    
    /// Set an array of SearchTextFieldItem's to be used for suggestions
    open func filterItems(_ items: [SearchTextFieldItem]) {
        filterDataSource = items
    }
    
    /// Set an array of strings to be used for suggestions
    open func filterStrings(_ strings: [String]) {
        var items = [SearchTextFieldItem]()
        
        for value in strings {
            items.append(SearchTextFieldItem(title: value))
        }
        
        filterItems(items)
    }
    
    /// Closure to handle when the user pick an item
    open var itemSelectionHandler: SearchTextFieldItemHandler?
    
    /// Closure to handle when the user stops typing
    open var userStoppedTypingHandler: (() -> Void)?
    
    /// Set your custom set of attributes in order to highlight the string found in each item
    open var highlightAttributes: [NSAttributedString.Key: AnyObject] = [.font: UIFont.boldSystemFont(ofSize: 10)]
    
    /// Start showing the default loading indicator, useful for searches that take some time.
    open func showLoadingIndicator() {
        self.rightViewMode = .always
        indicator.startAnimating()
    }
    
    /// Force the results list to adapt to RTL languages
    open var forceRightToLeft = false
    
    /// Hide the default loading indicator
    open func stopLoadingIndicator() {
        self.rightViewMode = .never
        indicator.stopAnimating()
    }
    
    /// When InlineMode is true, the suggestions appear in the same line than the entered string. It's useful for email domains suggestion for example.
    open var inlineMode: Bool = false {
        didSet {
            if inlineMode == true {
                autocorrectionType = .no
                spellCheckingType = .no
            }
        }
    }
    
    /// Only valid when InlineMode is true. The suggestions appear after typing the provided string (or even better a character like '@')
    open var startFilteringAfter: String?
    
    /// Min number of characters to start filtering
    open var minCharactersNumberToStartFiltering: Int = 0

    /// Force no filtering (display the entire filtered data source)
    open var forceNoFiltering: Bool = false
    
    /// If startFilteringAfter is set, and startSuggestingImmediately is true, the list of suggestions appear immediately
    open var startSuggestingImmediately = false
    
    /// Allow to decide the comparision options
    open var comparisonOptions: NSString.CompareOptions = [.caseInsensitive]
    
    /// Set the results list's header
    open var resultsListHeader: UIView?

    // Move the table around to customize for your layout
    open var tableXOffset: CGFloat = 0.0
    open var tableYOffset: CGFloat = 0.0
    open var tableCornerRadius: CGFloat = 7
    open var tableBottomMargin: CGFloat = 10.0
    
    ////////////////////////////////////////////////////////////////////////
    // Private implementation
    
    fileprivate var tableView: UITableView?
    fileprivate var direction: Direction = .down
    fileprivate var fontConversionRate: CGFloat = 0.7
    fileprivate var keyboardFrame: CGRect?
    fileprivate var timer: Timer? = nil
    fileprivate var placeholderLabel: UILabel?
    fileprivate static let cellIdentifier = "APSearchTextFieldCell"
    fileprivate let indicator = UIActivityIndicatorView(style: .gray)
    fileprivate var maxTableViewSize: CGFloat = 0
    
    fileprivate var filteredResults = [SearchTextFieldItem]()
    fileprivate var filterDataSource = [SearchTextFieldItem]() {
        didSet {
            filter(forceShowAll: forceNoFiltering)
            buildSearchTableView()
            
            if startVisibleWithoutInteraction {
                textFieldDidChange()
            }
        }
    }
    
    fileprivate var currentInlineItem = ""
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        tableView?.removeFromSuperview()
    }
    
//    override open func willMove(toSuperview newSuperview: UIView?) {
//        super.willMove(toSuperview: newSuperview)
//
//        self.addTarget(self, action: #selector(SearchTextField.textFieldDidChange), for: .editingChanged)
//        self.addTarget(self, action: #selector(SearchTextField.textFieldDidBeginEditing), for: .editingDidBegin)
//        self.addTarget(self, action: #selector(SearchTextField.textFieldDidEndEditing), for: .editingDidEnd)
//        self.addTarget(self, action: #selector(SearchTextField.textFieldDidEndEditingOnExit), for: .editingDidEndOnExit)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(SearchTextField.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(SearchTextField.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(SearchTextField.keyboardDidChangeFrame(_:)), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
//    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if inlineMode {
            buildPlaceholderLabel()
        } else {
            buildSearchTableView()
        }
        
        // Create the loading indicator
        indicator.hidesWhenStopped = true
        self.rightView = indicator
    }
    
    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightFrame = super.rightViewRect(forBounds: bounds)
        rightFrame.origin.x -= 5
        return rightFrame
    }
    
    // Create the filter table and shadow view
    fileprivate func buildSearchTableView() {
        guard let tableView = tableView else {
            self.tableView = UITableView(frame: CGRect.zero)
            buildSearchTableView()
            return
        }
        
        tableView.backgroundColor = .clear
        tableView.layer.masksToBounds = false
        tableView.layer.masksToBounds = false
        tableView.layer.borderWidth = theme.borderWidth > 0 ? theme.borderWidth : 0.5
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableHeaderView = resultsListHeader
        tableView.separatorStyle = .none
        tableView.register(SearchTextFieldTableViewCell.self, forCellReuseIdentifier: SearchTextFieldTableViewCell.reuseId)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 7, right: 0)
        
        if forceRightToLeft {
            tableView.semanticContentAttribute = .forceRightToLeft
        }
        
        backgroundColor = .clear
        
        addShadow()
        
        self.window?.addSubview(tableView)
        
        redrawSearchTableView()
    }
    
    fileprivate func buildPlaceholderLabel() {
        
        var newRect = self.placeholderRect(forBounds: self.bounds)
        var caretRect = self.caretRect(for: self.beginningOfDocument)
        let textRect = self.textRect(forBounds: self.bounds)
        
        if let range = textRange(from: beginningOfDocument, to: endOfDocument) {
            caretRect = self.firstRect(for: range)
        }
        
        newRect.origin.x = caretRect.origin.x + caretRect.size.width + textRect.origin.x
        newRect.size.width = newRect.size.width - newRect.origin.x
        
        if let placeholderLabel = placeholderLabel {
            placeholderLabel.font = self.font
            placeholderLabel.frame = newRect
        } else {
            placeholderLabel = UILabel(frame: newRect)
            placeholderLabel?.font = self.font
            placeholderLabel?.backgroundColor = UIColor.clear
            placeholderLabel?.lineBreakMode = .byClipping
            
            if let placeholderColor = self.attributedPlaceholder?.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: nil) as? UIColor {
                placeholderLabel?.textColor = placeholderColor
            } else {
                placeholderLabel?.textColor = UIColor (red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
            }
            
            self.addSubview(placeholderLabel!)
        }
    }
    
    // Re-set frames and theme colors
    fileprivate func redrawSearchTableView() {
        if inlineMode {
            tableView?.isHidden = true
            return
        }
        
        if let tableView = tableView {
            guard let frame = self.superview?.convert(self.frame, to: nil) else { return }
            
            //TableViews use estimated cell heights to calculate content size until they
            //  are on-screen. We must set this to the theme cell height to avoid getting an
            //  incorrect contentSize when we have specified non-standard fonts and/or
            //  cellHeights in the theme. We do it here to ensure updates to these settings
            //  are recognized if changed after the tableView is created
            tableView.estimatedRowHeight = theme.cellHeight
            if self.direction == .down {
                
                var tableHeight: CGFloat = 0
                if keyboardIsShowing, let keyboardHeight = keyboardFrame?.size.height {
                    tableHeight = min((tableView.contentSize.height), (UIScreen.main.bounds.size.height - frame.origin.y - frame.height - keyboardHeight))+7
                } else {
                    tableHeight = min((tableView.contentSize.height), (UIScreen.main.bounds.size.height - frame.origin.y - frame.height))+7
                }
                
                if maxResultsListHeight > 0 {
                    tableHeight = min(tableHeight, CGFloat(maxResultsListHeight))+7
                }
                
                // Set a bottom margin of 10p
                if tableHeight < tableView.contentSize.height {
                    tableHeight -= tableBottomMargin
                }
                
                var tableViewFrame = CGRect(x: 0, y: 0, width: frame.size.width - 4, height: tableHeight)
                tableViewFrame.origin = self.convert(tableViewFrame.origin, to: nil)
                tableViewFrame.origin.x += 2 + tableXOffset
                tableViewFrame.origin.y += frame.size.height + 2 + tableYOffset
                self.tableView?.frame.origin = tableViewFrame.origin // Avoid animating from (0, 0) when displaying at launch
                
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.2, animations: { [weak self] in
                        self?.tableView?.frame = tableViewFrame
                    })
                }
                
                
            } else {
                let tableHeight = min((tableView.contentSize.height), (UIScreen.main.bounds.size.height - frame.origin.y - theme.cellHeight))+7
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.2, animations: { [weak self] in
                        self?.tableView?.frame = CGRect(x: frame.origin.x + 2, y: (frame.origin.y - tableHeight), width: frame.size.width - 4, height: tableHeight)
                    })
                }
            }
            
            superview?.bringSubviewToFront(tableView)
            
            if self.isFirstResponder {
                superview?.bringSubviewToFront(self)
            }
            
            tableView.layer.borderColor = theme.borderColor.cgColor
            tableView.layer.cornerRadius = tableCornerRadius
            tableView.separatorColor = theme.separatorColor
            tableView.backgroundColor = theme.bgColor
            
            addShadow()
            
            tableView.reloadData()
        }
    }
    
    // Handle keyboard events
    @objc open func keyboardWillShow(_ notification: Notification) {
        if !keyboardIsShowing && isEditing {
            keyboardIsShowing = true
            keyboardFrame = ((notification as NSNotification).userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            interactedWith = true
            prepareDrawTableResult()
        }
    }
    
    @objc open func keyboardWillHide(_ notification: Notification) {
        if keyboardIsShowing {
            keyboardIsShowing = false
            direction = .down
            redrawSearchTableView()
        }
    }
    
    @objc open func keyboardDidChangeFrame(_ notification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.keyboardFrame = ((notification as NSNotification).userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            self?.prepareDrawTableResult()
        }
    }
    
    @objc open func typingDidStop() {
        self.userStoppedTypingHandler?()
    }
    
    // Handle text field changes
    @objc open override func textFieldDidChange() {
        if !inlineMode && tableView == nil {
            buildSearchTableView()
        }
        
        interactedWith = true
        
        // Detect pauses while typing
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: typingStoppedDelay, target: self, selector: #selector(SearchTextField.typingDidStop), userInfo: self, repeats: false)
        
        if text!.isEmpty {
            clearResults()
            tableView?.reloadData()
            if startVisible || startVisibleWithoutInteraction {
                filter(forceShowAll: true)
            }
            self.placeholderLabel?.text = ""
        } else {
            filter(forceShowAll: forceNoFiltering)
            prepareDrawTableResult()
        }
        
        buildPlaceholderLabel()
    }
    
    @objc open override func textFieldDidBeginEditing() {
        if (startVisible || startVisibleWithoutInteraction) && text!.isEmpty {
            clearResults()
            filter(forceShowAll: true)
        }
        placeholderLabel?.attributedText = nil
    }
    
    @objc open override func textFieldDidEndEditing() {
        clearResults()
        tableView?.reloadData()
        placeholderLabel?.attributedText = nil
    }
    
    @objc open override func textFieldDidEndEditingOnExit() {
        
        if let firstElement = filteredResults.first {
            if let itemSelectionHandler = self.itemSelectionHandler {
                itemSelectionHandler(filteredResults, 0)
            }
            else {
                if inlineMode, let filterAfter = startFilteringAfter {
                    let stringElements = self.text?.components(separatedBy: filterAfter)
                    
                    self.text = stringElements!.first! + filterAfter + firstElement.title
                } else {
                    self.text = firstElement.title
                }
            }
        }
    }
    
    open func hideResultsList() {
        
        if let tableFrame:CGRect = tableView?.frame {
            let newFrame = CGRect(x: tableFrame.origin.x, y: tableFrame.origin.y, width: tableFrame.size.width, height: 0.0)
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.tableView?.frame = newFrame
            })
            
        }
    }
    
    fileprivate func addShadow() {
        
        let bg = RoundShadowView()
        
        bg.containerView.backgroundColor = AppColors.background.primary
        bg.frame = self.tableView!.bounds
                
        self.tableView?.backgroundView = bg
    }
    
    fileprivate func filter(forceShowAll addAll: Bool) {
        clearResults()
        
        if text!.count < minCharactersNumberToStartFiltering {
            return
        }
        
        for i in 0 ..< filterDataSource.count {
            
            let item = filterDataSource[i]
            
            if !inlineMode {
                // Find text in title and subtitle
                let titleFilterRange = (item.title as NSString).range(of: text!, options: comparisonOptions)
                let subtitleFilterRange = item.subtitle != nil ? (item.subtitle! as NSString).range(of: text!, options: comparisonOptions) : NSMakeRange(NSNotFound, 0)
                
                if titleFilterRange.location != NSNotFound || subtitleFilterRange.location != NSNotFound || addAll {
                    item.attributedTitle = NSMutableAttributedString(string: item.title)
                    item.attributedSubtitle = NSMutableAttributedString(string: (item.subtitle != nil ? item.subtitle! : ""))
                    
                    item.attributedTitle!.setAttributes(highlightAttributes, range: titleFilterRange)
                    
                    if subtitleFilterRange.location != NSNotFound {
                        item.attributedSubtitle!.setAttributes(highlightAttributesForSubtitle(), range: subtitleFilterRange)
                    }
                    
                    filteredResults.append(item)
                }
            } else {
                var textToFilter = text!.lowercased()
                
                if inlineMode, let filterAfter = startFilteringAfter {
                    if let suffixToFilter = textToFilter.components(separatedBy: filterAfter).last, (suffixToFilter != "" || startSuggestingImmediately == true), textToFilter != suffixToFilter {
                        textToFilter = suffixToFilter
                    } else {
                        placeholderLabel?.text = ""
                        return
                    }
                }
                
                if item.title.lowercased().hasPrefix(textToFilter) {
                    let indexFrom = textToFilter.index(textToFilter.startIndex, offsetBy: textToFilter.count)
                    let itemSuffix = item.title[indexFrom...]
                    
                    item.attributedTitle = NSMutableAttributedString(string: String(itemSuffix))
                    filteredResults.append(item)
                }
            }
        }
        
        tableView?.reloadData()
        
        if inlineMode {
            handleInlineFiltering()
        }
    }
    
    // Clean filtered results
    fileprivate func clearResults() {
        filteredResults.removeAll()
        tableView?.removeFromSuperview()
    }
    
    // Look for Font attribute, and if it exists, adapt to the subtitle font size
    fileprivate func highlightAttributesForSubtitle() -> [NSAttributedString.Key: AnyObject] {
        var highlightAttributesForSubtitle = [NSAttributedString.Key: AnyObject]()
        
        for attr in highlightAttributes {
            if attr.0 == NSAttributedString.Key.font {
                let fontName = (attr.1 as! UIFont).fontName
                let pointSize = (attr.1 as! UIFont).pointSize * fontConversionRate
                highlightAttributesForSubtitle[attr.0] = UIFont(name: fontName, size: pointSize)
            } else {
                highlightAttributesForSubtitle[attr.0] = attr.1
            }
        }
        
        return highlightAttributesForSubtitle
    }
    
    // Handle inline behaviour
    func handleInlineFiltering() {
        if let text = self.text {
            if text == "" {
                self.placeholderLabel?.attributedText = nil
            } else {
                if let firstResult = filteredResults.first {
                    self.placeholderLabel?.attributedText = firstResult.attributedTitle
                } else {
                    self.placeholderLabel?.attributedText = nil
                }
            }
        }
    }
    
    // MARK: - Prepare for draw table result
    
    fileprivate func prepareDrawTableResult() {
        guard let frame = self.superview?.convert(self.frame, to: UIApplication.shared.keyWindow) else { return }
        if let keyboardFrame = keyboardFrame {
            var newFrame = frame
            newFrame.size.height += theme.cellHeight
            
            if keyboardFrame.intersects(newFrame) {
                direction = .up
            } else {
                direction = .down
            }
            
            redrawSearchTableView()
        } else {
            if self.center.y + theme.cellHeight > UIApplication.shared.keyWindow!.frame.size.height {
                direction = .up
            } else {
                direction = .down
            }
        }
    }
}

extension SearchTextField: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.isHidden = !interactedWith || (filteredResults.count == 0)
        
        if maxNumberOfResults > 0 {
            return min(filteredResults.count, maxNumberOfResults)
        } else {
            return filteredResults.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTextFieldTableViewCell.reuseId, for: indexPath) as? SearchTextFieldTableViewCell  else {
            fatalError("The dequeued cell is not an instance of SearchTextFieldTableViewCell.")
        }
        
        if indexPath.row == 0 {
            cell.selectionView.isHidden = false
            cell.titleLabel.textColor = .systemBlue
        }
        
        cell.content = (title: filteredResults[(indexPath as NSIndexPath).row].title, image: filteredResults[(indexPath as NSIndexPath).row].image!)
 
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return theme.cellHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if itemSelectionHandler == nil {
            self.text = filteredResults[(indexPath as NSIndexPath).row].title
        } else {
            let index = indexPath.row
            itemSelectionHandler!(filteredResults, index)
        }
        
        clearResults()
    }
    
}

extension SearchTextField {
    
    
    
}

////////////////////////////////////////////////////////////////////////
// Search Text Field Theme

public struct SearchTextFieldTheme {
    
    public var cellHeight: CGFloat
    public var bgColor: UIColor
    public var borderColor: UIColor
    public var borderWidth : CGFloat = 0
    public var separatorColor: UIColor
    public var font: UIFont
    public var fontColor: UIColor
    public var subtitleFontColor: UIColor
    public var placeholderColor: UIColor?
    
    init(cellHeight: CGFloat, bgColor:UIColor, borderColor: UIColor, separatorColor: UIColor, font: UIFont, fontColor: UIColor, subtitleFontColor: UIColor? = nil) {
        self.cellHeight = cellHeight
        self.borderColor = borderColor
        self.separatorColor = separatorColor
        self.bgColor = bgColor
        self.font = font
        self.fontColor = fontColor
        self.subtitleFontColor = subtitleFontColor ?? fontColor
    }
    
    public static func lightTheme() -> SearchTextFieldTheme {
        return SearchTextFieldTheme(cellHeight: 30, bgColor: UIColor (red: 1, green: 1, blue: 1, alpha: 0.6), borderColor: UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0), separatorColor: UIColor.clear, font: UIFont.systemFont(ofSize: 10), fontColor: AppColors.label.primary)
    }
    
    public static func darkTheme() -> SearchTextFieldTheme {
        return SearchTextFieldTheme(cellHeight: 30, bgColor: UIColor (red: 0.8, green: 0.8, blue: 0.8, alpha: 0.6), borderColor: UIColor (red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0), separatorColor: UIColor.clear, font: UIFont.systemFont(ofSize: 10), fontColor: AppColors.label.primary)
    }
}

////////////////////////////////////////////////////////////////////////
// Filter Item

open class SearchTextFieldItem {
    // Private vars
    fileprivate var attributedTitle: NSMutableAttributedString?
    fileprivate var attributedSubtitle: NSMutableAttributedString?
    
    // Public interface
    public var title: String
    public var subtitle: String?
    public var image: UIImage?
    
    public init(title: String, subtitle: String?, image: UIImage?) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
    
    public init(title: String, subtitle: String?) {
        self.title = title
        self.subtitle = subtitle
    }
    
    public init(title: String) {
        self.title = title
    }
}

public typealias SearchTextFieldItemHandler = (_ filteredResults: [SearchTextFieldItem], _ index: Int) -> Void

////////////////////////////////////////////////////////////////////////
// Suggestions List Direction

enum Direction {
    case down
    case up
}

class RoundShadowView: UIView {
    
    let containerView = UIView()
    let cornerRadius: CGFloat = 7.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutView() {
        
        // set the shadow of the view's layer
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 5
        
        // set the cornerRadius of the containerView's layer
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.masksToBounds = true
                
        addSubview(containerView)
        
        // add constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // pin the containerView to the edges to the view
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
