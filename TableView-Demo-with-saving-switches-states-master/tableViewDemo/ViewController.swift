//
//  ViewController.swift
//  tableViewDemo
//
//  Created by RajaSoftwareLabs on 01/10/15.
//  Copyright © 2015 jatin. All rights reserved.
//

import UIKit

protocol cellModelChanged {
  func cellModelSwitchTapped(_ model: SampleTableViewCell, isSwitchOn: Bool)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, cellModelChanged {

    @IBOutlet weak var logo: UIImageView!
  @IBOutlet weak var tableView: UITableView!
  var feedModel: [SampleCellModel] = []
    var papers:[String] = []
    var valid:[Bool]=[]
    
    func setArray()
    {
        
        if let object2=UserDefaults.standard.object(forKey:"valid1")
        {
            valid=object2 as! [Bool]
        }
        
        if let object=UserDefaults.standard.object(forKey:"papers1")
        {
            papers=object as! [String]
        }
 
 
           if(valid.count==0 || papers.count==0)
            {
                papers=["hurriyet","cumhuriyet","sabah","haberturk","sozcu","posta","milliyet","vatan","aksam","takvim","fanatik","fotomac","hurriyet-daily-news"]
                valid=[false,false,false,false,false,false,false,false,false,false,false,false,false]
                
            }
        
       
        
        
    }
    
    
    
    
    
    
    

  func setData() {
    for i in 0...papers.count-1 {
      let cellModel: SampleCellModel = SampleCellModel(name:papers[i], address: "", isInvited: valid[i], profilePic: UIImage(named: papers[i]))
      feedModel.append(cellModel)
    }
    tableView.delegate = self
    tableView.dataSource  = self
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  //  logo.image = UIImage(named: "logo")
      setArray()
      setData()
    tableView.register(UINib(nibName: "SampleTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cell")
  }

}

// MARK: Table View Delegate
extension ViewController {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return feedModel.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 102
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SampleTableViewCell
    let model = feedModel[indexPath.row]
    cell.nameLabel.text = model.name
    cell.addressLabel.text = model.address
    cell.invitedSwitch.setOn(model.isInvited, animated: true)
    cell.profileImageView?.image = model.profilePic
    cell.delegate = self
    return cell
  }

  func cellModelSwitchTapped(_ model: SampleTableViewCell, isSwitchOn: Bool) {
    let model = feedModel[(tableView.indexPath(for: model)?.row)!]
    model.isInvited = isSwitchOn
    UserDefaults.standard.set(papers,forKey:"papers1")
    for i in 0...papers.count-1
    {
        if(papers[i]==model.name)
        {
            valid[i]=model.isInvited;
            UserDefaults.standard.set(valid,forKey:"valid1")
            break;
        }
    }
    
    
    
  }
    
  
}

