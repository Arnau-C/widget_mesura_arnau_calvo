<h1 align="center">📐 Mesurador de Plànols - Flutter</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Arquitectura-MVVM-success?style=for-the-badge" alt="MVVM">
</p>

<p align="center">
  <strong>Una eina interactiva per carregar mapes o plànols i mesurar distàncies vectorials entre punts en temps real.</strong>
</p>

---

## 📸 Demostració Visual



---

## ✨ Característiques Principals

* 📁 **Càrrega de fitxers natius:** Explorador d'arxius integrat per seleccionar imatges locals.
* 🎯 **Interacció Tàctil/Clic:** Detecció precisa de coordenades globals a locals.
* 📏 **Renderitzat Vectorial:** Dibuix de línies en temps real utilitzant `CustomPaint` sobre el llenç.
* 🔄 **Reactivitat:** Gestió d'estat sòlida i desacoblada amb el paquet `provider`.

---

## 📖 Guia d'Usuari

L'ús de l'eina és extremadament senzill i intuïtiu:

### 1. Preparar l'àrea de treball
Fes clic a la icona de la **carpeta (📁)** a la barra superior dreta. S'obrirà el selector d'arxius del teu sistema operatiu. Tria qualsevol imatge (com un plànol o mapa) i aquesta es carregarà automàticament com a fons.

### 2. Fer una mesura
* **Punt A:** Fes un clic a qualsevol lloc de la imatge per fixar el primer marcador vermell.
* **Punt B:** Fes un segon clic a la destinació. Apareixerà una línia connectant els dos punts automàticament.
* El panell superior t'indicarà l'estat de la mesura en tot moment.

### 3. Netejar la pantalla
Si vols començar de nou, tens tres dreceres disponibles:
- Fes clic al **botó flotant (🔄)** a la part inferior dreta.
- Fes **clic dret** (a l'ordinador) sobre la imatge.
- Fes una **pulsació llarga** (al mòbil) sobre la imatge.

---

## 🛠️ Arquitectura i Tecnologies

Aquest projecte s'ha desenvolupat seguint estrictament el patró **MVVM (Model-View-ViewModel)** i els principis de Clean Architecture:

* **Separació de responsabilitats:** La interfície d'usuari (`MesuradorWidget`) és un component purament `Stateless`, completament desacoblat de la lògica de negoci.
* **Comunicació per Callbacks:** El flux de dades és unidireccional. La UI envia esdeveniments al ViewModel a través de funcions callback (`onPuntoMarcado`), i rep l'estat immutable a través del seu constructor.
* **Gestió d'Estat:** `ChangeNotifierProvider` injecta les dependències necessàries evitant l'acoblament i optimitzant les reconstruccions de l'arbre de widgets.

---

## 🚀 Instal·lació i Execució

Si vols clonar i provar aquest projecte al teu entorn local:

1. Clona el repositori:
   ```bash
   git clone [https://github.com/Arnau-C/widget_mesura_arnau_calvo.git](https://github.com/Arnau-C/widget_mesura_arnau_calvo.git)