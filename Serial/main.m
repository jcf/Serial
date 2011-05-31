//
//  main.m
//  Serial
//
//  Created by James Conroy-Finn on 31/05/2011.
//  Copyright 2011 logi.cl. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
  return macruby_main("rb_main.rb", argc, argv);
}
