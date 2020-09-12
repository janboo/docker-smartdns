#!/usr/bin/env ash

OSARCH=$(uname -m)
case $OSARCH in 
    x86_64)
        BINTAG=smartdns-x86_64
        ;;
    i*86)
        BINTAG=smartdns-x86
        ;;
    arm64|aarch64)
        BINTAG=smartdns-aarch64
        ;;
    arm*)
        BINTAG=smartdns-arm
        ;;
    *)
        echo "unsupported OSARCH: $OSARCH"
        exit 1
        ;;
esac

wget --no-check-certificate -qO- https://api.github.com/repos/pymumu/smartdns/releases/latest \
| grep browser_download_url | grep "$BINTAG" | cut -d '"' -f 4 \
| wget --no-check-certificate --no-verbose -i-
mv smartdns* /bin/smartdns
chmod +x /bin/smartdns
