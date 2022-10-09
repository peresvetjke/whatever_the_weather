# Whatever the weather!

### Goals
Develop API for weather statistics (external API: AccuWeather https://www.accuweather.com/)

### Built with
- Ruby 2.7.6, Rails 7.0.4;
- DB: postgres;
- API: grape;
- Swagger documentation: grape-swagger, grape-swagger-ui;
- Serializers: grape-active_model_serializers;
- Tests: RSpec, FactoryBot, VCR, shoulda-matchers;
- Background: rufus-scheduler;
- Containerization: Docker.

### When
09.10.22

### Endpoints:

     GET  |  /api/v1/weather/current(.json)             |  v1  |  Current temperature                                
     GET  |  /api/v1/weather/historical(.json)          |  v1  |  Historical temperature for last 24 hours           
     GET  |  /api/v1/weather/max(.json)                 |  v1  |  Maximum temperature of last 24 hours               
     GET  |  /api/v1/weather/min(.json)                 |  v1  |  Minimum temperature of last 24 hours               
     GET  |  /api/v1/weather/avg(.json)                 |  v1  |  Average temperature for last 24 hours              
     GET  |  /api/v1/weather/by_time/:timestamp(.json)  |  v1  |  Temperature by timestamp                           
     GET  |  /api/v1/health(.json)                      |  v1  |  Backend status                                     
     GET  |  /api/v1/swagger                            |  v1  |  Swagger compatible API description                 
 
Check swagger documentation for more details.

Have fun!
