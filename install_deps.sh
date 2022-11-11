echo "Installing classic..."
echo "1/3 clone"
git clone https://github.com/rxi/classic.git
echo "2/3 install"
mv classic/classic.lua classic.lua
echo "3/3 delete"
rm -rf classic
echo "classic installed"
echo "all dependencies installed"