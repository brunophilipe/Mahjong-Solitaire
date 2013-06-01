//
//  BPGameSettings.m
//  Mahjong Solitaire
//
//  Created by Bruno Philipe on 6/1/13.
//  Copyright (c) 2013 Bruno Philipe - www.brunophilipe.com - contact@brunophilipe.com
//
//	This program is free software: you can redistribute it and/or modify
//	it under the terms of the GNU General Public License as published by
//	the Free Software Foundation, either version 3 of the License, or
//	(at your option) any later version.
//
//	This program is distributed in the hope that it will be useful,
//	but WITHOUT ANY WARRANTY; without even the implied warranty of
//	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//	GNU General Public License for more details.
//
//	You should have received a copy of the GNU General Public License
//	along with this program.  If not, see <http://www.gnu.org/licenses/>.
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
