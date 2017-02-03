//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!

    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        tableview.dataSource = self
        tableview.delegate = self
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            
            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
            }   
            self.repos = newRepos
            self.tableview.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error!)
        })
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.repos ==  nil {
            return 0
        } else {
            return self.repos.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gitCell")  as! gitCell!
        
        cell?.nameLabel.text = self.repos[indexPath.row].name
        cell?.authorLabel.text = self.repos[indexPath.row].ownerHandle
        let url = self.repos[indexPath.row].ownerAvatarURL! as String
        
        let imageURL = NSURL(string: url)
        
        cell?.gitImage.setImageWith(imageURL as! URL)
        
        cell?.starsCountLabel.text = String(self.repos[indexPath.row].stars!)
        
        cell?.nameLabel.lineBreakMode = .byWordWrapping // or NSLineBreakMode.ByWordWrapping
        cell?.nameLabel.numberOfLines = 0
        cell?.forksCountLabel.text = String(self.repos[indexPath.row].forks! )
        cell?.descriptionLabel.text = String(self.repos[indexPath.row].repoDescription! )
        return cell!
    }
}
