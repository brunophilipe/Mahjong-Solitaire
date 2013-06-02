//
//  NSMutableArray+Shuffling.m
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

#import "NSMutableArray+Shuffling.h"

@implementation NSMutableArray (Shuffling)

- (void)shuffle {
    @synchronized(self) {
        NSUInteger count = [self count];

        if (count < 2) {
            return;
        }

		for (NSUInteger j=0; j<4; j++) {
			for (NSUInteger i = 0; i < count; i++) {
				NSUInteger j = arc4random() % (count - 1);

				if (j != i) {
					[self exchangeObjectAtIndex:i withObjectAtIndex:j];
				}
			}
		}
    }
}

@end
