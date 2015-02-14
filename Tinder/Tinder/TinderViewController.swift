//
//  TinderViewController.swift
//  Tinder
//
//  Created by Chuma Nnaji on 2/12/15.
//  Copyright (c) 2015 Chuma Nnaji. All rights reserved.
//

import UIKit

class TinderViewController: UIViewController {

    var xFromCenter: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint!, error: NSError!) -> Void in
            if error == nil {
                println(geoPoint)

                var user = PFUser.currentUser()
                user["location"] = geoPoint
                user.save()
            }
        }

        func addPerson(urlString: String) {
            let urlRequest: NSURLRequest = NSURLRequest(URL: NSURL(string: urlString)!)
            NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
                response, data, error in

                var image = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
                image.image = UIImage(data: data)
                self.view.addSubview(image)

                var newUser = PFUser()
                newUser["image"] = data
                newUser["gender"] = rand() % 2 == 0 ? "male" : "female"
                newUser["username"] = "user_\(rand() % 100)"
                newUser.password = "password"

                var location = PFGeoPoint(latitude: Double(37 + rand() % 20), longitude: Double(-122 + rand() % 20))
                newUser["location"] = location

                if let match = urlString.rangeOfString("twitter/(.*)128\\.jpg", options: .RegularExpressionSearch) {
                    let index: String.Index = advance(urlString.startIndex, 8)
                    newUser["name"] = urlString.substringWithRange(match).stringByDeletingLastPathComponent.substringFromIndex(index)
                }

                newUser.signUp()
            })
        }

        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/9lessons/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/ManikRathee/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/_hartjeg/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/_shahedk/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/aaroni/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/abecherian/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/adellecharles/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/adhamdannaway/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/alexmarin/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/andrewaashen/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/ateneupopular/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/boheme/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/brad_frost/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/brynn/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/c_southam/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/cemshid/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/chadengle/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/csswizardry/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/dancounsell/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/dingyi/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/dustinlamont/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/eduardo_olv/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/enda/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/felipenogs/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/fffabs/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/fran6/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/gerrenlamson/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/glif/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/gt/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/guiiipontes/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/iconfinder/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/idiot/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/iflendra/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/jadlimcaco/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/jaredfitch/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/jina/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/jollynutlet/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/joshhemsley/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/jsa/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/kastov_yury/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/kerem/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/kevin_granger/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/kfriedson/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/kurafire/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/leemunroe/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/mattchevy/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/mattsince87/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/mghoz/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/mizko/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/mlane/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/motherfuton/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/mrjohnwalker/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/nexy_dre/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/peterlandt/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/peterme/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/pinceladasdaweb/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/pixeliris/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/putorti/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/rem/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/rogie/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/rssems/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/sachagreif/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/shalt0ni/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/sillyleo/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/sindresorhus/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/soffes/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/suprb/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/thrivesolo/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/tomaslau/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/tonypeterson/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/tsu_vip/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/vista/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/vladabazhan/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/vladarbatov/128.jpg")
        addPerson("https://s3.amazonaws.com/uifaces/faces/twitter/whale/128.jpg")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
