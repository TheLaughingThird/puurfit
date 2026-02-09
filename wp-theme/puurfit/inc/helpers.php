<?php
function puurfit_asset(string $path): string {
  return get_template_directory_uri() . '/' . ltrim($path, '/');
}
