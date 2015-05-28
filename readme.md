# Personnummer #

Den här uppgiften går ut på att skriva funktioner för att kontrollera och skapa giltiga personnummer.

## Bedömningsmatris ##

## Planering ##

| Förmågor                         | E 																																   | C | A |
|----------------------------------|-----------------------------------------------------------------------------------------------------------------------------------|---|---|
| Aktivitetsdiagram och pseudokod  | Du använder pseudokod och/eller aktivitetsdiagram för att planera dina uppgifter utifrån exempel, eller i samråd med utbildaren.  | Som för E, men utan exempel eller handledning |   |
| Anpassning					   | Du anpassar med viss säkerhet planeringen till uppgiften 																		   |   | Som för E, men med säkerhet
| Utformning                       | Du väljer med viss säkerhet lämpliga kontrollstrukturer, metoder, variabler, datastrukturer och algoritmer | | Som för E, men du väljer med säkerhet, och motiverar utförligt dina val.|
| Utvärdering | Med viss säkerhet utvärderar du, med enkla omdömen, programmets prestanda, använder datalogiska begrepp, och bedömer din egen förmåga | som för E, men med nyanserade omdömen | Som för C, men med säkerhet, och med förbättringsförslag

## Syntax och Teori ##
| Förmågor                                       | E 																			| C | A |
|------------------------------------------------|------------------------------------------------------------------------------|---|---|
| Datatyper					                     | Du kan redogöra för och använda de vanligaste datatyperna                    |   |   |
| Grundläggande syntax		                     | Du kan redogöra för och använda programmeringsspråkets grundläggande syntax  |   |   |
| Villkor och IF-satser		                     | Du kan redogöra för och använda villkor och IF-satser                        |   |   |
| Loopar & iteration                             | Du kan redogöra för och använda loopar och iterera över listor               |   |   |

## Kodning och kodningsstil ##

| Förmågor                                      | E                                                                         | C                                               | A                                              |
|-----------------------------------------------|---------------------------------------------------------------------------|-------------------------------------------------|------------------------------------------------|
| Komplexitet									| Du kan skriva enkla program                                               | Du kan skriva lite mer avancerade program       | Du kan skriva komplexa program
| Sekventiell- & funktionsbaserad programmering | Du använder dig av sekventiell programmering och fördefinerade funktioner | *Du skapar och använder enkla funktioner*         | *Du skapar mer komplexa funktioner*              |
| Struktur		 				                | Du skriver kod som är delvis strukturerad, har en konsekvent kodningsstil och tydlig namngivning | Som för E, men du skriver kod som är helt strukturerad |   			   |
| Felsökning                                    | Du felsöker på egen hand enkla syntaxfel | Som för E, men systematiskt, och dessutom även körtidsfel och programmeringslogiska fel | Som för C, men med effektivitet   	   |
| Undantagshantering                            |     																		| Du validerar användardata						  | Som för C, men du skriver även kod som använder undantagshantering |
| Dokumentering 								| Du skriver kod som är delvis kommenterad									|  												  | Du skriver kod som är utförligt kommenterad    |

## Datastrukturer ##

| Förmågor        | E 														   | C 																     | A 									 |
|-----------------|------------------------------------------------------------|---------------------------------------------------------------------|---------------------------------------|
| Listor          | Du kan redogöra för och använda dig av listor (Array)      |   																     |   									 |
| Hashtabeller    | Du kan redogöra för vad hashtabeller (Hash) är             | Du kan använda dig av hashtabeller 							     |   									 |

## Uppgiftsbeskrivning ##


Du ska skriva två funktioner:


* `valid_pnr?` tar ett personnummer (som en sträng) som argument, och returnerar `true` eller `false` beroende på om personnumret är giltigt eller ej.
* `generate_pnr` tar födelseår, kön och ort som argument och returnerar ett giltigt personnummer för födelseåret och orten.


### Personnumrets uppbyggnad ###

