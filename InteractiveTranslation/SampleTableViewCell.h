//
//  SampleTableViewCell.h
//  InteractiveTranslation
//
//  Created by CPU11815 on 6/12/17.
//  Copyright © 2017 dotRStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * kSampleTableViewCellIdentify = @"samplecell";

@interface SampleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
