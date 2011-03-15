PREFIX := /data/local

all: build install

clean: clean-rec
#	$(RM) -r openssl/obj
#	$(RM) -r openssl/libs
#	$(RM) -r openssl/crypto/libs
#	$(RM) -r ipsec-tools/obj
#	$(RM) -r ipsec-tools/libs

clean-rec:
	ndk-build -C external/openssl clean
	ndk-build -C external/ipsec-tools

build:
	touch --date="2011-03-06" external/openssl/Android.mk && ndk-build -C external/openssl
	touch --date="2011-03-06" external/ipsec-tools/Android.mk && OPENSSL_INC=$(PWD)/external/openssl/include OPENSSL_LIB=$(PWD)/external/openssl/libs/armeabi ndk-build -C external/ipsec-tools

install:
	adb push external/openssl/libs/armeabi/libcrypto.so $(PREFIX)
	adb push external/openssl/libs/armeabi/libssl.so $(PREFIX)
	adb push external/openssl/libs/armeabi/openssl $(PREFIX)
	adb push external/ipsec-tools/libs/armeabi/libipsec.so $(PREFIX)
	adb push external/ipsec-tools/libs/armeabi/racoon $(PREFIX)
	adb push external/ipsec-tools/libs/armeabi/setkey $(PREFIX)
