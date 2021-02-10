# Digital-electronics-1
VUT_FEKT_DE1

*Toto je kurziva*

_Toto je taky kurziva_

**Text je tlusty**

__Tento text je take tlusty__

## Nadpis 2

* Predmet 1
  * Matika
  * Elektro

1. Zelenina
1. Ovoce
  1. Hruska
  1. Sveska

### Nadpis 3


[Klik](https://translate.google.cz/?hl=cs)

Firt column | Second column
------------ | -------------
cell 1 | cell 2
DoG | CaT


```vhdl
-- definice entity...
entity my_and is
  port (IN1, IN2 : in std_logic; OUT1: out std_logic);
end entity;

-- ...a architektury
architecture example of my_and is
begin
  OUT1 <= IN1 and IN2;
end example;
```
