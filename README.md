# spica_app

1.Narediš eno enostavno aplikacijo z enim zaslonom.
2.Na zaslonu imaš tri tipe podatkov, kot prikazuje slika:
-Vrstico z datumi enega tedna
-Seznam vseh logov izbranega datuma
-Navigation bar, ki ima samo »Home«


3.Seznam logov dobiš preko MyHours APIja:
-Za avtorizacijo: https://myhoursdevelopment-api.azurewebsites.net/api/tokens/login
{

                "grantType":"password",

    "email":"luke.skywalker@myhours.com",

                "password":"Myhours123",

                "clientId":"3d6bdd0e-5ee2-4654-ac53-00e440eed057"

            }

-Za pridobivanje logov: https://myhoursdevelopment-api.azurewebsites.net/api/logs
-Vsak klic, ki je zaščiten z Authorize attributom, potrebuje header: Authorization z vrednostjo »Bearer {{AccessToken}}«
-Vsa API dokumentacija je na voljo tu: https://myhoursdevelopment-api.azurewebsites.net/swagger/index.html
4.Implementiraj swipe left in swipe right funkcionalnosti za pomikanje med datumi. Uporabljeni widget naj posluša za swipe samo v sredinskem delu aplikacije.
5.Uporabiš lahko katerikoli state management
