# Documentația atestatului

# Motivul alegerii temei
De mult timp ne-am dorit să creeăm un joc top-down rogue-like, fiind pasionați de acest tip de jocuri. Printre inspirațiile noastre principale se numără The Legend of Zelda (Nintendo, 1986) și The Binding of Isaac (Edmund McMillen, 2011). De asemenea, suntem fani ai unor jocuri moderne precum Cruelty Squad (Ville Kallio, 2021), creeat în engine-ul Godot, ceea ce ne-a motivat să alegem acest program pentru jocul nostru. Tema fabulei celor trei purceluși ne-a interesat, deoarece, de-a lungul timpului, ne-au captivat adaptările noi ale poveștilor clasice, precum seria de benzi desenate Fables (DC Comics, 2002). Ne-am dorit ca jocul să aibă o atmosferă familiară, însă totodată nouă, misterioasă, invitând jucătorul să se cufunde în povestea jocului. De asemenea, această temă ne-a oferit posibilitatea de a introduce elemente comice în joc, folosindu-ne de contrastul dintre seriozitatea poveștii acestuia și statutul sursei de inspirație ca poveste pentru copii.

# Programele utilizate
## Godot
Godot este un game engine open-source, prin care se pot crea jocuri video 2D și 3D. Programul se aseamănă cu alte game engine-uri similare, precum Unity, însă se diferențiază de acestea, fiind gândit cu scopul de a face procesul de dezvoltare a jocurilor mai simplu și accesibil, fără a pierde din funcționalitate. Jocurile pot fi programate în limbajele C++ și C#, dar noi am ales să utilizăm limbajul propriu al engine-ului, GDScript. Godot este disponibil gratuit pe [site-ul oficial](https://godotengine.org/), dar poate fi obținut și din magazinul online Steam sau din [repository-ul github](https://github.com/godotengine/godot).

Un proiect Godot este împărțit în mai multe scene, iar engine-ul facilitează utilizatorilor o interfață intuitivă prin care aceștia pot avea acces la elementele constituente ale acestora, nodurile, care sunt grupate în ierarhii.

Exemplu (structura unei scene):

<img src="https://github.com/VeryVeryCoolName/atestathorror/blob/main/Imagini_Documentatie/Godot_Scene.png?raw=true">

Nodurilor le pot fi adăugate alte noduri fii de diverse tipuri, conferindu-le anumite proprietăți în funcție de nevoile utilizatorului. Spre exemplu, un nod te tip Sprite2D ofera posibilitatea de a adăuga o textură vizibilă nodului său părinte:

<img src="https://github.com/VeryVeryCoolName/atestathorror/blob/main/Imagini_Documentatie/Godot_Sprites.png?raw=true">

Îmbinând mai multe scene și folosind scripturi scrise în unul din limbajele de programare suportate, utilizatorii pot să își creeze propriile jocuri. Godot oferă destulă libertate în ceea ce privește funcționalitatea jocurilor, astfel încât posibilitățile sunt nelimitate.

## Limbajul GDScript
GDScript este un limbaj de programare asemănător cu Python, gândit special pentru Godot. La fel ca Python, acesta folosește indentarea pentru organizarea codului în loc de paranteze. Are o mulțime de librării cu funcții specifice pentru programarea jocurilor. Există, de exemplu, funcții ce rulează odată cu încărcarea scenei, cu fiecare cadru încărcat, sau la un interval predeterminat. De asemenea, inițializarea variabilelor se face în mod automat, interpretorul recunoscând tipul variabilei în momentul atribuirii unei valori acesteia. Spre deosebire de Python, clasele reprezintă o parte mare a limbajului GDScript, fiind astfel integrată structura ierarhică de scene și noduri până la nivel de cod.

Exemplu de secvență de cod GDScript:

<img src="https://github.com/VeryVeryCoolName/atestathorror/blob/main/Imagini_Documentatie/gdscript-code.png?raw=true">

## Photoshop
Photoshop este un program de editare a imaginilor și face parte din suita Adobe. L-am utilizat în cadrul acestui proiect pentru a realiza majoritatea sprite-urilor și animațiilor prezente în joc. Pentru a crea un sprite, am început prin a stabili rezoluția necesară. Pentru acest joc am ales să folosim sprite-uri de 16x16 pixeli, dar și unele de rezoluție mai mare, până la 32x32 pixeli.

