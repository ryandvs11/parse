//
//  ChatViewController.swift
//  parseChatP2
//
//  Created by Ryan Davis on 9/28/18.
//  Copyright © 2018 Ryan Davis. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var chatMessageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var messages: [PFObject] = []
    
    @IBAction func sendBtn(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    func getMessages() {
        let query = PFQuery(className: "Message")
        query.includeKey("user")
        query.addDescendingOrder("createdAt")
        
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                if let objects = objects {
                    for obj in objects {
                        if obj != nil {
                            //print(obj["text"] )
                        }
                    }
                }
                
                self.messages = objects!
                self.tableView.reloadData()
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 30
        tableView.dataSource = self
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer: Timer) in
            self.getMessages()
        }
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.messages = messages[indexPath.row]
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
