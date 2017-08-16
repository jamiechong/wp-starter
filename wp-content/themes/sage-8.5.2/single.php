<?php the_post(); ?>
<article <?php post_class(); ?>>
  <header>
    <h1 class="entry-title"><?php the_title(); ?></h1>
  </header>
  <div class="entry-content">
    <?php the_content(); ?>
  </div>
  <footer>
  </footer>
  <?php comments_template('/templates/comments.php'); ?>
</article>
