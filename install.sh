cd ~ || exit

# Download
curl -sSL https://raw.githubusercontent.com/Atomanti007/generator/main/generate.sh -o pgen
chmod +x pgen
sudo mv pgen /usr/local/bin/

# Download
curl -sSL https://git.io/get-mo -o mo
chmod +x mo
sudo mv mo /usr/local/bin/

sudo apt-get install dialog
