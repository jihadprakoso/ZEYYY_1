<?php
/**
 * Comments template
 *
 * @package Deartbox
 */

if (post_password_required()) {
    return;
}
?>

<div id="comments" class="comments-area">
    <?php if (have_comments()) : ?>
        <h2 class="comments-title">
            <?php
            $comment_count = get_comments_number();
            printf(
                _n('%s Komentar', '%s Komentar', $comment_count, 'deartbox'),
                number_format_i18n($comment_count)
            );
            ?>
        </h2>

        <ol class="comment-list">
            <?php
            wp_list_comments(array(
                'style'       => 'ol',
                'short_ping'  => true,
                'avatar_size' => 48,
                'callback'    => 'deartbox_comment',
            ));
            ?>
        </ol>

        <?php
        the_comments_navigation(array(
            'prev_text' => deartbox_icon('arrow-left', 14) . ' Komentar Sebelumnya',
            'next_text' => 'Komentar Selanjutnya ' . deartbox_icon('arrow-right', 14),
        ));
        ?>

    <?php endif; ?>

    <?php if (!comments_open() && get_comments_number() && post_type_supports(get_post_type(), 'comments')) : ?>
        <p class="no-comments"><?php _e('Komentar ditutup.', 'deartbox'); ?></p>
    <?php endif; ?>

    <?php
    comment_form(array(
        'title_reply'          => __('Tinggalkan Komentar', 'deartbox'),
        'title_reply_to'       => __('Balas ke %s', 'deartbox'),
        'cancel_reply_link'    => __('Batal', 'deartbox'),
        'label_submit'         => __('Kirim Komentar', 'deartbox'),
        'comment_field'        => '<p class="comment-form-comment"><label for="comment">' . __('Komentar', 'deartbox') . '</label><textarea id="comment" name="comment" cols="45" rows="6" required></textarea></p>',
    ));
    ?>
</div>
