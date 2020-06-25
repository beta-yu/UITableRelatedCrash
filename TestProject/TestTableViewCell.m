//
//  TestTableViewCell.m
//  TestProject
//
//  Created by qiyu on 2020/6/25.
//  Copyright © 2020 com.qiyu. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.origin.x + 40, self.frame.origin.y + 10, 30, 20)];
        [self addSubview:_label];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
