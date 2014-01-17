//
//  MRToggleButton.h
//  MatchReminder
//
//  Created by Rogelio Gudino on 12/22/13.
//  Copyright (c) 2013 Cananito. All rights reserved.
//

// [ Off ]
// [  On ]

@interface MRToggleButton : UIControl

@property (nonatomic, strong) NSString *onText;
@property (nonatomic, strong) NSString *offText;
@property (nonatomic, strong) UIColor *onColor;
@property (nonatomic, strong) UIColor *offColor;
@property (nonatomic, assign, readonly) BOOL isOn;

- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end
