//
//  MovieViewController.swift
//  RottenTomato
//
//  Created by Scott_Air on 15/2/8.
//  Copyright (c) 2015年 ScottZou. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var movies: [NSDictionary] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=z42f5fupkt2ea68n8wwnxwhx&limit=20&country=us"
        
        var request = NSURLRequest(URL: NSURL(string: url)!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (
            reponse: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            
            self.movies = object["movies"] as [NSDictionary]
            
            self.tableView.reloadData()
            }
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
        
        var movie = movies[indexPath.row]
        
        cell.movieTitleLabel.text = movie["title"] as? String
        cell.synoposisLabel.text = movie["synopsis"] as? String
        
//        cell.textLabel!.text = "Hello, I am at row: \(indexPath.row), section: \(indexPath.section)"
        return cell
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
