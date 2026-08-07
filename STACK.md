# STACK.md

## Tecnologías del proyecto

Este proyecto está pensado para **celular** (móvil) y usa las siguientes tecnologías web:

| Tecnología | Rol en el proyecto | Uso |
|------------|--------------------|-----|
| HTML5 | Estructura de la página | Maquetación de pantallas |
| CSS3 | Estilos y diseño | Diseño responsivo para móvil |
| JavaScript | Lógica e interacción | Funcionalidad de la app |

## HTML5

Estructura base de una página:

```html
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Mi app móvil</title>
</head>
<body>
  <h1>¡Hola, mundo!</h1>
</body>
</html>
```

## CSS3

Estilos responsivos para celular:

```css
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
}

@media (max-width: 600px) {
  body {
    background-color: #f0f0f0;
  }
}
```

## JavaScript

Lógica básica de interacción:

```javascript
const boton = document.getElementById('boton');

boton.addEventListener('click', function () {
  alert('¡Funciona en tu celular!');
});
```
