
# 42header 📜

`42header` is a custom Neovim plugin written in Lua that generates a standardized header for source code files. The header includes information such as the filename, author, creation date, and last updated date, along with a custom ASCII art banner.

## Features ✨

- Automatically inserts a standard header at the top of supported file types.
- Updates the "Updated" date in the header before saving the file.
- Customizable ASCII art banner.
- Supports multiple file types with appropriate comment styles.

## Installation 🚀

### Using `packer.nvim`

1. Ensure you have `packer.nvim` installed. If not, follow the [installation instructions](https://github.com/wbthomason/packer.nvim#quickstart) on the `packer.nvim` GitHub page.

2. Add the `42header` plugin to your `packer` setup in your `init.lua`:

    ```lua
    require('packer').startup(function()
      -- Packer can manage itself
      use 'wbthomason/packer.nvim'

      -- Add the 42header plugin
      use 'MoulatiMehdi/neovim-42header'
    end)
    ```

3. Open Neovim and run the following command to install the plugin:

    ```vim
    :PackerSync
    ```

## Configuration ⚙️

1. Place the `42header.lua` file in a directory named `42header` (e.g., `lua/42header/`).
2. Add the following to your `init.lua` to load the plugin:

    ```lua
    require('42header.42header')
    ```

## Usage 🛠️

- To insert the standard header, use the command:

    ```vim
    :Stdheader
    ```

- You can also use the shortcut `F1` to insert the header.

- The plugin automatically updates the "Updated" date in the header before saving the file.

## Customization 🎨

You can customize the ASCII art, the default header settings, and the supported file types by editing the `42header.lua` file.

### Example Header

![Example Header](path/to/your/image.png)

## License 📜

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request or open an Issue.

## Acknowledgements 🙏

Inspired by 42 header standards and Neovim customization.
