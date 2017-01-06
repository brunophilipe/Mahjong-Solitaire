//
//  BPGameBoard.m
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

#import "BPGameBoard.h"
#import "BPGameSettings.h"
#import "BPAppDelegate.h"
#import "BPRulesOperator.h"
#import "NSMutableArray+Shuffling.h"

#define MAX_HOR 10
#define MAX_VER 8
#define MAX_UPW 3

@implementation BPGameBoard
{
	BPTile *tiles[MAX_UPW][MAX_VER][MAX_HOR];
	NSColor *background_color;
}

/**
 `BOOL` reference matrix used to initialize the game. Maybe this can be read from a text file. In the to-do list.
 */
BOOL tile_base[MAX_UPW][MAX_VER][MAX_HOR] =
{
//	{
//		{0,1,1,1,1,1,1,1,1,0},
//		{1,1,1,1,1,1,1,1,1,1},
//		{1,1,1,1,1,1,1,1,1,1},
//		{1,1,1,1,1,1,1,1,1,1},
//		{1,1,1,1,1,1,1,1,1,1},
//		{1,1,1,1,1,1,1,1,1,1},
//		{1,1,1,1,1,1,1,1,1,1},
//		{0,1,1,1,1,1,1,1,1,0}
//	},
	{
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,1,1,1,1,1,1,0,0},
		{0,1,1,1,1,1,1,1,1,0},
		{0,1,1,1,1,1,1,1,1,0},
		{0,1,1,1,1,1,1,1,1,0},
		{0,1,1,1,1,1,1,1,1,0},
		{0,0,1,1,1,1,1,1,0,0},
		{0,0,0,0,0,0,0,0,0,0}
	},
	{
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,1,1,1,1,0,0,0},
		{0,0,1,1,1,1,1,1,0,0},
		{0,0,1,1,1,1,1,1,0,0},
		{0,0,0,1,1,1,1,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0}
	},
	{
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,1,1,0,0,0,0},
		{0,0,0,0,1,1,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0}
	}
};

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
        // Initialization code here.
		[BPRulesOperator setBoard:self];

		//Set background pattern
		background_color = [NSColor colorWithPatternImage:[NSImage imageNamed:@"background"]];

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(boardDidResize:) name:NSWindowDidResizeNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newGame) name:BP_NEW_GAME object:nil];
    }
    
    return self;
}

- (void)newGame
{
	BPTile *auxTile;
	NSUInteger tilesCount = 0;

	//Initializes the tiles from the reference `BOOL` matrix. Note it does not set the tile kind. This is done later.
	for (NSInteger z=MAX_UPW-1; z>=0; z--)
	{
		for (NSInteger y=MAX_VER-1; y>=0; y--)
		{
			for (NSUInteger x=0; x<MAX_HOR; x++)
			{
				if (tiles[z][y][x])
				{
					[tiles[z][y][x] removeFromSuperview];
					tiles[z][y][x] = nil;
				}

				if (tile_base[z][y][x])
				{
					auxTile = [[BPTile alloc] initWithFrame:[self calculateRectForTileInCoordX:x andY:y andZ:z]];
					[auxTile setCoords:BPMakePoint(x, y, z)];

					tiles[z][y][x] = auxTile;

					[self addSubview:auxTile positioned:NSWindowBelow relativeTo:nil];

					tilesCount++;
				}
			}
		}
	}

	//Checks if the amount of tiles is correct. It should be an even number!
	if (tilesCount%2 != 0)
	{
		NSAlert *alert = [NSAlert alertWithMessageText:@"Configuration Error"
										 defaultButton:@"OK"
									   alternateButton:nil
										   otherButton:nil
							 informativeTextWithFormat:@"The quantity of initialized tiles must be an even number, there are %ld initialized tiles!",(unsigned long)tilesCount];
		[alert runModal];
		[[NSApplication sharedApplication] terminate:self];
	}

	//Generates the kinds, pair by pair, then shuffles them.
	NSMutableArray *kindsBase = [[NSMutableArray alloc] initWithCapacity:tilesCount];
	for (NSUInteger i=0; i<tilesCount/2; i++)
	{
		int kind = (int)((arc4random()%1000)/1000.f * 15);

		[kindsBase addObject:[NSNumber numberWithInt:kind]];
		[kindsBase addObject:[NSNumber numberWithInt:kind]];
	}
	[kindsBase shuffle];

	//Now it set the kinds for each tile.
	for (NSInteger z=MAX_UPW-1; z>=0; z--)
	{
		for (NSInteger y=MAX_VER-1; y>=0; y--)
		{
			for (NSUInteger x=0; x<MAX_HOR; x++)
			{
				if (tiles[z][y][x])
				{
					int index = arc4random()%(kindsBase.count);
					int kind = [(NSNumber *)[kindsBase objectAtIndex:index] intValue];
					[(BPTile *)tiles[z][y][x] setKind:kind];
					[[(BPTile *)tiles[z][y][x] label] setStringValue:[NSString stringWithFormat:@"%d %ld",kind,(unsigned long)z]];
					[kindsBase removeObjectAtIndex:index];
				}
			}
		}
	}

	//Finishes by telling the graphics server to re-render the view.
	[self setNeedsDisplay:YES];

	NSBlockOperation *block = [NSBlockOperation blockOperationWithBlock:^
	{
		NSNotification *notif = [NSNotification notificationWithName:BP_UPDATE_STATUSBAR
															  object:self
															userInfo:@{BP_MESSAGE: @"Game started!"}];

		[[NSNotificationCenter defaultCenter] postNotification:notif];
	}];
	[block start];

	[[NSNotificationCenter defaultCenter] postNotificationName:BP_UPDATE_FREEPAIRS object:self];
}