Personnumret är uppbyggt av 10 siffror indelade i två grupper om 6 respektive 4 siffror.
Grupperna är åtskilda med ett bindestreck (-), men om personen är över 100 år ett plustecken (+).

Exempel:

    Födelsedatum Kontrollsiffra
        ||||||    |
        811218-9876
               |||
               |||
               ||Kön (udda för män, jämn för kvinnor)
               Födelselän


#### Kontrollsiffra ####

För att beräkna kontrollsiffran multiplicerar man de **9 första** siffrorna (dvs **INTE** kontrollsiffran) med omväxlande 2 och 1.
Om produkten blir 10 eller större adderar man de två ingående siffrorna (ex: 8 * 2 => 16 => 1 + 6 => 7)

Man tar sen summan av alla multiplicerade tal. Om man adderar kontrollsiffran till denna summa ska man få ett tal jämnt delbart med 10.

     Exempel för personnumret 811218-9876:

        8  1 1 2 1 8  9 8  7
     *  2  1 2 1 2 1  2 1  2
     -------------------------
        ^  ^ ^ ^ ^ ^  ^ ^  ^
       16  1 2 2 2 8 18 8 14

    1 + 6 + 1 + 2 + 2 + 2 + 8 + 1 + 8 + 8 + 1 + 4 => 44

    44 + 6 => 50

    50 är jämt delbart med 10, alltså är personnumret giltigt.

#### Födelselänskoder ####

(Personnummer har inte använt födelselän sen 1990, men ert `generate_pnr` ska använda sig av dem ändå).

    Stockholm: 00–13        Kristianstad: 35–38        Kopparberg: 71–73
    Uppsala: 14–15          Malmöhus: 39–45            Gävleborg: 75–77
    Södermanland: 16–18     Halland: 46–47             Västernorrland: 78–81
    Östergötland: 19–23     Västra Götaland: 48–54     Jämtland: 82–84
    Jönköping: 24–26        Älvsborg: 55–58            Västerbotten:  85–88
    Kronoberg: 27–28        Skaraborg: 59–61           Norrbotten: 89–92
    Kalmar: 29–31           Värmland: 62–64
    Gotland: 32             Örebro: 66–68
    Blekinge: 33–34         Västmanland: 69–70

### Exempel ###

#### Ruby ####

'''ruby

    valid_pnr?(pnr: "811218-9876"   #=> true
    valid_pnr?(pnr: "781206-4611"   #=> true
    valid_pnr?(pnr: "811218-9866"   #=> false
    valid_pnr?(pnr: "781206-4612"   #=> false

    generate_pnr(birth_year: 1978, birth_county: 'Halland', sex: 'male') #=> "781206-4611"

'''

## Genomförande ##

### Versionshantering ###

Ladda ner en zip av repot. Skapa ett lokalt repository (I GitHub-klienten: File -> Add Local Repository). Synka till GitHub. Gör Repot privat. Bjud in mig och Bosse.
Kom ihåg att checka in dina ändringar och synka med GitHub.

### Flödesschema ###

Innan du börjar koda ska du skapa ett flödesschema för programmet.
När du känner att du har ett fungerande flödesschema, be läraren att kolla på det.

### Kodning ###

Programmet skall utvecklas med hjälp av testerna.

##### Ruby #####

Kör `bundle install` för att installera alla dependencies (och `rbenv rehash` om rspec inte redan var installerat)

Skapa funktionerna i `lib/pnr.rb`

Testerna finns i `spec/valid_pnr_test.rb` & `spec/generate_pnr_test.rb`.

Kör `ruby spec/funktionens_namn_spec` för att köra testerna för den specifika funktionen.

##### Python #####

## Tips och länkar ##

* Om du inte kan beskriva lösningen i ord kommer det vara så gott som omöjligt att skapa ett flödesschema
* Fundera på vilka variabler som behövs
* Testa flödesschemat med hjälp av penna och papper