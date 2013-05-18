# Vocodeur


## Traitement audio

### G�n�ralit�s
* _Echantillon audio (audio sample)_ : sortie unique d'un convertisseur analogique-num�rique (typiquement un petit entier de 8 ou 16 bits)
* _Donn�e audio (audio data)_ : s�rie d'�chantillons audio caract�ris�s par
	* _Fr�quence d'�chantillonage (sampling rate)_
	* _Nombre de bits par �chantillon (number of byte per sample)_
	* _Nombre de canaux (number of channels)_
* _Format audio (audio format)_ : repr�sentation de donn�es audio dont les deux plus populaires sont
	* _Codage lin�aire (linear encoding)_
	* _Codage Loi Mu (mu-law encoding)_


### R�cup�ration d'�chantillons audio

#### OCaml

Pour r�cup�rer des valeurs de fichiers sons, le format .wav est int�ressant.
Il est uniquement consititu� d'une en-tete, suivi des diff�rentes valeurs prises au cours du temps (�ventuellement plusieurs canaux ).
C'est donc relativement simple � r�cup�rer.

(cf. [Formats WAVE](http://www-mmsp.ece.mcgill.ca/Documents/AudioFormats/WAVE/WAVE.html))

#### Octave

En utilisant Octave on peut r�cup�rer les �chantillons en utilisant la commande : `<name> = wavread('<path>/<name>.wav')`

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
