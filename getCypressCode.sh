set -ex

if [ ! -d "./BigCommerce-APITesting-using-Cypress" ]; then
  echo "cloning cypress code..."
  git clone https://github.com/Furong-Huang/BigCommerce-APITesting-using-Cypress.git
else
  echo "cypress directory exists, just pulling the latest code"
  cd BigCommerce-APITesting-using-Cypress && git pull && cd -

  # I think we can comment out below two lines
  touch cypress.json
  echo {} > cypress.json
fi