//
//  PPMapParkingAnnotationView.h
//  PigParking
//
//  Created by Vincent on 7/8/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "BMKAnnotationView.h"
#import "PPParkingTableViewCell.h"

@interface PPMapParkingAnnotationView : BMKAnnotationView

@property (nonatomic, assign) BOOL isFree;
@property (nonatomic, assign) PPParkingTableViewCellFlag flag;

@end
