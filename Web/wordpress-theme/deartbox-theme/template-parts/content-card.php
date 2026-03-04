<?php
/**
 * Template part for displaying post cards
 *
 * @package Deartbox
 */

$category = deartbox_first_category();
$reading_time = deartbox_reading_time();
?>

<article id="post-<?php the_ID(); ?>" <?php post_class('post-card'); ?>>
    <!-- Thumbnail -->
    <div class="post-card-thumbnail">
        <?php if (has_post_thumbnail()) : ?>
            <a href="<?php the_permalink(); ?>">
                <?php the_post_thumbnail('deartbox-card', array('alt' => get_the_title())); ?>
            </a>
        <?php else : ?>
            <a href="<?php the_permalink(); ?>" class="post-card-thumb-placeholder" aria-hidden="true" tabindex="-1">
                <div class="post-card-no-image">
                    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" aria-hidden="true">
                        <rect x="3" y="3" width="18" height="18" rx="2"/><circle cx="8.5" cy="8.5" r="1.5"/><polyline points="21 15 16 10 5 21"/>
                    </svg>
                </div>
            </a>
        <?php endif; ?>
        
        <?php if ($category) : ?>
            <a href="<?php echo esc_url(get_category_link($category->term_id)); ?>" class="post-card-category">
                <?php echo esc_html($category->name); ?>
            </a>
        <?php endif; ?>
    </div>

    <!-- Content -->
    <div class="post-card-content">
        <div class="post-card-meta">
            <span class="date">
                <?php deartbox_the_icon('calendar', 14); ?>
                <?php echo get_the_date(); ?>
            </span>
            <span class="reading-time">
                <?php deartbox_the_icon('clock', 14); ?>
                <?php echo $reading_time; ?> min
            </span>
        </div>

        <h2 class="post-card-title">
            <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
        </h2>

        <p class="post-card-excerpt">
            <?php echo wp_trim_words(get_the_excerpt(), 20, '...'); ?>
        </p>

        <a href="<?php the_permalink(); ?>" class="post-card-link">
            Baca Selengkapnya
            <?php deartbox_the_icon('arrow-right', 16); ?>
        </a>
    </div>
</article>
