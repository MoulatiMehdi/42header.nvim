# 42header

`42header` is a custom Neovim plugin written in Lua that generates a standardized header for source code files. The header includes information such as the filename, author, creation date, and last updated date, along with a custom ASCII art banner.

## Features

- Automatically inserts a standard header at the top of supported file types.
- Updates the "Updated" date in the header before saving the file.
- Customizable ASCII art banner.
- Supports multiple file types with appropriate comment styles.

## Installation

### Using `packer.nvim`

1. Add the following to your `init.lua`:

    ```lua
    use 'MoulatiMehdi/neovim-42header'
    ```

2. Source your `init.lua` and run `:PackerSync`.

## Configuration

1. Place the `42header.lua` file in a custom directory (e.g., `lua/custom/`).
2. Add the following to your `init.lua` to load the plugin:

    ```lua
    require('custom.42header')
    ```

## Usage

- To insert the standard header, use the command:

    ```vim
    :Stdheader
    ```

- You can also use the shortcut `F1` to insert the header.

- The plugin automatically updates the "Updated" date in the header before saving the file.

## Customization

You can customize the ASCII art, the default header settings, and the supported file types by editing the `42header.lua` file.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request or open an Issue.

## Acknowledgements

Inspired by 42 header standards and Neovim customization.
