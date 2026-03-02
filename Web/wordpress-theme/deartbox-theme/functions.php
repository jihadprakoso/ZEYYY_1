<?php
/**
 * Deartbox Blog Theme Functions
 *
 * @package Deartbox
 * @version 1.0.0
 */

if (!defined('ABSPATH')) {
    exit;
}

// Theme Version
define('DEARTBOX_VERSION', '1.0.0');

/**
 * Theme Setup
 */
function deartbox_setup() {
    // Add default posts and comments RSS feed links to head
    add_theme_support('automatic-feed-links');

    // Let WordPress manage the document title
    add_theme_support('title-tag');

    // Enable support for Post Thumbnails
    add_theme_support('post-thumbnails');
    set_post_thumbnail_size(1200, 630, true);
    add_image_size('deartbox-card', 600, 375, true);
    add_image_size('deartbox-featured', 1200, 630, true);

    // Register navigation menus
    register_nav_menus(array(
        'primary' => __('Primary Menu', 'deartbox'),
        'footer'  => __('Footer Menu', 'deartbox'),
    ));

    // Switch default core markup to output valid HTML5
    add_theme_support('html5', array(
        'search-form',
        'comment-form',
        'comment-list',
        'gallery',
        'caption',
        'style',
        'script',
    ));

    // Add support for custom logo
    add_theme_support('custom-logo', array(
        'height'      => 80,
        'width'       => 200,
        'flex-height' => true,
        'flex-width'  => true,
    ));

    // Add support for responsive embeds
    add_theme_support('responsive-embeds');

    // Add support for editor styles
    add_theme_support('editor-styles');
    add_editor_style('assets/css/editor-style.css');

    // Add support for wide alignment
    add_theme_support('align-wide');
}
add_action('after_setup_theme', 'deartbox_setup');

/**
 * Set the content width
 */
function deartbox_content_width() {
    $GLOBALS['content_width'] = apply_filters('deartbox_content_width', 800);
}
add_action('after_setup_theme', 'deartbox_content_width', 0);

/**
 * Enqueue scripts and styles
 */
function deartbox_scripts() {
    // Google Fonts
    wp_enqueue_style(
        'deartbox-fonts',
        'https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@600;700;800&display=swap',
        array(),
        null
    );

    // Main stylesheet
    wp_enqueue_style(
        'deartbox-style',
        get_stylesheet_uri(),
        array(),
        DEARTBOX_VERSION
    );

    // Theme JavaScript
    wp_enqueue_script(
        'deartbox-script',
        get_template_directory_uri() . '/assets/js/main.js',
        array(),
        DEARTBOX_VERSION,
        true
    );

    // Comment reply script
    if (is_singular() && comments_open() && get_option('thread_comments')) {
        wp_enqueue_script('comment-reply');
    }
}

/**
 * Enqueue admin scripts for media uploader
 */
function deartbox_admin_scripts() {
    wp_enqueue_media();
}
add_action('admin_enqueue_scripts', 'deartbox_admin_scripts');
add_action('wp_enqueue_scripts', 'deartbox_scripts');

/**
 * Register widget areas
 */
function deartbox_widgets_init() {
    register_sidebar(array(
        'name'          => __('Blog Sidebar', 'deartbox'),
        'id'            => 'sidebar-blog',
        'description'   => __('Add widgets here to appear in blog sidebar.', 'deartbox'),
        'before_widget' => '<div id="%1$s" class="widget %2$s">',
        'after_widget'  => '</div>',
        'before_title'  => '<h3 class="widget-title">',
        'after_title'   => '</h3>',
    ));

    register_sidebar(array(
        'name'          => __('Footer Widget 1', 'deartbox'),
        'id'            => 'footer-1',
        'description'   => __('Add widgets here to appear in footer column 1.', 'deartbox'),
        'before_widget' => '<div id="%1$s" class="footer-widget %2$s">',
        'after_widget'  => '</div>',
        'before_title'  => '<h4 class="footer-widget-title">',
        'after_title'   => '</h4>',
    ));

    register_sidebar(array(
        'name'          => __('Footer Widget 2', 'deartbox'),
        'id'            => 'footer-2',
        'description'   => __('Add widgets here to appear in footer column 2.', 'deartbox'),
        'before_widget' => '<div id="%1$s" class="footer-widget %2$s">',
        'after_widget'  => '</div>',
        'before_title'  => '<h4 class="footer-widget-title">',
        'after_title'   => '</h4>',
    ));
}
add_action('widgets_init', 'deartbox_widgets_init');

