#!/bin/bash
rsync -avz --delete ~/.config/fish/ fish/
rsync -avz --delete ~/.config/htop/ htop/
rsync -avz --delete ~/.config/nvim/ nvim/
