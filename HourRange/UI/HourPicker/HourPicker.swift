//

import UIKit


@IBDesignable
public class HourPicker: UIView, LoadableFromNib {
    @IBInspectable public var labelText: String = "" {
        didSet {
            label?.text = labelText
        }
    }
    @IBInspectable public var defaultHour: String = "" {
        didSet {
            textField?.text = defaultHour
        }
    }
    @IBInspectable public var placeholder: String = "" {
        didSet {
            textField?.placeholder = placeholder
        }
    }
    
    public var text: String? {
        get { textField?.text }
        set { textField?.text = newValue }
    }
    
    @IBOutlet var label: UILabel?
    @IBOutlet var textField: UITextField?
    @IBOutlet var errorLabel: UILabel?
    
    private var errorDescription: String? = nil {
        didSet {
            errorLabel?.text = errorDescription
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
}

extension HourPicker: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let old = textField.text,
              let replaceRange = Range(range, in: old) else {
            return true
        }
        
        let text = old.replacingCharacters(in: replaceRange, with: string)
        guard let number = Int(text) else {
            errorDescription = "整数を入力してください"
            return true
        }
        guard (0...24).contains(number) else {
            errorDescription = "0以上24以下の数値を入力してください"
            return true
        }
        errorDescription = nil
        return true
    }
}
