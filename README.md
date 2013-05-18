# Vocodeur


## Traitement audio

### Généralités
* _Echantillon audio (audio sample)_ : sortie unique d'un convertisseur analogique-numérique (typiquement un petit entier de 8 ou 16 bits)
* _Donnée audio (audio data)_ : série d'échantillons audio caractérisés par
	* _Fréquence d'échantillonage (sampling rate)_
	* _Nombre de bits par échantillon (number of byte per sample)_
	* _Nombre de canaux (number of channels)_
* _Format audio (audio format)_ : représentation de données audio dont les deux plus populaires sont
	* _Codage linéaire (linear encoding)_
	* _Codage Loi Mu (mu-law encoding)_


### Récupération d'échantillons audio

#### OCaml

Pour récupérer des valeurs de fichiers sons, le format .wav est intéressant.
Il est uniquement consititué d'une en-tete, suivi des différentes valeurs prises au cours du temps (éventuellement plusieurs canaux ).
C'est donc relativement simple à récupérer.

(cf. [Formats WAVE](http://www-mmsp.ece.mcgill.ca/Documents/AudioFormats/WAVE/WAVE.html))

#### Octave

En utilisant Octave on peut récupérer les échantillons en utilisant la commande : `<name> = wavread('<path>/<name>.wav')`

(cf. [Traitement audio avec Octave](http://www.gnu.org/software/octave/doc/interpreter/Audio-Processing.html))


## Liens
* [Wikipedia - Format de fichier audio](http://fr.wikipedia.org/wiki/Format_de_fichier_audio)
* [Formats audio](http://www-mmsp.ece.mcgill.ca/Documents/AudioFormats)
* [OCaml](http://ocaml.org)
* [Octave](http://www.gnu.org/software/octave)
* [Traitement audio avec Octave](http://www.gnu.org/software/octave/doc/interpreter/Audio-Processing.html)


## Auteurs
* [Marc Heinrich](https://github.com/mheinric)
* [Baptiste Lefebvre](https://github.com/BaptisteLefebvre)
