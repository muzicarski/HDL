/*
  Melody

  Plays a melody

  circuit:
  - 8 ohm speaker on digital pin 8

  created 21 Jan 2010
  modified 30 Aug 2011
  by Tom Igoe

  This example code is in the public domain.

  http://www.arduino.cc/en/Tutorial/Tone
*/

#include "pitches.h"

// notes in the melody:

int imelody[] = {
  NOTE_D3, NOTE_C3, NOTE_B2, NOTE_C3,
  NOTE_D3, NOTE_D3, NOTE_D3, NOTE_D3,
  NOTE_E3, NOTE_D3, NOTE_C3, NOTE_A2, NOTE_A2
};

int inoteDurations[] = {
  8, 8, 8, 8, 
  8, 8, 8, 8,
  8, 8, 4, 4, 4,
};

int kmelody[] = {
NOTE_E3, NOTE_D3, NOTE_C3, NOTE_D3, NOTE_E3, NOTE_E3, //MENE VOLJELA //seq1
NOTE_E3, NOTE_D3, NOTE_C3, NOTE_A2, NOTE_A2, //KAO TEBE JA //seq2
NOTE_E3, NOTE_D3, NOTE_C3, NOTE_D3, NOTE_E3, NOTE_E3, //DA L SI IKADA //seq1

NOTE_D3, NOTE_C3, NOTE_B2, NOTE_G2, NOTE_G2, //MENE VOLJELA //seq3
NOTE_D3, NOTE_C3, NOTE_B2, NOTE_C3, NOTE_D3, NOTE_D3, //KAO TEBE JA //seq4
NOTE_D3, NOTE_C3, NOTE_B2, NOTE_G2, NOTE_G2, //DA L SI IKADA //seq3

NOTE_D3, NOTE_C3, NOTE_B2, NOTE_C3, NOTE_D3, NOTE_D3, //MENE VOLJELA //seq4
NOTE_E3, NOTE_D3, NOTE_C3, NOTE_A2, NOTE_A2, //KAO TEBE JA //seq2
};
// note durations: 4 = quarter note, 8 = eighth note, etc.:

int knoteDurations[] = {
 8, 8, 8, 8, 4, 4, //MENE VOLJELA
 8, 8, 4, 4, 4,    //KAO TEBE JA
 8, 8, 8, 8, 4, 4, //DA L SI IKADA
 8, 8, 4, 4, 4,    //MENE VOLJELA
 8, 8, 8, 8, 4, 4, //KAO TEBE JA
 8, 8, 4, 4, 4,    //DA L SI IKADA
 8, 8, 8, 8, 4, 4, //MENE VOLJELA
 8, 8, 4, 4, 4,    //KAO TEBE JA
};

void setup() {
for (int thisNote = 0; thisNote < 14; thisNote++) {

    // to calculate the note duration, take one second divided by the note type.
    //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
    int noteDuration = 1880 / inoteDurations[thisNote] ;
    tone(8, imelody[thisNote], noteDuration);

    // to distinguish the notes, set a minimum time between them.
    // the note's duration + 30% seems to work well:
    int pauseBetweenNotes = noteDuration*1.05 ;
    delay(pauseBetweenNotes);
    // stop the tone playing:
    noTone(8);
}
}
void loop() {
  // no need to repeat the melody.
  for (int thisNote = 0; thisNote < 44; thisNote++) {

    // to calculate the note duration, take one second divided by the note type.
    //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
    int noteDuration = 1880 / knoteDurations[thisNote] ;
    tone(8, kmelody[thisNote], noteDuration);

    // to distinguish the notes, set a minimum time between them.
    // the note's duration + 30% seems to work well:
    int pauseBetweenNotes = noteDuration*1.05 ;
    delay(pauseBetweenNotes);
    // stop the tone playing:
    noTone(8);
  }
}
