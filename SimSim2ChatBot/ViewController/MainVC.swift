//
//  ViewController.swift
//  SimSim2ChatBot
//
//  Created by Roy's Saxy MacBook on 2/2/23.
//

import UIKit


class MainVC: UIViewController {
    var msgList : [MSG] = []
    var viewModel : SimSim2VM = SimSim2VM()

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var myTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- <#comment#>")
        
        self.myTableView.dataSource = self
        self.myTableView.register(BotCell.nib, forCellReuseIdentifier: BotCell.identifier)
        self.myTableView.register(UserCell.nib, forCellReuseIdentifier: UserCell.identifier)
        sendBtn.addTarget(self, action:#selector(buttonTapped), for: .touchUpInside)
    }
}
extension MainVC{
    //Button Clicekd Function
    @objc func buttonTapped(){
        if let inputText = myTextField.text, inputText != "" {
            msgList.append(MSG(inputText, .user))
            viewModel.getResponse(inputText,
                                  completion: { [weak self] botMsg in
                guard let self = self else { return }
                self.msgList.append(MSG(botMsg, .bot))
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
            })
            myTextField.text = ""
            myTableView.reloadData()
        }
    }
}

extension MainVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#fileID, #function, #line, "- <#comment#>")
        return msgList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#fileID, #function, #line, "- <#comment#>")
        
        let msg = msgList[indexPath.row]
        let msgType = msg.type
        
        switch msgType{
        case .user:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell else{
                return UITableViewCell()
            }
            cell.userTextLabel.text = msg.message
            return cell
            
        case .bot:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BotCell.identifier, for: indexPath) as? BotCell else{
                return UITableViewCell()
            }
            
            cell.botTextLabel.text = msg.message
            return cell
        }
    }
}
