SCRIPT_DIR="$(dirname "$0")"
KEY_ALIAS="androiddebugkey"
PASSWORD="password"
JKS_FILE="./../android/debug.jks"

cd $SCRIPT_DIR

func()
{
    if [ -e $JKS_FILE ]; then
        echo "../android/debug.jks はすでに存在します"
        return 0
    fi
    keytool -genkey -v -keystore $JKS_FILE -alias $KEY_ALIAS -storepass $PASSWORD -keypass $PASSWORD -keyalg RSA -validity 10000 -dname "CN=Android Debug,O=Android,C=JP"  -storetype JKS
    keytool -list -v -alias $KEY_ALIAS -keystore $JKS_FILE -storepass $PASSWORD
    keytool -exportcert -alias $KEY_ALIAS -storepass $PASSWORD -keystore $JKS_FILE | openssl sha1 -binary | openssl base64
}

func
