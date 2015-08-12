//
//  ListViewController.m
//  CoffeeFindr
//
//  Created by Kellen Pierson on 8/10/15.
//  Copyright (c) 2015 Kellen Pierson. All rights reserved.
//

#import "ListViewController.h"
#import "CoffeePlace.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ListViewController () <CLLocationManagerDelegate>

@property CLLocationManager *locationManager;
@property CLLocation *currentLocation;
@property NSArray *coffeePlacesArray;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self updateCurrentLocation];
}

- (void)updateCurrentLocation {
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)findCoffeePlaces: (CLLocation *)location {
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    request.naturalLanguageQuery = @"coffee";
    request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(.05, .05));

    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        NSArray *mapItems = response.mapItems;
        NSMutableArray *temporaryArray = [NSMutableArray new];
        for (int i = 0; i < 5; i++) {
            MKMapItem *mapItem = [mapItems objectAtIndex:i];

            CLLocationDistance metersAway = [mapItem.placemark.location distanceFromLocation:location];
            float milesDifference = metersAway / 1609.34;

            CoffeePlace *coffeePlace = [CoffeePlace new];

            coffeePlace.mapItem = mapItem;
            coffeePlace.milesDifference = milesDifference;
            [temporaryArray addObject:coffeePlace];
        }
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"milesDifference" ascending:true];
        NSArray *sortedArray = [temporaryArray sortedArrayUsingDescriptors:@[sortDescriptor]];
        self.coffeePlacesArray = [NSArray arrayWithArray:sortedArray];

        for (CoffeePlace *coffeePlace in self.coffeePlacesArray) {
            NSLog(@"%f",coffeePlace.milesDifference);
        }
    }];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.currentLocation = locations.firstObject;
    [self.locationManager stopUpdatingLocation];
    [self findCoffeePlaces:self.currentLocation];
}


@end
