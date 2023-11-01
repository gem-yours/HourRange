//

import UIKit

protocol TimeRecordView: AnyObject {
    var startHour: String? { get }
    var endHour: String? { get }
    var hour: String? { get }
}

class TimeRecordViewController: UIViewController, TimeRecordView {
    var startHour: String? { startHourPicker?.text }
    var endHour: String? { endHourPicker?.text }
    var hour: String? { hourPicker?.text }
    
    @IBOutlet var startHourPicker: HourPicker?
    @IBOutlet var endHourPicker: HourPicker?
    @IBOutlet var hourPicker: HourPicker?
    
    // TODO: DIでリポジトリを注入する
    var viewModel = TimeRecordViewModel(timeRecordRepository: InmemoryTimeRecordRepository.shared)
    
    override func viewDidLoad() {
        title = "時刻入力"
        viewModel.timeRecordView = self
    }
    
    @IBAction func saveTimeRecord() {
        viewModel.save()
    }
}
