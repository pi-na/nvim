# 1. Métodos abstractos en Enums (Java)
Los métodos abstractos en un enum permiten definir comportamientos distintos para cada una de las instancias de enum. Al sobreescribir un método en un valor de enum, se puede personalizar su comportamiento, lo que permite utilizar de forma más efectiva los principios de la Programación Orientada a Objetos (POO). No se ajusta al paradigma orientado a objetos tener una lógica condicional dentro de una clase enum para determinar el comportamiento basándose en sus instancias.

La solución propuesta mantiene la implementación del método canVisit para todas las instancias excepto PRO, ya que PRO tiene un comportamiento específico diferente a BEGINNER y ADVANCED.

# 2. Orden de Enums (Java)
El comportamiento predeterminado del método compareTo() en un enum es comparar los enums basándose en el orden de su declaración. En términos más técnicos, compara los ordinales de los enums. Esto significa que la primera constante declarada en el enum es 'menor' que la segunda, y así sucesivamente.

# 3. Implementación por defecto en interfaces (Java)
Si se puede declarar una implementación por defecto en una interfaz, es preferible hacerlo así. Esta implementación estará disponible para todas las futuras implementaciones de la interfaz, lo que es un diseño más eficiente y flexible.

# 4. Exceptions y RuntimeException (Java)
Las excepciones verificadas o Checked Exceptions deben ser manejadas ya sea con un bloque try-catch o se deben declarar en la firma del método con throws. Si un método lanza una excepción y no se maneja con try-catch, esta debe ser una excepción no verificada o Unchecked Exception, también conocida como RuntimeException.

# 5. Collections y Arrays (Ruby)
Para comprobar si un elemento ya está presente en una colección, se puede usar include? con un Array o Set. Sin embargo, si se requiere asegurar que no hay elementos duplicados, usar un Set es más eficiente que un Array.

# 6. Uso de reduce (Ruby)
El método reduce en Ruby, también conocido como inject, combina todos los elementos de una colección mediante una operación binaria. Si no se pasa un argumento inicial a reduce, el primer elemento de la colección se utiliza como el valor inicial del acumulador y el proceso comienza desde el segundo elemento de la colección. Por lo tanto, si el acumulador necesita ser un número (como cuando se suman precios), pero la colección contiene objetos no numéricos (como libros), se necesita proporcionar un valor inicial para evitar errores. En este caso, se proporciona el valor inicial 0 para que el proceso de reducción pueda comenzar correctamente.

---
___A partir de aca, los debates:___

# (P2 C1 2021) Metodos abstractos en el enum
Hola profe, ¿cómo estás?

Una pregunta, si yo en el ej2 de este parcial (gymRegistry) entregaba un enum membership con el siguiente funcionamiento:

```java
package C2_2021.ej2;

public enum Membership {
    BEGINNER(4), ADVANCED(8), Pro(0);
    private int monthlyVisits;
    Membership(int monthlyVisits){
        this.monthlyVisits = monthlyVisits;
    }
    public boolean canVisit(int currentVisits){
        if(this.monthlyVisits == 0) return true;
        return currentVisits < monthlyVisits;
    }
}
```


¿Hubiera recibido alguna penalización? Recién me avivé de que podía definir métodos abstractos en el enum y ponerle a cada uno su propia implementación cuando vi las soluciones.

Suele ser esa la implementación preferida cuando queremos una función dentro del enum, y nos encontramos que uno de las instancias del enum necesita tener un comportamiento distinto de las demás?

Por otro lado, ¿no podría criticarse la implementación de las soluciones, si pensamos en que BEGINNER y ADVANCED tienen literalmente la misma implementación pero cambiando el número?

Implementación de las soluciones:

```java
public enum Membership {

    BEGINNER {
        @Override
        public boolean canVisit(int currentVisits) {
            return currentVisits < 4;
        }
    },

    ADVANCED {
        @Override
        public boolean canVisit(int currentVisits) {
            return currentVisits < 8;
        }
    },

    PRO {
        @Override
        public boolean canVisit(int currentVisits) {
            return true;
        }
    };

    public abstract boolean canVisit(int currentVisits);

}
```

Muchas gracias!

## RESPUESTA
Hola Tomás.

Sí, aplicaría una penalización menor porque de forma imperativa estás preguntando si el valor que recibís coincide con el valor asociado únicamente a la instancia PRO, entonces ejecutás cierto código, sino ejecutás otro código. Esto no se ajusta al paradigma.

En cuanto a lo de la repetición en la implementación de las soluciones, entiendo tu punto. Se puede modularizar un poco más para no repetir el código de los métodos de BEGINNER y ADVANCED haciendo algo parecido a lo que hiciste vos, pero sobreescribiendo el método solo para la instancia PRO así:

