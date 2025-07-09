set -e

# Ensure METEOR_ALLOW_SUPERUSER is set
export METEOR_ALLOW_SUPERUSER=true

# Install Meteor using the recommended npm method
# Fallback to curl if npm method fails
# Pin to Meteor 3.2 for compatibility
if ! npm install -g meteor@3.2 --foreground-script; then
    echo "NPM installation failed, falling back to curl method..."
    curl -sL https://install.meteor.com/?release=3.2 | sed s/--progress-bar/-sL/g | METEOR_ALLOW_SUPERUSER=true /bin/sh
fi
