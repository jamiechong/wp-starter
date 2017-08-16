<?php
namespace Jtheme\Component;

define('JTHEME_COMPONENT_DIR', get_template_directory().'/templates/components/');

function render($view, array $args = array(), $settings= array()) {
  $settings = array_merge(array(
    'echo' => true,
    'strip_newlines' => true, // only if echo false
    'wrap_tag' => 'div',
    'wrap' => false,      // the wrap class
    'atts' => false       // the wrap attributes (string)
  ), $settings);


  $html = '';
  if (!$settings['echo']) {
    ob_start();
  }

  if ($settings['wrap'] !== false) {
    echo '<'.$settings['wrap_tag'].' class="'.$settings['wrap'].'" '.$settings['atts'].'>';
  }

  foreach ($args as $key => $val) {
    $$key = $val;
  }
  $file = JTHEME_COMPONENT_DIR . $view . '.php';
  require($file);

  if ($settings['wrap'] !== false) {
    echo '</'.$settings['wrap_tag'].'>';
  }

  if (!$settings['echo']) {
    $html = ob_get_clean();
    if ($settings['strip_newlines']) {
      $html = str_replace("\n", '', $html);
    }
  }
  return $html;
}
