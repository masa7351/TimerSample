#!/bin/sh

cd `dirname $0`
cd ../
Pods/SwiftFormat/CommandLineTool/swiftformat . --exclude Carthage,Pods --stripunusedargs closure-only --disable strongOutlets,trailingCommas
