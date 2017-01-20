//
//  ViewController2.swift
//  tableViewDemo
//
//  Created by ETHEM YENİAY on 12/21/16.
//  Copyright © 2016 jatin. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var getDate: UIDatePicker!
    @IBOutlet weak var img: UIImageView!
    var papers:[String] = []
    var valid:[Bool]=[]
    var imageList:[String] = []
    var maxImages = 1
    var count = -1
    
    var imageIndex = 1
    
    var control=""
    var dateback:String=""
    var constantpaper:String="https://media-cdn.t24.com.tr/media/papers/full/"
    var paper:[String] = []
    var a = ""
    var b = ""
    var c = ""

    @IBAction func changeDate(_ sender: Any) {
        
       
        
        let components = getDate.calendar.dateComponents([.year, .month, .day], from: getDate.date)
        
        let year : Int =  components.year!
        let month : Int = components.month!
        let day : Int = components.day!
        
        
        a = String(year)
        b = String(month)
        c = String(day)
        control = a + "-" + b + "-" + c
        
        let date = Date()
        let calendar = Calendar.current
        let components2 = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year2 : Int =  components2.year!
        let month2 : Int = components2.month!
        let day2: Int = components2.day!
        var tempYear = String(year2)
        var tempMonth = String(month2)
        var tempDay = String(day2)
    
       if((tempYear<a) || ((tempYear==a) && (tempMonth<b)) || ((tempYear==a) && (tempMonth==b) && (tempDay<c)))
        {
          imageList=[]
         img.image = UIImage(named:"oops")
           
        
        }
        
        else
        {  download(currentDate: control)
            getView(currentDate: control)
            img.image = UIImage(named:"logoK")
        }
       
        
        
    }
    
    func getArray()
    {
        if let object2=UserDefaults.standard.object(forKey:"valid1")
        {
            valid=object2 as! [Bool]
        }
        
        if let object=UserDefaults.standard.object(forKey:"papers1")
        {
            papers=object as! [String]
        }
    }
    
    func getView (currentDate: String)
    {
        imageList=[]
        maxImages = 1
        count = -1
        
        imageIndex = 1
        
        
       
        for i in 0...papers.count-1
        {
            
            if(valid[i]==true)
            {
                count=count+1
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                
                if documentsPath.count > 0 {
                    
                    let documentsDirectory = documentsPath[0]
                    
                    let restorePath = documentsDirectory + "/"+self.papers[i]+currentDate+".jpg";
                    
                    
                    imageList.append(restorePath)
                    
                 
                    
                }

            }
        }
        
        maxImages=count
    }
    func getDownload()
    {
        
        if let object2=UserDefaults.standard.object(forKey:"date")  // tarih kontrolü burda yapılıyor
        {
            dateback=object2 as! String
        }
        
 
        
        var abc=""
        for i in 0...papers.count-1
        {
            abc=constantpaper+papers[i]+"_"
            paper.append(abc)
        }
        
        
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year : Int =  components.year!
        let month : Int = components.month!
        let day : Int = components.day!
        
        a = String(year)
        b = String(month)
        c = String(day)
        control = a + "-" + b + "-" + c
        
        UserDefaults.standard.set(control,forKey:"date")

        if(dateback=="" || dateback != control)
        {
            download(currentDate: control)
            
        }
        
        
        
        


        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return self.img
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.minimumZoomScale=1.0
        self.scrollView.maximumZoomScale=6.0
        logoImg.image = UIImage(named: "newspaper")
        getArray()
        getDownload()
        getView(currentDate: control)
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        img.image = UIImage(named:"logoK")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.right :
                
                
                // decrease index first
                
                imageIndex = imageIndex-1
                
                // check if index is in range
                
                if imageIndex < 0 {
                    
                    imageIndex = maxImages
                    
                }
                
                img.image = UIImage(contentsOfFile: imageList[imageIndex])
                
            case UISwipeGestureRecognizerDirection.left:
                
                
                // increase index first
                
                imageIndex = imageIndex+1
                
                // check if index is in range
                
                if imageIndex > maxImages {
                    
                    imageIndex = 0
                    
                }
                
                img.image = UIImage(contentsOfFile: imageList[imageIndex])
                
                
                
                
            default:
                break //stops the code/codes nothing.
                
                
            }
            
        }
    }
    func download(currentDate: String)
    {
        for j in 0...papers.count-1{
            
            var Sgaste=paper[j]
            
            Sgaste = Sgaste + control + ".jpg"
            
            
            let url = URL(string: Sgaste)!
            
            let request = NSMutableURLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                if error != nil {
                    
                    print(error!)
                    
                } else {
                    
                    if let data = data {
                        
                        if let tmpImage = UIImage(data: data) {
                            
                            
                            
                            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                            
                            if documentsPath.count > 0 {
                                
                                let documentsDirectory = documentsPath[0]
                                
                                let savePath = documentsDirectory + "/"+self.papers[j]+self.control+".jpg";
                                
                                do {
                                    
                                    try UIImageJPEGRepresentation(tmpImage, 1)?.write(to: URL(fileURLWithPath: savePath))
                                    
                                } catch {
                                    
                                    // process error
                                    
                                }
                                
                                
                                
                            }
                            
                            
                        }
                        
                    }
                    
                    
                }
                
            }
            
            task.resume()
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
