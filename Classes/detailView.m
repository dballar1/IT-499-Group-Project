//
//  detailView.m
//  weather_final
//
//  Created by Alex Litwack on 5/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "detailView.h"

@implementation detailView

@synthesize forecasts, responseData, nibLoadedCell, incomeLocation;

#pragma mark -
#pragma mark Connections

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    responseData = [[NSMutableData alloc] init];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error loading: %@", error);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSDictionary *json = [responseData yajl_JSON];
    self.forecasts = [json valueForKeyPath:@"data.weather"];
	[responseData release];
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	// Initialize the forecasts array
    self.forecasts = [NSArray array];
    // Set the title that shows in the navigation bar
    self.title = @"5 Day Forecast";	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillDisappear:animated];
	//NSLog(@"Detail Forecast: Lat %f, Long %f", incomeLocation.coordinate.latitude, incomeLocation.coordinate.longitude);
	NSString *baseURl = @"http://free.worldweatheronline.com/feed/weather.ashx";
    NSString *urlStr = [baseURl stringByAppendingFormat:@"?q=%f,%f&format=json&num_of_days=5&key=%@", 
                        incomeLocation.coordinate.latitude, 
                        incomeLocation.coordinate.longitude,
                        @"f001a2f13e191433111404"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.forecasts count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"WeatherTableCell" owner:self options:NULL]; 
		cell = nibLoadedCell;
		
	}
	
	NSDictionary *forecast = [forecasts objectAtIndex:indexPath.row];
	
	UILabel *dayLabel = (UILabel*) [cell viewWithTag:1];
	//dayLabel.text = [forecast objectForKey:@"date"];
	
	NSString *dateStr = [forecast objectForKey:@"date"];
	// Convert string to date object
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"YYYY-MM-dd"];
	NSDate *date = [dateFormat dateFromString:dateStr];
	// Convert date object to desired output format
	[dateFormat setDateFormat:@"EEEE"];
	dateStr = [dateFormat stringFromDate:date];  
	[dateFormat release];
	dayLabel.text = dateStr;
	
	//Max Label
	UILabel *tempMaxLabel = (UILabel*) [cell viewWithTag:2];
	tempMaxLabel.text = [NSString stringWithFormat: @"High: %@°", [forecast objectForKey:@"tempMaxF"]];
	//Min Label
	UILabel *tempMinLabel = (UILabel*) [cell viewWithTag:4];
	tempMinLabel.text = [NSString stringWithFormat: @"Low: %@°", [forecast objectForKey:@"tempMinF"]];
	//Desc Label
	UILabel *descLabel = (UILabel*) [cell viewWithTag:3];
	descLabel.text = [[forecast valueForKeyPath:@"weatherDesc.value"] objectAtIndex:0];
	
	//UIImage icon
	
	NSString *weatherIconUrl = [[forecast valueForKeyPath:@"weatherIconUrl.value"] objectAtIndex:0];
	
	NSURL *url = [NSURL URLWithString:weatherIconUrl];
	NSData *data = [[[NSData alloc] initWithContentsOfURL:url] autorelease];
	cell.imageView.image = [UIImage imageWithData:data];
	
    return cell;
}


#pragma mark -
#pragma mark Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

@end