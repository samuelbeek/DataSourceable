//
//  TableViewDataSourceProxy.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 29/12/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

open class TableViewDataSourceProxy: NSObject, UITableViewDataSource {
    open let dataSource: TableViewDataSource
    
    public init(dataSource: TableViewDataSource) {
        self.dataSource = dataSource
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.tableView(tableView, numberOfRowsInSection: section)
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataSource.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfSectionsInTableView(tableView)
    }
    
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource.tableView(tableView, titleForHeaderInSection: section)
    }
    
    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return dataSource.tableView(tableView, titleForFooterInSection: section)
    }
}
