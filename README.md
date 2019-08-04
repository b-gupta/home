# Bharat's linux setup

## Keyboard mod

I like using <alt>/<cmd> key instead of <ctrl>. So I found a way to reverse them and then still be able to use <alt>+<tab> and <alt>+` to switch applicaitons/windows.

1. Use the ~/.Xmodmap file provided. It essentially swaps left <ctrl> and left <alt> keys. Run the following command:
xmodmap ~/.Xmodmap

2. Install autokey and add mappings for <ctrl>+z & <ctrl>+c

3. In Settings->Keyboard->Shortcuts, change `Switch Application` and `Switch Windows of an Application` to use <ctrl>+tab & <ctrl>+`
