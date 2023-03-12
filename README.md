# My Personal Tasks 

Aplicación desarrollada en Flutter para la gestión de tareas del usuario.

[**DESCARGAR APK**](https://github.com/carlosparra1998/my_personal_tasks/raw/main/apk/app-release.apk)

## Funcionamiento

La siguiente ilustración corresponde con el diagrama de estados de la aplicación.

![](https://github.com/carlosparra1998/my_personal_tasks/blob/main/readme_raw/diagram.png)

El patrón de diseño seguido ha sido **Model View View-Model (MVVM)**, en la cual hemos incorporado la funcionalidad de **Provider** para manejar los estados de la app.

Se han creado dos ViewModel, el primero (**TaskViewModel**) gestiona las tareas del usuario, en la que se incluye adición, modificación y borrado, tanto en memoria como en Firebase. El segundo (**ThemeViewModel**) facilita la gestión de los colores de los temas de la aplicación (claro y oscuro).

La obtención de los datos se llevará a cabo gracias a un **stream** que comunica el View con el ViewModel de la entidad Task. Este stream seguirá proporcionando tareas a la lista (tanto de Firebase como de memoria caché) al View mientras el usuario interactúa con el sistema.

Se ha incorporado un sistema de prioridades en el que permite etiquetar cada tarea según su importancia. En la aplicación se incluye la **prioridad 1 (ALTA)**, la **prioridad 2 (MEDIA)** y la **prioridad 3 (BAJA)**. 

## Resultados de los widget tests

*Para que funcionen todos los tests automatizados, se recomienda ejecutarlos todos de forma simultánea.*

```sh
flutter run -t test/widget_test.dart
```



<p align="center">
  <img src="https://github.com/carlosparra1998/my_personal_tasks/blob/main/readme_raw/tests.png" />
</p>

## Vídeos de prueba

En este fragmento podemos ver como se realiza la adición de nuevas tareas a la lista.

<p align="center">
  <img src="https://github.com/carlosparra1998/my_personal_tasks/blob/main/readme_raw/4.gif" />
</p>

En este fragmento podemos ver como se realiza la modificación de tareas existentes.


<p align="center">
  <img src="https://github.com/carlosparra1998/my_personal_tasks/blob/main/readme_raw/3.gif" />
</p>

En este fragmento podemos ver como se realiza el borrado de tareas de la lista al seleccionar el botón situado a la izquierda (con animación).


<p align="center">
  <img src="https://github.com/carlosparra1998/my_personal_tasks/blob/main/readme_raw/2.gif" />
</p>

En este fragmento podemos ver como se realiza el cambio del tema oscuro al tema claro.


<p align="center">
  <img src="https://github.com/carlosparra1998/my_personal_tasks/blob/main/readme_raw/1.gif" />
</p>

