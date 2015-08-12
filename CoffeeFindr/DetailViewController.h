//
//  DetailViewController.h
//  CoffeeFindr
//
//  Created by Kellen Pierson on 8/12/15.
//  Copyright (c) 2015 Kellen Pierson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoffeePlace.h"

@interface DetailViewController : UIViewController

@property CoffeePlace *coffeePlace;
@property CLLocation *currentLocation;

@end