```java
public enum Membership {

    BEGINNER(4),
    ADVANCED(8),
    PRO(0) {
        @Override
        public boolean canVisit(int currentVisits) {
            return true;
        }
    };

    private final int monthlyVisits;

    Membership(int monthlyVisits){
        this.monthlyVisits = monthlyVisits;
    }

    public boolean canVisit(int currentVisits) {
        return currentVisits < monthlyVisits;
    }

}
```

Como el comportamiento del canVisit para la mayoría de las instancias es la comparación, eso se implementa como método concreto que todas las instancias ofrecen. Luego, solo se sobreescribe la implementación concreta del mismo método en la instancia PRO para que ejecute otro código que no hace comparación ni usa la variable de instancia. El valor 0 en PRO me hace ruido, pero igual lo consideramos como una solución correcta porque se ajusta al paradigma.

# (R C1 2022) FlightSearch
Hola profe, ¿cómo estás?

Te escribo porque me quedó una duda del ejercicio que resolvimos hoy en clase. La consigna dice que ya se cuenta con el enum de las seatCategory. Con esto asumo que no se puede modificar. Esta es la definición del enum:

```java
public enum SeatCategory {
    ECONOMY, PREMIUM, BUSINESS
}
```
Luego, en el comparator que se le pasa a SeatFlightSearch, se hace un compare sobre el enum:

```java
package RC1_2022.ej2;

public class SeatFlightSearch {
    public SeatFlightSearch(String homeAirport){
        super(homeAirport, new Comparator<Flight>(){
            @Override
            public int compare(Flight flight1, Flight flight2){
               int cmp = o2.getSeatCategory().compareTo(o1.getSeatCategory());
               if (cmp == 0) return flight1.compareTo(flight2);
               return cmp;
            }
        });
    }
}
```

Si no se aclaró NADA más que los nombres de los enum, ¿el comportamiento por defecto del compareTo() es usar el orden de definición de los enum? ¿O mejor pregunta, existe una implementación default de compareTo() para los enum?

Muchas gracias.

## RESPUESTA
Hola Tomás.

Sí, el orden natural de los enum es el orden en que declaraste las constantes. Otra forma de verlo es ascendente por su ordinal(). Esto ya se explicó en el Ejercicio 11 del TP 5.

# (R2C - 2022) UndoCollection y duda Exceptions
Hola profe, ¿cómo estás? Espero que bien.

Resolví el ejercicio 1 del recu del título, UndoCollection, y me quedé con un par de dudas.

En primer lugar, en las soluciones se hace la implementación del método undo(int n) directamente en la interfaz. Yo lo hice en la implementación y en la interfaz tan solo incluí las declaraciones de los métodos. ¿Está mal?

Por otro lado, me quedó bastante distinta mi implementación de undo():

Yo:

```ruby
def undo()
    if undo(1) == 0
        raise NothingToUndoException, "Nothing to undo"
    end
end

def undo()
   if @operations.empty?
       raise NothingToUndoException.new("Nothing to undo")
   end
   remove(@operations.pop)
end
```

Veo cómo la solución de la catedra no solo es más elegante, sino que toma menos operaciones, pero solo en el caso de que la lista esté vacía. Si no lo está, ambas implementaciones hacen un remove(operations.pop) y listo. ¿Tendría alguna penalización por este llamado extra?

Luego, me quedó mal estilo el add(), pero ¿hay penalización para este tipo de cosas?:

```ruby
def add(elem)
    if super.add(elem) == false
        return false
    end
    @history.push(elem)
    return true
end
```
Por último, quería preguntarte esto el miércoles y me olvidé. Es una duda del primer parcial. La manera de distinguir si una Exception es RuntimeException es viendo si se hace ALGUN llamado sin hacer un try/catch, ¿verdad? O sea, todas las Checked Exception deben ser manejadas propiamente en TODOS LOS LLAMADOS. Por otro lado, no recuerdo si había que incluir un throws MyException en todas las funciones que lancen una Checked.

Muchas gracias. Saludos.

## RESPUESTA
Hola Tomás.

Como aclaramos en clase, si una implementación de un método la puedo declarar como default en la interfaz, mejor hacerlo así. Es un mejor diseño porque esa implementación default estará disponible para todas las implementaciones que en un futuro existan.

Está bien que undo llame a undo(1). En la solución lo hicimos al revés, pero lo importante es no repetir código, así que no lo veo mal.

El estilo del add se puede mejorar, pero no aplica ninguna penalización. No estás repitiendo código y no quedó más imperativo que la solución propuesta (el if sí o sí hay que hacerlo).

Respecto a lo último, si vos ves que un método es invocado dentro de un try/catch y fuera de un try/catch, entonces podés hacer que esa excepción sea no verificada (extiende a RuntimeException). Si tu método lanza una excepción verificada, tenés que poner throws en la firma o capturarla con un try/catch ("requerimiento catch or specify").