<img src="https://github.com/VeryVeryCoolName/atestathorror/blob/main/Imagini_Documentatie/Photoshop_Project.png?raw=true">

După ce am creat proiectul cu rezoluția dorită, am folosit uneltele de selecție și de pensulă pentru a desena sprite-urile, salvându-le pe fiecare ca un fișier .png separat.

<img src="https://github.com/VeryVeryCoolName/atestathorror/blob/main/Imagini_Documentatie/Photoshop_Tools.png?raw=true">

<img src="https://github.com/VeryVeryCoolName/atestathorror/blob/main/Imagini_Documentatie/Sprites_Example.png?raw=true">

Astfel, le-am putut importa în Godot și integra în joc.

## Github desktop
[Github desktop](https://desktop.github.com/download/) este o versiune mai "user-friendly" a programului git. L-am folosit pentru controlul versiunilor, adică pentru urmărirea modificărilor aduse codului sursă în timp real. Cu ajutorul acestui program, am putut lucra la aspecte diferite ale proiectului fără să trebuiască să ne trimitem modificările manual. Aplicația permite salvarea modificărilor importante (commit-uri), revenirea la versiuni anterioare și sincronizarea codului cu un depozit online (repository) pe platforma Github.  

<img src="https://github.com/VeryVeryCoolName/atestathorror/blob/main/Imagini_Documentatie/Photoshop_Tools.png?raw=true">

Cel mai mare avantaj al utilizării acestui program este posibilitatea de a lucra organizat și sigur, deoarece toate modificările sunt înregistrate atât local, cât și online.

# Structura proiectului

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
Pentru a importa jocul în Godot, prima dată trebuie instalat folderul cu proiectul, folosind [git](https://git-scm.com/install/):
```sh
git clone https://github.com/VeryVeryCoolName/atestathorror.git
```
sau instalând manual zip-ul:

<img src="https://github.com/VeryVeryCoolName/atestathorror/blob/main/Imagini_Documentatie/repository.png?raw=true">

Apoi, în Godot, selectați opțiunea de "import existing project":

<img src="https://github.com/VeryVeryCoolName/atestathorror/blob/main/Imagini_Documentatie/import.png?raw=true">

Jocul este compatibil doar cu rezolutia de 1920x1080, dar poate fi vizualizat cu orice rezolutie.

# Scripturile (ordonate alfabetic)

| Script | Descriere |
| ------ | ------ |
| [audio_manager](https://github.com/VeryVeryCoolName/atestathorror/blob/main/Scripts/audio_manager.gd) | Acest script gestionează sunetele și muzica din joc, având rolul de manager audio global. El controlează atât muzica de fundal, cât și efectele sonore. La inițializare, sunt încărcate toate fișierele audio necesare jocului, grupate în liste separate pentru muzică și efecte sonore. Acest lucru permite accesarea rapidă a sunetelor în funcție de contextul jocului. Muzica de fundal poate fi pornită, oprită sau verificată dacă este activă. În anumite situații, muzica este întreruptă temporar pentru a reda un efect sonor important, după care este reluată din același punct. De asemenea, scriptul permite redarea efectelor sonore fără a întrerupe muzica, ajustând temporar volumul acestora pentru a evidenția anumite momente din joc. |
| [boss_phase1](https://github.com/VeryVeryCoolName/atestathorror/blob/main/Scripts/boss_phase1.gd) | Gestionează comportamentul boss-ului în prima fază a luptei. Acesta se conectează la scriptul [player.gd](https://github.com/VeryVeryCoolName/atestathorror/blob/main/Scripts/player.gd), preluând poziția jucătorului. Apoi, folosește un state machine pentru a decide comportamentul boss-ului în apropierea jucătorului. Boss-ul este inactiv până când jucătorul este suficient de aproape de acesta, după care se va mișca în direcția jucătorului, atacându-l când aceștia se întâlnesc. De asemenea, acest script gestionează o parte din interacțiunile dintre boss și jucător, actualizând viața bossului în timp real și transmițând atacurile acestuia mai departe. |
| [boss_phase2](https://github.com/VeryVeryCoolName/atestathorror/blob/main/Scripts/boss_phase2.gd) | În mare parte funcționează la fel ca scriptul [boss_phase1](https://github.com/VeryVeryCoolName/atestathorror/blob/main/Scripts/boss_phase1.gd), însă modul de funcționare a atacurilor este schimbat pentru a se adapta la schimbarile dintre faza întâi și faza a doua a luptei. |
| [cameracontroller](https://github.com/VeryVeryCoolName/atestathorror/blob/main/Scripts/cameracontroller.gd) | Acest script controlează camera jocului și împarte nivelul în zone fixe. Camera rămâne centrată pe o zonă și se mută automat către următoarea zonă atunci când jucătorul o traversează. La începutul jocului, camera se poziționează în zona în care se află jucătorul și devine camera activă. Pe parcursul jocului, poziția jucătorului este verificată constant, iar la schimbarea zonei este declanșată o tranziție lină a camerei. În timpul tranziției, mișcarea jucătorului este temporar blocată pentru a asigura o experiență vizuală corectă. După finalizarea tranziției, jocul continuă normal. Am fost inspirat de către jocurile "old school" (în special The Legend of Zelda pentru NES), care foloseau dimensiuni fixe. Din păcate, nu am reușit să găsesc o formulă ce permite această tranziție să fie compatibilă cu fiecare rezoluție posibilă|
| [credits](https://github.com/VeryVeryCoolName/atestathorror/blob/main/Scripts/credits.gd) | Este conectat la un singur buton ce duce jucătorul în meniu |
| [deathscreen](https://github.com/VeryVeryCoolName/atestathorror/blob/main/Scripts/deathscreen.gd) | Este conectat la un singur buton ce duce jucătorul în meniu|
| [failsafe](https://github.com/VeryVeryCoolName/atestathorror/blob/main/Scripts/failsafe.gd) | Poate fi integrat in boss_phase_1, ascunde bara de hp a lupului pentru un timp predeterminat|
| [healthbar](https://github.com/VeryVeryCoolName/atestathorror/blob/main/Scripts/healthbar.gd) | Actualizează în timp real textura barei de viață a jucătorului. |
| [Intro_Cutscene_Text_Fade](https://github.com/VeryVeryCoolName/atestathorror/blob/main/Scripts/Intro_Cutscene_Text_Fade.gd) | Face textul din intro să apară în mod dinamic. |
| [main_menu](https://github.com/VeryVeryCoolName/atestathorror/blob/main/Scripts/main_menu.gd) | Inițializează audiomanagerul și este conectat la 4 butoane; scena se schimbă în funcție de ce buton este apăsat |
| [outro](https://github.com/VeryVeryCoolName/atestathorror/blob/main/Scripts/outro.gd) | Se aseamănă cu [Intro_Cutscene_Text_Fade](https://github.com/VeryVeryCoolName/atestathorror/blob/main/Scripts/Intro_Cutscene_Text_Fade.gd), dar funcționează în timpul outro-ului. |
| [pause_menu](https://github.com/VeryVeryCoolName/atestathorror/blob/main/Scripts/pause_menu.gd) |Atunci când jucătorul apasă pe escape, apare un meniu de pauză peste joc și blochează tot din scenă. Acest meniu este mereu încărcat în joc și apare înainte de pauză, iar apoi dispare când cheia este apasată iar sau jucătorul apasă pe butonul de unpause|
| [player](https://github.com/VeryVeryCoolName/atestathorror/blob/main/Scripts/player.gd) | Gestionează acțiunile jucătorului, de la miscări până la atacuri. Mișcările jucatorului sunt normalizate, pentru a preveni un comportament nedorit al acestui script în timpul mișcărilor pe diagonală. Jucătorul poate ataca doar în direcția în care s-a mișcat ultima dată, moment în care scriptul creează o cutie ce reprezintă raza de acțiune a atacului și verifică dacă acesta s-a intersectat cu inamicul. |
| [playeranimations](https://github.com/VeryVeryCoolName/atestathorror/blob/main/Scripts/playeranimations.gd) | Gestioneaza animațiile personajului jucătorului în funcție de direcția de mișcare. |
| [settings](https://github.com/VeryVeryCoolName/atestathorror/blob/main/Scripts/settings.gd) | Momentan are un slider ce editează volumul jocului (în decibeli) și ține minte valoarea, are și o funție pentru a trimite jucătorul înapoi în meniul principal|

## Bibliografie
Bibliografia este prezentată în limba engleză și poate fi consultată în scena credits.tscn, la fel ca restul conținutului textual al jocului. Sunetele și pozele care nu sunt menționate în bibliografie sunt complet originale (de exemplu efectele sonore de "pause" și "unpause")
