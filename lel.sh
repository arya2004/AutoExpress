#!/bin/bash
#!/bin/bash
create_folders()
{
mkdir controllers
mkdir routes
mkdir models
mkdir dto
mkdir middleware
mkdir utils
}
create_files()
{
touch app.js
touch README.md
touch .env
touch .gitignore
}
create_MVC()
{
mkdir controllers
mkdir models
mkdir routes
mkdir middleware
mkdir utils
mkdir public
mkdir views
}
#!/bin/bash
npm_install()
{
npm init -y
npm install express
npm install dotenv
npm install cors
npm install mongoose
npm install express-rate-limit
npm i eslint --save-dev
}
install_dependencies()
{
pkgManager="$1"
if [ "$pkgManager" = "npm" ]; then
a="install"
elif [ "$pkgManager" = "yarn" ]; then
a="add"
else
echo "grrrr"
exit 1
fi
$pkgManager init -y
$pkgManager $a express
$pkgManager $a dotenv
$pkgManager $a cors
$pkgManager $a mongoose
$pkgManager $a express-rate-limit
}
#!/bin/bash
index()
{
tee -a app.js <<EOF
if (process.env.NODE_ENV !== "production") {
require('dotenv').config();
}
const express = require('express');
const app = express();
const mongoose = require('mongoose');
const port = process.env.PORT || 3000;
EOF
mongoose_connection
tee -a app.js <<EOF
app.get('/', (req, res) => {
res.send('Hello, Express API!');
});
app.listen(port, () => {
console.log(\`Server running on port \${port}\`);
});
EOF
}
readme()
{
cat <<EOF > README.md
This is a basic Express.js project created using AutoExpress
EOF
}
create_git_ignore()
{
cat <<EOF > .gitignore
# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
lerna-debug.log*
.pnpm-debug.log*
# Diagnostic reports (https://nodejs.org/api/report.html)
report.[0-9]*.[0-9]*.[0-9]*.[0-9]*.json
# Runtime data
pids
*.pid
*.seed
*.pid.lock
# Directory for instrumented libs generated by jscoverage/JSCover
lib-cov
# Coverage directory used by tools like istanbul
coverage
*.lcov
# nyc test coverage
.nyc_output
# Grunt intermediate storage (https://gruntjs.com/creatingplugins#storing-task-files)
.grunt
# Bower dependency directory (https://bower.io/)
bower_components
# node-waf configuration
.lock-wscript
# Compiled binary addons (https://nodejs.org/api/addons.html)
build/Release
# Dependency directories
node_modules/
jspm_packages/
# Snowpack dependency directory (https://snowpack.dev/)
web_modules/
# TypeScript cache
*.tsbuildinfo
# Optional npm cache directory
.npm
# Optional eslint cache
.eslintcache
# Optional stylelint cache
.stylelintcache
# Microbundle cache
.rpt2_cache/
.rts2_cache_cjs/
.rts2_cache_es/
.rts2_cache_umd/
# Optional REPL history
.node_repl_history
# Output of 'npm pack'
*.tgz
# Yarn Integrity file
.yarn-integrity
# dotenv environment variable files
.env
.env.development.local
.env.test.local
.env.production.local
.env.local
# parcel-bundler cache (https://parceljs.org/)
.cache
.parcel-cache
# Next.js build output
.next
out
# Nuxt.js build / generate output
.nuxt
dist
# Gatsby files
.cache/
# Comment in the public line in if your project uses Gatsby and not
Next.js
# https://nextjs.org/blog/next-9-1#public-directory-support
# public
# vuepress build output
.vuepress/dist
# vuepress v2.x temp and cache directory
.temp
.cache
# Docusaurus cache and generated files
.docusaurus
# Serverless directories
.serverless/
# FuseBox cache
.fusebox/
# DynamoDB Local files
.dynamodb/
# TernJS port file
.tern-port
# Stores VSCode versions used for testing VSCode extensions
.vscode-test
# yarn v2
.yarn/cache
.yarn/unplugged
.yarn/build-state.yml
.yarn/install-state.gz
.pnp.*
EOF
}
catto()
{
echo " /\_/\ "
echo "( o.o )"
echo " > ^ <"
echo "Made with love by arya2004"
}
#!/bin/bash
mongo_connection_string()
{
cat <<EOF > .env
MONGO_CONNECTION_STRING=$1
EOF
}
mongoose_connection()
{
tee -a app.js <<EOF
mongoose.connect(MONGO_CONNECTION_STRING, {
useNewUrlParser: true,
useCreateIndex: true,
useUnifiedTopology: true,
useFindAndModify: false
});
const db = mongoose.connection;
db.on("error", console.error.bind(console, "connection error:"));
db.once("open", () => {
console.log("Database connected");
});
EOF
}
basic_model()
{
touch models/weather.js
tee -a models/weather.js <<EOF
const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const weatherSchema = new Schema({
Date:{
type: Date,
required: true
},
temperatureC:{
type: Number,
required: true,
min: 0
},
temperatureF:{
type: Number,
required: true,
default: 32 + (TemperatureC / 0.5556)
},
Summary:{
type: String,
required: false
}
})
module.exports = mongoose.model("Weather", weatherSchema);
EOF
}
create_express_api() {
echo "Creating Express API starter project..."
read -p "Enter your project name: " project_name
if [ -z "$project_name" ]; then
echo "Error: Project name cannot be empty."
exit 1
fi
mkdir "$project_name"
cd "$project_name"
mkdir server
cd server
install_dependencies yarn
#create_MVC
create_folders
create_files
create_git_ignore
readme
index
mongo_connection_string mongodb://localhost:27017/$project_name
basic_model
clear
catto
echo "Express API starter project created successfully."
echo "To start the server, run 'node index.js'."
}
create_express_api