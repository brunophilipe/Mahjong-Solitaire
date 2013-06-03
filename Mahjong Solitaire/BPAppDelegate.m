//
//  BPAppDelegate.m
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

#import "BPAppDelegate.h"
#import "BPTile.h"
#import "BPRulesOperator.h"

@implementation BPAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
}

- (IBAction)action_newGame:(id)sender {
	NSAlert *alert = [NSAlert alertWithMessageText:@"Start new Game" defaultButton:@"Yes" alternateButton:@"No" otherButton:nil informativeTextWithFormat:@"Are you sure you want to start a new game?"];
	NSInteger ret = [alert runModal];

	if (ret == 1) {
		NSLog(@"Starting new game!");
		[BPRulesOperator startNewGame];
	}
}

@end
