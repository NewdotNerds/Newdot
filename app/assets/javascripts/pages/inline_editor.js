var InlineEditor = {
  init: function() {
    /*** Simply return if it's not dashboards#show page ***/
    if (!$('[data-page="inline-editor"]').length > 0) {
      return;
    }
    var editor = new MediumEditor('.medium-editable', {
      placeholder: {
        text: "¡Cuéntanos qué sabes!..."
      }
    });

    editor.subscribe('focus', function() {
      $('#inline-editor').addClass('active');
      $('#title-dash').removeClass('hide');
    });

    $('[data-behavior="editor-cancel"]').click(function(e) {
      e.preventDefault();
      $('#inline-editor').removeClass('active');
      $('#title-dash').addClass('hide');
      InlineEditor.clearEditor(editor);
    });
  },

  clearEditor: function(editor) {
    editor.destroy();
    $('#editor-body').val('');
    editor.setup();
    editor.subscribe('focus', function() {
      $('#inline-editor').addClass('active');
      $('#title-dash').removeClass('hide');
    });
  }
};

$(document).ready( InlineEditor.init );
$(document).on( 'page:load', InlineEditor.init );
