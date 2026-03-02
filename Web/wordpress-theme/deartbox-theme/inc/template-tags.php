<?php
/**
 * Custom template tags for Deartbox theme
 *
 * @package Deartbox
 */

if (!defined('ABSPATH')) {
    exit;
}

/**
 * Prints HTML with meta information for the current post-date/time
 */
function deartbox_posted_on() {
    $time_string = '<time class="entry-date published" datetime="%1$s">%2$s</time>';

    $time_string = sprintf(
        $time_string,
        esc_attr(get_the_date(DATE_W3C)),
        esc_html(get_the_date())
    );

    echo '<span class="posted-on">' . $time_string . '</span>';
}

/**
 * Prints HTML with meta information for the current author
 */
function deartbox_posted_by() {
    echo '<span class="byline"><span class="author vcard">';
    echo '<a class="url fn n" href="' . esc_url(get_author_posts_url(get_the_author_meta('ID'))) . '">';
    echo esc_html(get_the_author());
    echo '</a></span></span>';
}

/**
 * Prints HTML with meta information for categories
 */
function deartbox_entry_categories() {
    if ('post' === get_post_type()) {
        $categories_list = get_the_category_list(', ');
        if ($categories_list) {
            echo '<span class="cat-links">' . $categories_list . '</span>';
        }
    }
}

/**
 * Prints HTML with meta information for tags
 */
function deartbox_entry_tags() {
    if ('post' === get_post_type()) {
        $tags_list = get_the_tag_list('', ', ');
        if ($tags_list) {
            echo '<span class="tags-links">' . $tags_list . '</span>';
        }
    }
}

/**
 * Prints the post thumbnail
 */
function deartbox_post_thumbnail($size = 'deartbox-card') {
    if (post_password_required() || is_attachment() || !has_post_thumbnail()) {
        return;
    }

    if (is_singular()) {
        ?>
        <div class="post-thumbnail">
            <?php the_post_thumbnail($size); ?>
        </div>
        <?php
    } else {
        ?>
        <a class="post-thumbnail" href="<?php the_permalink(); ?>" aria-hidden="true" tabindex="-1">
            <?php the_post_thumbnail($size, array('alt' => the_title_attribute(array('echo' => false)))); ?>
        </a>
        <?php
    }
}

/**
 * Get first category
 */
function deartbox_first_category() {
    $categories = get_the_category();
    if (!empty($categories)) {
        return $categories[0];
    }
    return null;
}

/**
 * Display SVG icon
 */
function deartbox_icon($name, $size = 20) {
    $icons = array(
        'calendar' => '<svg width="' . $size . '" height="' . $size . '" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>',
        'user' => '<svg width="' . $size . '" height="' . $size . '" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>',
        'clock' => '<svg width="' . $size . '" height="' . $size . '" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>',
        'arrow-right' => '<svg width="' . $size . '" height="' . $size . '" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>',
        'arrow-left' => '<svg width="' . $size . '" height="' . $size . '" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>',
        'search' => '<svg width="' . $size . '" height="' . $size . '" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>',
        'menu' => '<svg width="' . $size . '" height="' . $size . '" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="3" y1="12" x2="21" y2="12"></line><line x1="3" y1="6" x2="21" y2="6"></line><line x1="3" y1="18" x2="21" y2="18"></line></svg>',
        'x' => '<svg width="' . $size . '" height="' . $size . '" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>',
        'sun' => '<svg width="' . $size . '" height="' . $size . '" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="5"></circle><line x1="12" y1="1" x2="12" y2="3"></line><line x1="12" y1="21" x2="12" y2="23"></line><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line><line x1="1" y1="12" x2="3" y2="12"></line><line x1="21" y1="12" x2="23" y2="12"></line><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line></svg>',
        'moon' => '<svg width="' . $size . '" height="' . $size . '" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path></svg>',
        'instagram' => '<svg width="' . $size . '" height="' . $size . '" viewBox="0 0 24 24" fill="currentColor"><path d="M7 2h10a5 5 0 015 5v10a5 5 0 01-5 5H7a5 5 0 01-5-5V7a5 5 0 015-5zm5 5a5 5 0 100 10 5 5 0 000-10zm6.5-.5a1 1 0 10-1 1 1 1 0 001-1z"/></svg>',
        'linkedin' => '<svg width="' . $size . '" height="' . $size . '" viewBox="0 0 24 24" fill="currentColor"><path d="M4.98 3.5a2.5 2.5 0 110 5 2.5 2.5 0 010-5zM3 9h4v12H3zm7 0h4v1.7c.6-1 2-2 4-2 4 0 5 2.6 5 6v6h-4v-5.3c0-1.3 0-3-2-3s-2.3 1.5-2.3 2.9V21h-4z"/></svg>',
        'youtube' => '<svg width="' . $size . '" height="' . $size . '" viewBox="0 0 24 24" fill="currentColor"><path d="M23.498 6.186a2.978 2.978 0 0 0-2.094-2.106C19.505 3.5 12 3.5 12 3.5s-7.505 0-9.404.58A2.978 2.978 0 0 0 .502 6.186 31.248 31.248 0 0 0 0 12a31.248 31.248 0 0 0 .502 5.814 2.978 2.978 0 0 0 2.094 2.106C4.495 20.5 12 20.5 12 20.5s7.505 0 9.404-.58a2.978 2.978 0 0 0 2.094-2.106A31.248 31.248 0 0 0 24 12a31.248 31.248 0 0 0-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/></svg>',
        'facebook' => '<svg width="' . $size . '" height="' . $size . '" viewBox="0 0 24 24" fill="currentColor"><path d="M22.675 0h-21.35C.597 0 0 .597 0 1.326v21.348C0 23.403.597 24 1.326 24h11.494v-9.294H9.691v-3.622h3.129V8.413c0-3.1 1.893-4.788 4.659-4.788 1.325 0 2.463.099 2.795.143v3.24l-1.918.001c-1.504 0-1.796.715-1.796 1.763v2.313h3.587l-.467 3.622h-3.12V24h6.116C23.403 24 24 23.403 24 22.674V1.326C24 .597 23.403 0 22.675 0z"/></svg>',
        'whatsapp' => '<svg width="' . $size . '" height="' . $size . '" viewBox="0 0 24 24" fill="currentColor"><path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413Z"/></svg>',
    );

    if (isset($icons[$name])) {
        return $icons[$name];
    }

    return '';
}

/**
 * Echo SVG icon
 */
function deartbox_the_icon($name, $size = 20) {
    echo deartbox_icon($name, $size);
}
