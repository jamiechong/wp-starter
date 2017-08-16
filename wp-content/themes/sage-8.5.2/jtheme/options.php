<?php

// namespace Jtheme\Options;

if (function_exists('acf_add_options_page')):

acf_add_options_page(array(
  'page_title' => 'Theme Settings',
  'menu_slug' => 'theme-settings',
  'redirect' => true,
));

acf_add_options_sub_page(array(
  'page_title'  => 'General',
  'parent_slug' => 'theme-settings',
));

endif;
