//
//  BPGameSettings.h
//  Mahjong Solitaire
//
//  Created by Bruno Philipe on 6/1/13.
//  Copyright (c) 2013 Bruno Philipe. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum {
	BPGAME_TILE_COLOR_SIDE, BPGAME_TILE_COLOR_BOTTOM, BPGAME_TILE_COLOR_FACE
} BPGAME_SETTINGS;

@interface BPGameSettings : NSObject

+ (BPGameSettings *)sharedInstance;

+ (id)getSetting:(BPGAME_SETTINGS)sett;


@end
