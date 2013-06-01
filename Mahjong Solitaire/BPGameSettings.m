//
//  BPGameSettings.m
//  Mahjong Solitaire
//
//  Created by Bruno Philipe on 6/1/13.
//  Copyright (c) 2013 Bruno Philipe. All rights reserved.
//

#import "BPGameSettings.h"

@implementation BPGameSettings
{
	NSColor *tile_color_side, *tile_color_bott, *tile_color_frnt;
}

+ (BPGameSettings *)sharedInstance
{
	static BPGameSettings *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[BPGameSettings alloc] init];
	});
	return instance;
}

- (id)init
{
	self = [super init];
	if (self) {
		tile_color_side = [NSColor colorWithSRGBRed:0.87 green:0.84 blue:0.75 alpha:1.0];
		tile_color_bott = [NSColor colorWithSRGBRed:0.59 green:0.57 blue:0.50 alpha:1.0];
		tile_color_frnt = [NSColor colorWithSRGBRed:0.82 green:0.81 blue:0.77 alpha:1.0];
	}
	return self;
}

+ (id)getSetting:(BPGAME_SETTINGS)sett
{
	BPGameSettings *settings = [BPGameSettings sharedInstance];

	switch (sett) {
		case BPGAME_TILE_COLOR_BOTTOM:
			return settings->tile_color_bott;
			break;

		case BPGAME_TILE_COLOR_SIDE:
			return settings->tile_color_side;
			break;

		case BPGAME_TILE_COLOR_FACE:
			return settings->tile_color_frnt;
			break;

		default:
			return nil;
			break;
	}
}

@end