# BOOK BUNDLE
Por un lado, no me di cuenta de que podía usar un array porque para hacer el add iba a preguntar include?. Como leí "no acepta repetidos" automáticamente puse un Set y no lo pensé. ¿Tendría alguna penalización?

Por otro lado, estoy teniendo un problema con mi implementación de total(). Este es mi código de Bundle:

```ruby
class Bundle
  def initialize(name, discount_central)
    @name = name
    @discount_central = discount_central
    # No necesitaba hacer un Set, si en mi función can_add? iba a preguntar
    # Si estaba incluido en la colección para agregar. Un array era suficiente
    @books = Set.new
  end
 
  def can_add?(book)
    # !@books.include?(book)
    true
  end
 
  def add_book(book)
    raise BundleError, "Cannot add Book" unless can_add?(book)
    @books.add(book)
  end
 
  def total
    # Por alguna razón, esta línea no andaba sin el valor inicial para el accum
    @discount_central.apply_discount( @books.reduce(0){ |accum, book| accum + (book.price) } )
  end
 
  def to_s
    s = "Book Bundle: #{@name}\n"
    @books.each{ |book| s += (book.to_s + "\n") }
    s += ">>> Final Price: $#{self.total}"
  end
 
  def include?(book)
    @books.include?(book)
  end
 
  def test
    puts @books.reduce(){ |accum, book| accum + book.price }
  end
end
```

Si en mi función total no le paso un valor inicial al reduce, haciendo reduce(0), el programa crashea. Entiendo lo siguiente: "Si reduce no recibe un valor inicial, el accum toma como valor inicial el primer elemento del enumerable, y empieza iterando con el elemento en la siguiente posición. Si se le pasa un parámetro, accum toma el valor que se le pasa, y el elemento iterador arranca en la posición 0 del array".

Veras que incluí una función test. Con el siguiente programa de prueba, y si no le incluyo el 0 por parámetro, recibo el siguiente error:

```ruby
bbc = BundleDiscountCentral.new(0.10)

bb = Bundle.new('A crash course for mobile developers', bbc)

bb.add_book(Book.new('Swift Cookbook', 300, 'Software Development'))
bb.add_book(Book.new('Flutter for Beginners', 100, 'Software Development'))
bb.add_book(Book.new('The World', 200, 'Travel'))
bb.test
```

```bash
/bin/zsh -c "bash -c 'env RBENV_VERSION=3.2.0 /opt/homebrew/Cellar/rbenv/1.2.0/libexec/rbenv exec ruby /Users/tomaspinausig/Desktop/POO/01rubyCode/2doparcial/R_2C_2022/bundle.rb'"
/Users/tomaspinausig/Desktop/POO/01rubyCode/2doparcial/R_2C_2022/bundle.rb:42:in `block in test': undefined method `+' for #<Book:0x0000000103de09f0 @name="Swift Cookbook", @price=300, @genre="Software Development"> (NoMethodError)


    puts @books.reduce(){ |accum, book| accum + book.price }
                                              ^
	from /Users/tomaspinausig/.rbenv/versions/3.2.0/lib/ruby/3.2.0/set.rb:511:in `each_key'
	from /Users/tomaspinausig/.rbenv/versions/3.2.0/lib/ruby/3.2.0/set.rb:511:in `each'
	from /Users/tomaspinausig/Desktop/POO/01rubyCode/2doparcial/R_2C_2022/bundle.rb:42:in `reduce'
	from /Users/tomaspinausig/Desktop/POO/01rubyCode/2doparcial/R_2C_2022/bundle.rb:42:in `test'
	from /Users/tomaspinausig/Desktop/POO/01rubyCode/2doparcial/R_2C_2022/bundle.rb:54:in `<main>'

Process finished with exit code 1
```

Veo que está intentando hacer el + sobre el objeto book entero. No entiendo por qué este comportamiento cambia al agregarle el 0 por parámetro. También intenté ponerle paréntesis al llamado de book.price, pero sin suerte.

Espero que se entienda el problema.

Muchas gracias por tu tiempo.

## RESPUESTA

Hola Tomás.

Si usás un Set aplica una penalización porque en el tester te dicen que:

```#Se listan todos los libros del bundle respetando el orden de inserción```

Para respetar el orden de inserción necesitás un Array. Un Set no tiene orden.

Respecto al error es así como lo planteás vos. Si no le ponés el valor inicial 0 entonces accum arranca en una instancia de Book y la clase Book no cuenta con el método de instancia +.

Si vos le definís 0 como valor inicial, accum arranca en 0 y 0 sí tiene el 

método +. Sería así:

'''|accum, book| 0 + book.price''' 

Como el método price retorna un número y la suma entre un número y otro retorna otro número entonces en accum se almacena un número.


