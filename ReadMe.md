# Deploy multiple static web apps using single virtual server - Nginx

This example will show how nginx can serve multiple different application on single virtual server using location mapping. This example will specifically focus on application powered by react. Although the method will be similar for others apps too.


Following are the changes which are required to do before creating build.

1. Have to add `process.env.PUBLIC_URL` before each route and link to your app.
1. Introduce new property `entrypoint` at the root of the `package.json` file and and give path which you want your application to bind with eg. /v1 or /v2 or /alpha etc...
3. Now create build of your application. `$ npm run build`

The full path of the entire application will look as follows - Example
- app.domain.com/v1
- app.domain.com/alpha
- app.domain.com/beta


App directory structure
```txt
/www
  /v1
  /v2
  /app
  /beta
```


```jsx
// 1. Add prefix process.env.PUBLIC_URL before each path and link

const PREFIX = process.env.PUBLIC_URL;

<Router>
  <Route 
    to={`${PREFIX}/home`} 
    component={Home} 
  />
  <Route 
    to={`${PREFIX}/dashboard`} 
    component={Dashboard} 
  />
  <Route 
    to={`${PREFIX}/settings`} 
    component={Settings} 
  />
</Router>

<Link to={`${PREFIX}/home`}> Home </Link>
<Link to={`${PREFIX}/dashboard`}> Dashboard </Link>
<Link to={`${PREFIX}/settings`}> Settings </Link>

```

```json
// 2. Introduce new property in package.json

{
  "entrypoint": "/v1"
  ...
}
```

```sh
# 3. Create build and copy that build to specified directory after changes listed above
$ npm run build && cp -r build ../www/v1
$ npm run build && cp -r build ../www/v2
$ npm run build && cp -r build ../www/app
$ npm run build && cp -r build ../www/beta
```

Prerequisites to run the application
- Nodejs
- Docker
- Docker Compose
- Curl utility
- Bash

NOTE: Before running the application you have to create the build manually by hand and place them to the required directory specified in `nginx/nginx.conf` or run the bash script by `$ ./auto-generate-build.sh` *FEATURE UNAVAILABLE FOR NOW*


Start and run application
```sh
# run the application
$ docker-compose up -d

# test
$ curl http://localhost/
$ curl http://localhost/v1
$ curl http://localhost/v2
$ curl http://localhost/beta
```

References: 
- [Deploy react app to subdirectory](https://medium.com/@svinkle/how-to-deploy-a-react-app-to-a-subdirectory-f694d46427c1)
- [Host multiple fontends on one nginx server](https://nicolasbaptista.com/2020/12/29/host-multiple-frontend-react-angular-app-on-one-nginx-server/)
