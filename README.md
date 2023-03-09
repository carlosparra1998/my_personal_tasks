# My Personal Tasks 

Aplicación desarrollada en Flutter para la gestión de tareas del usuario.

[**DESCARGAR APK**](https://github.com/carlosparra1998/WembleyStudiosMovies/raw/main/apk/app-release.apk)

## Funcionamiento

El sistema obtiene las películas de la API de *The Movie DB*: https://www.themoviedb.org/documentation/api?language=es-ES

La siguiente ilustración corresponde con el diagrama de estados de la aplicación.

![](https://github.com/carlosparra1998/WembleyStudiosMovies/blob/main/readme_raw/diagram.png)

El patrón de diseño seguido ha sido **Model View View-Model (MVVM)**, en la cual hemos incorporado la funcionalidad de **Provider** para manejar los estados de la app.

Se ha creado un único ViewModel para la gestión de la funcionalidad inherente a la entidad **Movie**.

La obtención de los datos, tanto de las películas populares como las buscadas por el usuario, se llevará a cabo gracias a un **stream** que comunica el View con el ViewModel de la entidad Movie. Este stream seguirá proporcionando información al View mientras el usuario interactúa con el sistema, como el avance a la siguiente página de películas.

Para la **persistencia** de las películas seleccionadas como favoritas se ha creado una base de datos con *SQLite*. Al iniciar la app, se realiza un volcado de la base de datos a la caché. De esta forma, el usuario tendrá en todo momento disponible su lista de películas favoritas.

## Vídeos de prueba

En este fragmento podemos comprobar el funcionamiento de la lista de películas populares obtenidas por la API correspondiente. Incluso el acceso a la siguiente página de la lista.

<p align="center">
  <img src="https://github.com/carlosparra1998/WembleyStudiosMovies/blob/main/readme_raw/1.gif" />
</p>

En este fragmento podemos comprobar el funcionamiento de las películas **favoritas** del usuario.


<p align="center">
  <img src="https://github.com/carlosparra1998/WembleyStudiosMovies/blob/main/readme_raw/2.gif" />
</p>

En este fragmento podemos comprobar el funcionamiento del **Search Bar**.


<p align="center">
  <img src="https://github.com/carlosparra1998/WembleyStudiosMovies/blob/main/readme_raw/3.gif" />
</p>
