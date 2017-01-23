//
//  BasicTextCollectionViewCell.m
//  KSTCollectionViewPageHorizontalLayout
//
//  Created by Zeng on 22/12/2016.
//  Copyright © 2016 Zeng. All rights reserved.
//

#import "BasicTextCollectionViewCell.h"

@implementation BasicTextCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		UILabel *label = [[UILabel alloc] init];
		label.text = @"testing";
		label.font = [UIFont systemFontOfSize:14];
		[label sizeToFit];
		[self.contentView addSubview:label];
		self.textLabel = label;
	}
	return self;
}

@end
