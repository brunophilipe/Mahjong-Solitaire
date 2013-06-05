//
//  BPGameBoard.h
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

#import <Cocoa/Cocoa.h>
#import "BPTile.h"

/**
 Class responsible for storing the state of the game-board and also used to display the game on the screen. The `BPTile` objects should not be manually added to this class' subviews, they are managed in a manner different from usual. To start a new game simply call `newGame`.
 */
@interface BPGameBoard : NSView

/**
 Clears the game-board and generates a new game.
 */
- (void)newGame;

/**
 Verifies if the parameter tile is selectable.
 
 Note: The parameter passed is of type `BPTile` for convinience. This method does not verify if the parameter tile is an actual tile of the game, it just ferify its coordinates. Improvements in this class are in the to-do list.

 @param tile Tile whose selectability should be verified.
 @returns `YES` if the tile is selectable, otherwise `NO`.
 */
- (BOOL)isTileSelectable:(BPTile *)tile;

/**
 Removes the parameter tile from the game-board. This method does not verify if the parameter tile is an actual tile of the game, it just ferify its coordinates. Improvements in this class are in the to-do list.
 
 @param tile The tile that should be removed from the board.
 */
- (void)removeTile:(BPTile *)tile;

@end