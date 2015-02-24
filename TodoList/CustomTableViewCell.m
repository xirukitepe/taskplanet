//
//  CustomTableViewCell.m
//  TaskPlanet
//
//  Created by Shiela S on 2/23/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 300, 30)];
        self.mainLabel.textColor = [UIColor blackColor];
        self.mainLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
        
        self.descriptionLabel = [[UILabel alloc] initWithFrame: CGRectMake(5, 22, 300, 30)];
        self.descriptionLabel.font = [UIFont fontWithName:@"Arial" size:10.0f];
        
        [self addSubview:self.mainLabel];
        [self addSubview:self.descriptionLabel];
    }
    return self;
}

@end
