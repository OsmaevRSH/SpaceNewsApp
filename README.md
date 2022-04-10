# SpaceNewsApp
---
#### Для полноценной работы приложения, необходимо иметь устройство с опреционной системой ```IOS 13.2+``` и процессором ```Apple A9``` и выше.
---
## Описание:
>Позновательно-новостное IOS приложение на тему космоса. В данном приложении можно увидеть посление новости по данной теме, стримы и оффлайн видео с YouTube канала NASA. Экран с картой, где можно узнать информацию о количестве жителей текущей области или любой выбранной, а так же список ближайших городов или районов (если текущий выбранный город большой). Также присутсвует AR, который позволяет добавить в реальной мир витрульную Землю, после чего посмотреть на спутники Starlink, а также при нажатии получить информацию по каждому из них.

## Используемые библиотеки и технологии:
### Технологии встроенные в Swift
- ```CoreData``` - используется для сохранения новостей в список для чтения;
- ```Combine``` - используется для реализации архитектуры MVVM в UIKit;
- ```SwiftUI``` - испольуется для создания OnBoarding;
- ```UIKit``` - весь интерфейс кроме OnBoarding;
- ```URLSession``` - испольуется для работы с сетью;
- ```ARKit и SceneKit``` - для работы с AR;
- ```MapKit``` - для работы с картой;
### Сторонние технологии
- ```YouTube-Player-iOS-Helper``` - используется для добавления youtube проигрывателя;
- ```Fast API``` - Python библиотека, была необходма для реализации своего middle back сервера;
- ```Newspaper``` - Python библиотека, использующаяся на middle back сервере для получения текста новости;

## Скриншоты приложения
<table>
  <tr>
    <td>
<img src="/Images/1.jpeg">
    </td>
    <td>
<img src="/Images/2.jpeg">
    </td>
  </tr>
  <tr>
    <td>
<img src="/Images/3.jpeg">
    </td>
    <td>
<img src="/Images/4.jpeg">
    </td>
  </tr>
  <tr>
    <td>
<img src="/Images/5.jpeg">
      </td>
    <td>
<img src="/Images/6.jpeg">
      </td>
  </tr>
  <tr>
    <td>
<img src="/Images/7.jpeg">
      </td>
    <td>
<img src="/Images/8.jpeg">
      </td>
  </tr>
  <tr>
    <td>
<img src="/Images/9.jpeg">
      </td>
    <td>
<img src="/Images/10.jpeg">
      </td>
  </tr>
  <tr>
    <td>
<img src="/Images/11.jpeg">
      </td>
    </tr>
  </table>