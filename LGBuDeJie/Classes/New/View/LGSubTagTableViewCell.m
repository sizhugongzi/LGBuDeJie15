//
//  LGSubTagTableViewCell.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGSubTagTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface LGSubTagTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numView;

@end

@implementation LGSubTagTableViewCell

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    frame.origin.y += 10;
    frame.origin.x += 10;
    frame.size.width -= 20;
    
    [super setFrame:frame];
}

- (void)setItem:(LGSubTagItem *)item
{
    _item = item;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage: [UIImage imageNamed:@"mainCellBackground"]];
    _nameView.text = item.theme_name;
    //处理订阅数字
    CGFloat num = [item.sub_number floatValue];
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",item.sub_number];
    if (num > 10000) {
        num = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",num];
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    _numView.text = numStr;
    
}

+(instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _iconView.layer.cornerRadius = _iconView.xmg_width * 0.5;
    _iconView.layer.masksToBounds = YES;
}


@end
