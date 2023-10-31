//

import UIKit

class TimeRecordListViewController: UITableViewController {
    // TODO: DIでリポジトリを注入する
    let viewModel = TimeRecordListViewModel(timeRecordRepository: InmemoryTimeRecordRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TimeRecordRow", bundle: nil), forCellReuseIdentifier: "timeRecordRow")
        tableView.estimatedRowHeight = 128
        tableView.rowHeight = UITableView.automaticDimension
        self.title = "時刻記録の一覧"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.timeRecords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let timeRecordRow = tableView.dequeueReusableCell(withIdentifier: "timeRecordRow", for: indexPath) as? TimeRecordRow else {
            return UITableViewCell()
        }
        timeRecordRow.timeRecord = viewModel.timeRecords[indexPath.row]
        
        return timeRecordRow
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "timeRecordViewController", sender: nil)
    }
}
