# Documentația
## Atestatului horror
Acest proiect a fost făcut folosing 2 unelte principale
- [Godot Engine (pentru a programa jocul)](https://godotengine.org/)
- [Github (pentru a organiza jocul)](https://github.com/)

## Structura proiectului

```text
atestathorror/
├─ Assets/
│  ├─ Fonts/        - fonturi utilizate în joc
│  ├─ Meniu/        - resurse grafice pentru meniul jocului
│  ├─ Sprites/      - sprite-uri și texturi (ex: personaje, boss, HP bar)
│  └─ Tilemaps/     - tilemap-uri utilizate pentru construirea nivelurilor
├─ Music/
│  └─ sfx/          - muzică și efecte sonore
├─ Prefabs/         - elemente prefabricate (ex: atacurile inamicului)
├─ Scenes/          - scenele jocului (meniuri, niveluri, personaje)
├─ Scripts/         - scripturi GDScript care controlează logica jocului
├─ Shaders/         - shadere utilizate (ex: pentru meniul de pauză)
└─ project.godot    - fișierul principal de configurare al proiectului

```

## Rularea proiectului din sursă
Pentru a insala jocul, prima dată trebuie instalat folderul cu proiectul, folosind git:
```sh
git clone https://github.com/VeryVeryCoolName/atestathorror.git
```
sau instalând manual zip-ul manual

<img src="https://github.com/VeryVeryCoolName/atestathorror/blob/main/Imagini_Documentatie/repository.png?raw=true">

Apoi, în godot, selectați opțiunea de "import existing project":

<img src="https://github.com/VeryVeryCoolName/atestathorror/blob/main/Imagini_Documentatie/import.png?raw=true">
