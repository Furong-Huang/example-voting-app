set -ex

if [ ! -d "./bigcommerce-apitesting-cypress" ]; then
  echo "cloning cypress code..."
  git clone https://github.com/Furong-Huang/bigcommerce-apitesting-cypress.git
else
  echo "cypress directory exists, just pulling the latest code"
  cd bigcommerce-apitesting-cypress && git pull && cd -

  # I think we can comment out below two lines
  touch cypress.json
  echo {} > cypress.json
fi