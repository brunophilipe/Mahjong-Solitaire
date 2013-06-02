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

#define MAX_HOR 7
#define MAX_VER 6

@implementation BPGameBoard
{
	BPTile *tiles[MAX_VER][MAX_HOR];
}

BOOL tile_base[MAX_VER][MAX_HOR] =
{
	{1,1,1,1,1,1,1},
	{1,1,1,1,1,1,1},
	{1,1,1,1,1,1,1},
	{1,1,1,1,1,1,1},
	{1,1,1,1,1,1,1},
	{1,1,1,1,1,1,1}
};

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
		[BPRulesOperator setBoard:self];
		[self newGame];
    }
    
    return self;
}

- (void)newGame
{
	BPTile *auxTile;

	for (NSInteger y=MAX_VER-1; y>=0; y--)
	{
		for (NSUInteger x=0; x<MAX_HOR; x++)
		{
			if (tile_base[y][x])
			{
				auxTile = [[BPTile alloc] initWithFrame:[self calculateRectForTileInCoordX:x andY:y]];
				[auxTile setCoords:NSMakePoint(x, y)];
				[auxTile.label setStringValue:[NSString stringWithFormat:@"%ld,%ld",(unsigned long)x,(long)y]];

				tiles[y][x] = auxTile;

				[self addSubview:auxTile positioned:NSWindowBelow relativeTo:nil];
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

/*
- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
	NSBezierPath *path = [NSBezierPath bezierPath];

	[path moveToPoint:NSMakePoint(10, 10)];

	[path lineToPoint:NSMakePoint(10, self.bounds.size.height-10)];
	[path lineToPoint:NSMakePoint(self.bounds.size.width-10, self.bounds.size.height-10)];
	[path lineToPoint:NSMakePoint(self.bounds.size.width-10, 10)];
	[path lineToPoint:NSMakePoint(10, 10)];

	[[NSColor blackColor] set];

	[path stroke];
}
 */

@end
