# Documentația atestatului
Acest proiect a fost făcut folosind 2 unelte principale
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
Jocul este împărțit în mai multe scene, in ordinea asta:
```text
Scenes/
├─ main_menu.tscn    - meniul principal al jocului
├─ settings.tscn     - meniul de setări
├─ credits.tscn      - creditele jocului
├─ intro_lore.tscn   - scenă narativă de introducere
├─ game.tscn         - scena principală de gameplay
├─ pause_menu.tscn   - meniul de pauză
├─ death.tscn        - ecranul de pierdere
└─ outro_lore.tscn   - scenă narativă de final
```
Diagrama jocului:
``` text
main_menu.tscn
 ├─ Play → intro_lore.tscn → game.tscn
 │                          ├─ pause_menu.tscn → game.tscn / ieșire 
 │                          ├─ death.tscn → main_menu.tscn
 │                          └─ outro_lore.tscn → main_menu.tscn
 ├─ Settings → settings.tscn → main_menu.tscn
 ├─ Credits → credits.tscn → main_menu.tscn
 └─ Quit → ieșire
 ``` 
## Rularea proiectului din sursă
Pentru a insala jocul, prima dată trebuie instalat folderul cu proiectul, folosind [git](https://git-scm.com/install/):
```sh
git clone https://github.com/VeryVeryCoolName/atestathorror.git
```
sau instalând manual zip-ul:

<img src="https://github.com/VeryVeryCoolName/atestathorror/blob/main/Imagini_Documentatie/repository.png?raw=true">

Apoi, în godot, selectați opțiunea de "import existing project":

<img src="https://github.com/VeryVeryCoolName/atestathorror/blob/main/Imagini_Documentatie/import.png?raw=true">

Jocul este compatibil doar cu rezolutia de 1920x1080, dar poate fi vizualizat cu orice rezolutie.

## Motivul alegerii temei
De mult timp ne-am dorit să creeăm un joc top-down rogue-like, fiind pasionați de acest tip de jocuri. Printre inspirațiile noastre principale se numără The Legend of Zelda (Nintendo, 1986) și The Binding of Isaac (Edmund McMillen, 2011). De asemenea, suntem fani ai unor jocuri moderne precum Cruelty Squad (Ville Kallio, 2021), creeat în engine-ul Godot, ceea ce ne-a motivat să alegem acest program pentru jocul nostru. Tema fabulei celor trei purceluși ne-a interesat, deoarece, de-a lungul timpului, ne-au captivat adaptările noi ale poveștilor clasice, precum seria de benzi desenate Fables (DC Comics, 2002). Ne-am dorit ca jocul să aibă o atmosferă familiară, însă totodată nouă, misterioasă, invitând jucătorul să se cufunde în povestea jocului. De asemenea, această temă ne-a oferit posibilitatea de a introduce elemente comice în joc, folosindu-ne de contrastul dintre seriozitatea poveștii acestuia și statutul sursei de inspirație ca poveste pentru copii.

## Programele utilizate
Godot
Photoshop
de completat

## Limbajul gdscript
de completat

## Scripturile (ordonate alfabetic)

| Script | Descriere |
| ------ | ------ |
| audiomanager | Acest script gestionează sunetele și muzica din joc, având rolul de manager audio global. El controlează atât muzica de fundal, cât și efectele sonore. La inițializare, sunt încărcate toate fișierele audio necesare jocului, grupate în liste separate pentru muzică și efecte sonore. Acest lucru permite accesarea rapidă a sunetelor în funcție de contextul jocului. Muzica de fundal poate fi pornită, oprită sau verificată dacă este activă. În anumite situații, muzica este întreruptă temporar pentru a reda un efect sonor important, după care este reluată din același punct. De asemenea, scriptul permite redarea efectelor sonore fără a întrerupe muzica, ajustând temporar volumul acestora pentru a evidenția anumite momente din joc. |
| boss_phase1 |  |
| boss_phase2 |  |
| cameracontroller | Acest script merge doar la rezolutia de 1920x1080, merită o categorie separată. Acest script controlează camera jocului și împarte nivelul în zone fixe. Camera rămâne centrată pe o zonă și se mută automat către următoarea zonă atunci când jucătorul o traversează. La începutul jocului, camera se poziționează în zona în care se află jucătorul și devine camera activă. Pe parcursul jocului, poziția jucătorului este verificată constant, iar la schimbarea zonei este declanșată o tranziție lină a camerei. În timpul tranziției, mișcarea jucătorului este temporar blocată pentru a asigura o experiență vizuală corectă. După finalizarea tranziției, jocul continuă normal. Am fost inspirat de către jocurile "old school" (în special The Legend of Zelda pentru NES), care foloseau dimensiuni fixe. Din păcate, nu am reușit să găsesc o formulă ce permite această tranziție să fie compatibilă cu fiecare rezoluție posibilă|
| credits | Este conectat la un singur buton ce duce jucătorul în meniu |
| deathscreen | Este conectat la un singur buton ce duce jucătorul în meniu|
| failsafe | Poate fi integrat in boss_phase_1, ascunde bara de hp a lupului pentru un timp predeterminat|
| healthbar |  |
| Intro_Cutscene_Text_Fade |  |
| main_menu | Inițializează audiomanagerul și este conectat la 4 butoane; scena se schimbă în funcție de ce buton este apăsat |
| outro |  |
| pause_menu |Atunci când jucătorul apasă pe escape, apare un meniu de pauză peste joc și blochează tot din scenă. Acest meniu este mereu încărcat în joc și apare înainte de pauză, iar apoi dispare când cheia este apasată iar sau jucătorul apasă pe butonul de unpause|
| player| |
| playeranimations | |
| settings | Momentan are un slider ce editează volumul jocului (în decibeli) și ține minte valoarea, are și o funție pentru a trimite jucătorul înapoi în meniul principal|

## Bibliografie
Bibliografia este prezentată în limba engleză și poate fi consultată în scena credits.tscn, la fel ca restul conținutului textual al jocului. Sunetele și pozele care nu sunt menționate în bibliografie sunt complet originale (de exemplu efectele sonore de "pause" și "unpause")
