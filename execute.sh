#!/usr/bin/env bash

# process file for fortune
cp assets/dev-tips.txt ~/dev-tips.fortune
vim -c ":%s/\n/\r%\r/g" -c ":wq"  ~/dev-tips.fortune
strfile ~/dev-tips.fortune ~/dev-tips.fortune.dat >/dev/null 2>&1

echo "file processing complete..."

# install fortune
if brew ls --versions fortune > /dev/null; then
  echo "fortune is already installed..."
else
  echo "brew installing fortune..."
  brew install fortune >/dev/null 2>&1
fi

# register fortune commands to bash_profile
if grep -Fxq "fortune ~/dev-tips.fortune" ~/.bash_profile
then
  echo "dev-tips is already installed..."
  echo ""
  echo "[[오늘의 개발 Tip]]"
  fortune ~/dev-tips.fortune
  echo ""
else
  echo -e "echo \"\"\necho \"[[오늘의 개발 Tip]]\"\nfortune ~/dev-tips.fortune\necho \"\"" >> ~/.bash_profile
  source ~/.bash_profile
fi
