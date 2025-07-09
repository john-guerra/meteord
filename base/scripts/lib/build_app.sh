set -e
set -x

# Add meteor to PATH
export PATH=/root/.meteor:$PATH

COPIED_APP_PATH=/copied-app
BUNDLE_DIR=/tmp/bundle-dir

# sometimes, directly copied folder cause some wierd issues
# this fixes that
echo "=> Copying the app"
cp -R /app $COPIED_APP_PATH
cd $COPIED_APP_PATH

echo "=> Executing NPM install --production"
meteor npm install --production --allow-superuser

echo "=> Executing Meteor Build..."
export

# Detect architecture for build compatibility
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        METEOR_ARCH="os.linux.x86_64"
        ;;
    aarch64)
        METEOR_ARCH="os.linux.x86_64"  # Meteor still uses x86_64 for ARM64 builds
        ;;
    *)
        echo "Unsupported architecture: $ARCH, defaulting to x86_64"
        METEOR_ARCH="os.linux.x86_64"
        ;;
esac

meteor build \
  --allow-superuser \
  --directory $BUNDLE_DIR \
  --server=http://localhost:3000 \
  --architecture=$METEOR_ARCH

echo "=> Printing Meteor Node information..."
echo "  => platform"
meteor node -p process.platform
echo "  => arch"
meteor node -p process.arch
echo "  => versions"
meteor node -p process.versions

echo "=> Printing System Node information..."
echo "  => platform"
node -p process.platform
echo "  => arch"
node -p process.arch
echo "  => versions"
node -p process.versions

echo "=> Executing NPM install within Bundle"
cd $BUNDLE_DIR/bundle/programs/server/
npm i

echo "=> Moving bundle"
mv $BUNDLE_DIR/bundle /built_app

echo "=> Cleaning up"
# cleanup
echo " => COPIED_APP_PATH"
rm -rf $COPIED_APP_PATH
echo " => BUNDLE_DIR"
rm -rf $BUNDLE_DIR
echo " => .meteor"
rm -rf ~/.meteor
# meteor might be installed via npm, so use -f to ignore if not found
# rm -f /usr/local/bin/meteor