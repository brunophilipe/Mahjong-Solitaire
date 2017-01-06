//
//  BPGameSettings.h
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

#import <Cocoa/Cocoa.h>

typedef enum {
	BPGAME_TILE_COLOR_SIDE,
	BPGAME_TILE_COLOR_BOTTOM,
	BPGAME_TILE_COLOR_FACE,
	BPGAME_TILE_COLOR_LINE,
	BPGAME_TILE_COLOR_SELECTED,
	BPGAME_TILE_SIZE_WIDTH,
	BPGAME_TILE_SIZE_HEIGHT,
	BPGAME_TILE_SIZE_THICKNESS
} BPGAME_SETTINGS;

@interface BPGameSettings : NSObject

+ (BPGameSettings *)sharedInstance;

+ (id)getSetting:(BPGAME_SETTINGS)sett;


@end
