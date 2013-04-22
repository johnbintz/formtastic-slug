class SlugInput < Formtastic::Inputs::StringInput
  def to_html
    input_wrapping do
      label_html <<
      action_buttons <<
      builder.text_field(method, input_html_options.merge(:disabled => true)) <<
      slug_js_setup
    end
  end

  def action_buttons
    template.button_tag('Edit', :type => 'edit', 'data-mode' => 'disabled', 'data-action' => 'edit') <<
    template.button_tag('Update', :type => 'update', 'data-mode' => 'enabled', 'data-action' => 'update', :style => 'display: none') <<
    template.button_tag('Cancel', :type => 'cancel', 'data-mode' => 'enabled', 'data-action' => 'cancel', :style => 'display: none')
  end

  def input_html_options
    super.merge(:style => 'width: 40%')
  end

  def target_dom_id
    [
      builder.custom_namespace,
      sanitized_object_name,
      target_method_name
    ].reject { |x| x.blank? }.join('_')
  end

  def target_method_name
    @target_method_name ||= options.delete(:based_on)
  end

  def sanitized_target_method_name
    target_method_name.to_s.gsub(/[\?\/\-]$/, '')
  end

  def existing_slugs
    options[:existing_slugs] || []
  end

  def slug_js_setup
    (<<-JS).html_safe
<script type="text/javascript">
  (function() {
    var targetField = $('##{target_dom_id}');
    var slugField = $('##{dom_id}');
    var slugInputWrap = $('##{dom_id}_input');
    var existingSlugs = #{existing_slugs.to_json};
    var startingSlug = slugField.val();

    var setSlug = function(text) {
      var i, k;

      var originalSlug = text.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');
      var newSlug = originalSlug;
      var index = 0;

      while (true) {
        for (i = 0, j = existingSlugs.length; i < j; ++i) {
          if (newSlug != startingSlug && newSlug == existingSlugs[i]) {
            index += 1;
            newSlug = originalSlug + "-" + String(index);
            break;
          }
        }

        break;
      }

      slugField.val(newSlug);
    };

    targetField.on('blur change', function(e) {
      if (slugField.val() == '') {
        setSlug(targetField.val());
      }

      return true;
    });

    slugInputWrap.find('[data-action=edit]').on('click', function(e) {
      slugInputWrap.find('button').toggle();
      slugField.attr('disabled', false);
      slugField.data('original', slugField.val());
      slugField.focus();
      return false;
    });

    var resetToDisabled = function() {
      slugInputWrap.find('button').toggle();
      slugField.attr('disabled', true);
      return false;
    };

    slugInputWrap.find('[data-action=cancel]').on('click', function(e) {
      slugField.val(slugField.data('original'));
      return resetToDisabled();
    });

    slugInputWrap.find('[data-action=update]').on('click', function(e) {
      setSlug(slugField.val());
      return resetToDisabled();
    });

    slugField.closest('form').on('submit', function() {
      slugField.attr('disabled', false);
      if (slugField.val() == '') {
        setSlug(targetField.val());
      }
      return true;
    });
  })(this);
</script>
    JS
  end
end

