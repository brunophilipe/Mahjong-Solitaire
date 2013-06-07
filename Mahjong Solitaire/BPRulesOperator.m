//
//  BPRulesOperator.m
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

#import "BPRulesOperator.h"

@implementation BPRulesOperator
{
	BPTile *selected_prev, *selected_now;
	BPGameBoard *sharedBoard;
}

+ (BPRulesOperator *)sharedInstance;
{
	static BPRulesOperator *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[BPRulesOperator alloc] init];
	});
	return instance;
}

- (id)init
{
	self = [super init];
	selected_prev = nil;
	selected_now = nil;
	return self;
}

+ (void)setBoard:(BPGameBoard *)board
{
	BPRulesOperator *opr = [BPRulesOperator sharedInstance];

	opr->sharedBoard = board;
}

+ (void)tryToSelectTile:(BPTile *)tile
{
	BPRulesOperator *opr = [BPRulesOperator sharedInstance];

	if ([opr->sharedBoard isTileSelectable:tile]) {
		[tile setSelected:YES];
		[opr->sharedBoard setNeedsDisplay:YES];

		opr->selected_prev = opr->selected_now;
		opr->selected_now = tile;

		if (opr->selected_now && opr->selected_prev && !(opr->selected_now == opr->selected_prev))
		{
			if (opr->selected_now.kind == opr->selected_prev.kind)
			{
				[opr->sharedBoard removeTile:opr->selected_prev];
				[opr->sharedBoard removeTile:opr->selected_now];

				[[NSNotificationCenter defaultCenter] postNotificationName:BP_UPDATE_FREEPAIRS object:self];
			}
			else
			{
				[opr->selected_prev setSelected:NO];
				[opr->selected_now setSelected:NO];
			}

			opr->selected_prev = nil;
			opr->selected_now = nil;
		}
	}
}

+ (void)startNewGame
{
	BPRulesOperator *opr = [BPRulesOperator sharedInstance];

	[opr->sharedBoard newGame];
}

+ (NSUInteger)calculateSelectablePairs
{
	return [[BPRulesOperator sharedInstance]->sharedBoard calculateSelectablePairs];
}

@end
