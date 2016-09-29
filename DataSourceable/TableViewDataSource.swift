//
//  TableViewDataSource.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 29/12/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

public protocol TableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
}

public extension TableViewDataSource {
    public func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return nil
    }
}

public extension TableViewDataSource where Self: Sectionable {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems(inSection: section)
    }
    
    public func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader(atIndex: section)
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sectionFooter(atIndex: section)
    }
}


public extension TableViewDataSource where Self: Sectionable, Self: TableViewCellProviding, Self.TableViewCellType.ItemType == Self.Section.Data.Element {
    
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let identifier = reuseIdentifier(forIndexPath: indexPath)
        guard let item = item(atIndexPath: indexPath) else {
            return tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let cell = cell as? TableViewCellType, let view = tableView as? TableViewCellType.ContainingViewType {
            cell.configure(forItem: item, inView: view)
        }
        return cell
    }
}