/**
 * Custom excerpt length
 */
function deartbox_excerpt_length($length) {
    return 25;
}
add_filter('excerpt_length', 'deartbox_excerpt_length');

/**
 * Custom excerpt more
 */
function deartbox_excerpt_more($more) {
    return '...';
}
add_filter('excerpt_more', 'deartbox_excerpt_more');

/**
 * Add custom classes to body
 */
function deartbox_body_classes($classes) {
    // Add class for singular pages
    if (is_singular()) {
        $classes[] = 'singular';
    }

    // Add class for blog page
    if (is_home() || is_archive() || is_search()) {
        $classes[] = 'blog-page';
    }

    return $classes;
}
add_filter('body_class', 'deartbox_body_classes');

/**
 * Get reading time estimate
 */
function deartbox_reading_time($post_id = null) {
    if (!$post_id) {
        $post_id = get_the_ID();
    }
    
    $content = get_post_field('post_content', $post_id);
    $word_count = str_word_count(strip_tags($content));
    $reading_time = ceil($word_count / 200); // 200 words per minute
    
    return $reading_time;
}

/**
 * Custom comment callback
 */
function deartbox_comment($comment, $args, $depth) {
    $GLOBALS['comment'] = $comment;
    ?>
    <li <?php comment_class(); ?> id="comment-<?php comment_ID(); ?>">
        <article class="comment-body">
            <div class="comment-author">
                <?php echo get_avatar($comment, 48); ?>
                <div class="comment-author-info">
                    <?php printf('<cite class="fn">%s</cite>', get_comment_author_link()); ?>
                    <div class="comment-meta">
                        <time datetime="<?php comment_time('c'); ?>">
                            <?php printf('%1$s at %2$s', get_comment_date(), get_comment_time()); ?>
                        </time>
                    </div>
                </div>
            </div>
            <div class="comment-content">
                <?php comment_text(); ?>
            </div>
            <?php
            comment_reply_link(array_merge($args, array(
                'depth'     => $depth,
                'max_depth' => $args['max_depth'],
            )));
            ?>
        </article>
    <?php
}

/**
 * Breadcrumbs
 */
function deartbox_breadcrumbs() {
    if (is_front_page()) {
        return;
    }

    echo '<nav class="breadcrumbs" aria-label="Breadcrumb">';
    echo '<a href="' . esc_url(home_url('/')) . '">Blog</a>';
    echo '<span class="separator"> / </span>';

    if (is_category() || is_single()) {
        $categories = get_the_category();
        if ($categories) {
            echo '<a href="' . esc_url(get_category_link($categories[0]->term_id)) . '">' . esc_html($categories[0]->name) . '</a>';
            if (is_single()) {
                echo '<span class="separator"> / </span>';
                echo '<span class="current">' . get_the_title() . '</span>';
            }
        }
    } elseif (is_page()) {
        echo '<span class="current">' . get_the_title() . '</span>';
    } elseif (is_search()) {
        echo '<span class="current">Search Results</span>';
    } elseif (is_404()) {
        echo '<span class="current">404 Not Found</span>';
    }

    echo '</nav>';
}

/**
 * Social share buttons
 */
function deartbox_social_share() {
    $url = urlencode(get_permalink());
    $title = urlencode(get_the_title());
    
    $share_links = array(
        'facebook' => 'https://www.facebook.com/sharer/sharer.php?u=' . $url,
        'twitter'  => 'https://twitter.com/intent/tweet?url=' . $url . '&text=' . $title,
        'linkedin' => 'https://www.linkedin.com/shareArticle?mini=true&url=' . $url . '&title=' . $title,
        'whatsapp' => 'https://wa.me/?text=' . $title . '%20' . $url,
    );
    
    return $share_links;
}

/**
 * Related posts
 */
function deartbox_related_posts($post_id = null, $count = 3) {
    if (!$post_id) {
        $post_id = get_the_ID();
    }

    $categories = get_the_category($post_id);
    if (!$categories) {
        return array();
    }

    $category_ids = array();
    foreach ($categories as $category) {
        $category_ids[] = $category->term_id;
    }

    $args = array(
        'category__in'        => $category_ids,
        'post__not_in'        => array($post_id),
        'posts_per_page'      => $count,
        'ignore_sticky_posts' => 1,
        'orderby'             => 'rand',
    );

    return new WP_Query($args);
}

