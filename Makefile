XCODE_PATH = $(shell xcode-select --print-path)
IOS_CC = $(XCODE_PATH)/Platforms/iPhoneOS.platform/Developer/usr/bin/gcc
SDK_PATH = $(shell find $(XCODE_PATH)/Platforms/iPhoneOS.platform -name "iPhoneOS*sdk" | sort -rn | head -1)

all: demo.app fruitstrap

demo.app: demo Info.plist
	mkdir -p demo.app
	cp demo demo.app/
	cp Info.plist ResourceRules.plist demo.app/
	codesign -f -s "iPhone Developer" --entitlements Entitlements.plist demo.app


fruitstrap: fruitstrap.c
	gcc -o fruitstrap -framework CoreFoundation -framework MobileDevice -F/System/Library/PrivateFrameworks fruitstrap.c

install: all
	./fruitstrap demo.app

debug: all
	./fruitstrap -d demo.app

clean:
	rm -rf *.app demo fruitstrap