- (NSUInteger)calculateSelectablePairs
{
	NSUInteger kinds[15] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
	NSUInteger pairs = 0;
	BPTile *tile;

	for (NSUInteger z=0; z<MAX_UPW; z++)
	{
		for (NSUInteger y=0; y<MAX_VER; y++)
		{
			for (NSUInteger x=0; x<MAX_HOR; x++)
			{
				tile = tiles[z][y][x];
				if (tile && [self isTileSelectable:tile])
				{
					kinds[tile.kind]++;
				}
			}
		}
	}

	for (NSUInteger i=0; i<15; i++)
	{
		if (kinds[i] != 0)
		{
			//The number of non-directed connections between n numbers is equal to the nth-1 tringular number, calculated by (n*(n+1))/2.
			pairs += triangular(kinds[i]-1);
		}
	}

	return pairs;
}

/**
 Calculates the location of a tile based on its location and the tile default thickness.
 
 @param x The tile's location in the X axis.
 @param y The tile's location in the Y axis.
 @param z The tile's location in the Z axis.
 @returns NSRect with the size and location of the tile.
 */
- (NSRect)calculateRectForTileInCoordX:(NSUInteger)x andY:(NSUInteger)y andZ:(NSUInteger)z
{
	NSUInteger frame_width = self.frame.size.width - 20;
	NSUInteger frame_height = self.frame.size.height - 20;
	NSUInteger thickness = [(NSNumber *)[BPGameSettings getSetting:BPGAME_TILE_SIZE_THICKNESS] unsignedIntegerValue];
	NSUInteger width;
	NSUInteger height;

	if ((frame_width/MAX_HOR) >= (frame_height/MAX_VER)*0.7333)
	{
		height = (frame_height/MAX_VER) + thickness;
		width = height*0.7333;
	}
	else
	{
		width = (frame_width/MAX_HOR) + thickness;
		height = width*1.3636;
	}

	return //new line, just for eye sugaring
	NSMakeRect
	(
		(self.frame.size.width/2) - (MAX_HOR*width/2) + x*(width-thickness) + (z*thickness) + 15,
		(self.frame.size.height/2) + (MAX_VER*height/2) - (y+1)*(height-thickness) + (z*thickness) - 20,
		width,
		height
	);
}

- (BOOL)isTileSelectable:(BPTile *)tile
{
	NSInteger x = tile.coords.x;
	NSInteger y = tile.coords.y;
	NSInteger z = tile.coords.z;

	//Check up
	if (!(z == MAX_UPW-1 || tiles[z+1][y][x] == nil))
	{
		return NO;
	}

	//Check left
	if (x == 0 || tiles[z][y][x-1] == nil)
	{
		return YES;
	}

	//Check right
	if (x == MAX_HOR-1 || tiles[z][y][x+1] == nil)
	{
		return YES;
	}

	return NO;
}

- (NSUInteger)calculatePlacedTiles
{
	BPTile *tile;
	NSUInteger count = 0;

	for (NSUInteger z=0; z<MAX_UPW; z++)
	{
		for (NSUInteger y=0; y<MAX_VER; y++)
		{
			for (NSUInteger x=0; x<MAX_HOR; x++)
			{
				tile = tiles[z][y][x];
				if (tile)
				{
					count++;
				}
			}
		}
	}

	return count;
}

- (void)removeTile:(BPTile *)tile
{
	[tile removeFromSuperview];

	BPPoint coord = tile.coords;

	tiles[(int)coord.z][(int)coord.y][(int)coord.x] = nil;
}

- (void)boardDidResize:(NSNotification *)n
{
	for (NSUInteger z=0; z<MAX_UPW; z++)
	{
		for (NSInteger y=MAX_VER-1; y>=0; y--)
		{
			for (NSUInteger x=0; x<MAX_HOR; x++)
			{
				if (tiles[z][y][x])
				{
					[tiles[z][y][x] setFrame:[self calculateRectForTileInCoordX:x andY:y andZ:z]];
				}
			}
		}
	}

	[self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
	NSBezierPath *path = [NSBezierPath bezierPath];

	[path moveToPoint:NSMakePoint(0, 0)];

	[path lineToPoint:NSMakePoint(0, self.bounds.size.height)];
	[path lineToPoint:NSMakePoint(self.bounds.size.width, self.bounds.size.height)];
	[path lineToPoint:NSMakePoint(self.bounds.size.width, 0)];
	[path lineToPoint:NSMakePoint(0, 0)];

	[background_color set];

	[path fill];
}

unsigned long triangular(unsigned long input)
{
	return (input*(input+1))/2;
}

@end