/**
 * Disable Gutenberg for specific post types (optional)
 */
// function deartbox_disable_gutenberg($current_status, $post_type) {
//     if ($post_type === 'page') return false;
//     return $current_status;
// }
// add_filter('use_block_editor_for_post_type', 'deartbox_disable_gutenberg', 10, 2);

/**
 * Add theme customizer options
 */
function deartbox_customize_register($wp_customize) {
    // Main Site URL
    $wp_customize->add_section('deartbox_main_site', array(
        'title'    => __('Main Site Settings', 'deartbox'),
        'priority' => 30,
    ));

    $wp_customize->add_setting('main_site_url', array(
        'default'           => 'https://deartbox.com',
        'sanitize_callback' => 'esc_url_raw',
    ));

    $wp_customize->add_control('main_site_url', array(
        'label'   => __('Main Site URL', 'deartbox'),
        'section' => 'deartbox_main_site',
        'type'    => 'url',
    ));

    // Social Media Links
    $wp_customize->add_section('deartbox_social', array(
        'title'    => __('Social Media Links', 'deartbox'),
        'priority' => 35,
    ));

    $social_networks = array('instagram', 'linkedin', 'youtube', 'facebook', 'whatsapp');
    
    foreach ($social_networks as $network) {
        $wp_customize->add_setting('social_' . $network, array(
            'default'           => '',
            'sanitize_callback' => 'esc_url_raw',
        ));

        $wp_customize->add_control('social_' . $network, array(
            'label'   => ucfirst($network) . ' URL',
            'section' => 'deartbox_social',
            'type'    => 'url',
        ));
    }

    // Contact Info
    $wp_customize->add_section('deartbox_contact', array(
        'title'    => __('Contact Information', 'deartbox'),
        'priority' => 40,
    ));

    $wp_customize->add_setting('contact_phone', array(
        'default'           => '+62 819-5181-427',
        'sanitize_callback' => 'sanitize_text_field',
    ));

    $wp_customize->add_control('contact_phone', array(
        'label'   => __('Phone Number', 'deartbox'),
        'section' => 'deartbox_contact',
        'type'    => 'text',
    ));

    $wp_customize->add_setting('contact_email', array(
        'default'           => 'deartboxpackaging@gmail.com',
        'sanitize_callback' => 'sanitize_email',
    ));

    $wp_customize->add_control('contact_email', array(
        'label'   => __('Email Address', 'deartbox'),
        'section' => 'deartbox_contact',
        'type'    => 'email',
    ));

    $wp_customize->add_setting('contact_address', array(
        'default'           => 'Jl. Gandaria 1 No. 3, Gandaria Utara, Jakarta Selatan 12130',
        'sanitize_callback' => 'sanitize_textarea_field',
    ));

    $wp_customize->add_control('contact_address', array(
        'label'   => __('Address', 'deartbox'),
        'section' => 'deartbox_contact',
        'type'    => 'textarea',
    ));
}
add_action('customize_register', 'deartbox_customize_register');

/**
 * Get theme mod with default
 */
function deartbox_get_option($key, $default = '') {
    return get_theme_mod($key, $default);
}

/**
 * Security: Remove WordPress version from head
 */
remove_action('wp_head', 'wp_generator');

/**
 * Security: Disable XML-RPC
 */
add_filter('xmlrpc_enabled', '__return_false');

/**
 * Performance: Remove emoji scripts
 */
function deartbox_disable_emojis() {
    remove_action('wp_head', 'print_emoji_detection_script', 7);
    remove_action('admin_print_scripts', 'print_emoji_detection_script');
    remove_action('wp_print_styles', 'print_emoji_styles');
    remove_action('admin_print_styles', 'print_emoji_styles');
    remove_filter('the_content_feed', 'wp_staticize_emoji');
    remove_filter('comment_text_rss', 'wp_staticize_emoji');
    remove_filter('wp_mail', 'wp_staticize_emoji_for_email');
}
add_action('init', 'deartbox_disable_emojis');

/**
 * Include template parts
 */
require_once get_template_directory() . '/inc/template-tags.php';
