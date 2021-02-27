set -ex

if [ ! -d "./cypress_automation_testing-commercial_website" ]; then
  echo "cloning cypress code..."
  git clone https://github.com/Furong-Huang/cypress_automation_testing-commercial_website.git
else
  echo "cypress directory exists, just pulling the latest code"
  cd cypress_automation_testing-commercial_website && git pull && cd -

  # I think we can comment out below two lines
  #touch cypress.json
  #echo {} > cypress.json
fi