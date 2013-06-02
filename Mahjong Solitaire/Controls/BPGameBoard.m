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
#import "BPRulesOperator.h"
#import "NSMutableArray+Shuffling.h"

#define MAX_HOR 8
#define MAX_VER 6

@implementation BPGameBoard
{
	BPTile *tiles[MAX_VER][MAX_HOR];
	NSColor *background_color;
}

BOOL tile_base[MAX_VER][MAX_HOR] =
{
	{0,1,1,1,1,1,1,0},
	{1,1,1,1,1,1,1,1},
	{1,1,1,1,1,1,1,1},
	{1,1,1,1,1,1,1,1},
	{1,1,1,1,1,1,1,1},
	{0,1,1,1,1,1,1,0}
};

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
		[BPRulesOperator setBoard:self];

		//Set background pattern
		background_color = [NSColor colorWithPatternImage:[NSImage imageNamed:@"background"]];

		[self newGame];
    }
    
    return self;
}

- (void)newGame
{
	BPTile *auxTile;
	NSUInteger tilesCount = 0;

	for (NSInteger y=MAX_VER-1; y>=0; y--)
	{
		for (NSUInteger x=0; x<MAX_HOR; x++)
		{
			if (tile_base[y][x])
			{
				auxTile = [[BPTile alloc] initWithFrame:[self calculateRectForTileInCoordX:x andY:y]];
				[auxTile setCoords:NSMakePoint(x, y)];
				[auxTile setKind:-1];

				tiles[y][x] = auxTile;

				[self addSubview:auxTile positioned:NSWindowBelow relativeTo:nil];

				tilesCount++;
			}
		}
	}

	if (tilesCount%2 != 0) {
		NSAlert *alert = [NSAlert alertWithMessageText:@"Configuration Error" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"The quantity of initialized tiles must be an even number, there are %ld initialized tiles!",(unsigned long)tilesCount];
		[alert runModal];
		[[NSApplication sharedApplication] terminate:self];
	}

	//Set kinds
	NSMutableArray *kindsBase = [[NSMutableArray alloc] initWithCapacity:tilesCount];
	for (NSUInteger i=0; i<tilesCount/2; i++) {
		int kind = arc4random()%12;
		[kindsBase addObject:[NSNumber numberWithInt:kind]];
		[kindsBase addObject:[NSNumber numberWithInt:kind]];
	}

	[kindsBase shuffle];

	for (NSInteger y=MAX_VER-1; y>=0; y--)
	{
		for (NSUInteger x=0; x<MAX_HOR; x++)
		{
			if (tiles[y][x])
			{
				int index = arc4random()%(kindsBase.count);
				int kind = [(NSNumber *)[kindsBase objectAtIndex:index] intValue];
				[(BPTile *)tiles[y][x] setKind:kind];
				[[(BPTile *)tiles[y][x] label] setStringValue:[NSString stringWithFormat:@"%d",kind]];
				[kindsBase removeObjectAtIndex:index];
			}
		}
	}

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(boardDidResize:) name:NSWindowDidResizeNotification object:nil];
}

- (NSRect)calculateRectForTileInCoordX:(NSUInteger)x andY:(NSUInteger)y
{
	NSUInteger width = [(NSNumber *)[BPGameSettings getSetting:BPGAME_TILE_SIZE_WIDTH] unsignedIntegerValue];
	NSUInteger height = [(NSNumber *)[BPGameSettings getSetting:BPGAME_TILE_SIZE_HEIGHT] unsignedIntegerValue];
	NSUInteger thickness = [(NSNumber *)[BPGameSettings getSetting:BPGAME_TILE_SIZE_THICKNESS] unsignedIntegerValue];

	return
	NSMakeRect
	(
		(self.frame.size.width/2) - (MAX_HOR*width/2) + x*(width-thickness),
		(self.frame.size.height/2) + (MAX_VER*height/2) - (y+1.2)*(height-thickness),
		width,
		height
	);
}

- (BOOL)isTileSelectable:(BPTile *)tile
{
	NSInteger x = tile.coords.x;
	NSInteger y = tile.coords.y;

	//Check left
	if (x == 0 || tiles[y][x-1] == nil) {
		return YES;
	}

	//Check right
	if (x == MAX_HOR-1 || tiles[y][x+1] == nil) {
		return YES;
	}

	return NO;
}

- (void)removeTile:(BPTile *)tile
{
	[tile removeFromSuperview];

	NSPoint coord = tile.coords;

	tiles[(int)coord.y][(int)coord.x] = nil;
}

- (void)boardDidResize:(NSNotification *)n
{
	for (NSInteger y=MAX_VER-1; y>=0; y--)
	{
		for (NSUInteger x=0; x<MAX_HOR; x++)
		{
			if (tiles[y][x]) {
				[tiles[y][x] setFrame:[self calculateRectForTileInCoordX:x andY:y]];
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

@end
