//
//  CoffeePlace.h
//  CoffeeFindr
//
//  Created by Kellen Pierson on 8/10/15.
//  Copyright (c) 2015 Kellen Pierson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CoffeePlace : NSObject

@property MKMapItem *mapItem;
@property float milesDifference;

@end
