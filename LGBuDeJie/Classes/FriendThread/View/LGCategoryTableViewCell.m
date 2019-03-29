//
//  LGCategoryTableViewCell.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/27.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGCategoryTableViewCell.h"
#import "LGCategoryItem.h"

@interface LGCategoryTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end

@implementation LGCategoryTableViewCell

- (void)setCategory:(LGCategoryItem *)category
{
    _category = category;
    
    self.nameView.text = category.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.indicatorView.hidden = !selected;
    
    self.nameView.textColor = selected?[UIColor redColor]:[UIColor blackColor];
}

@end
