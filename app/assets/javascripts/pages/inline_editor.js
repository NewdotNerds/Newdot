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
      $('#title-dashS, #title-dashL').removeClass('hide');
      $('#cont-main').removeClass('cont-main');
      $('#cont-main').addClass('cont-choose');
      $('#choose').addClass('choose-form');
      $('#short, #large').show();
      //$('#short').addClass('back-options');
    });
    
    /*Choose options (post short or large)*/
    $('#large').click(function() {
      $('#short').removeClass('back-options');
      $('#large').addClass('back-options');
      $('#short-form').hide();
      $('#large-form').show();
    });
    $('#short').click(function() {
      $('#large').removeClass('back-options');
      $('#short').addClass('back-options');
      $('#short-form').show();
      $('#large-form').hide();
    });

    $('[data-behavior="editor-cancel"]').click(function(e) {
      e.preventDefault();
      $('#inline-editor').removeClass('active');
      $('#title-dashS, #title-dashL').addClass('hide');
      $('#cont-main').removeClass('cont-choose');
      $('#cont-main').addClass('cont-main');
      $('#choose').removeClass('choose-form')
      $('#short, #large').hide();
      $('#large-form').addClass('dis-largeform');
      InlineEditor.clearEditor(editor);
    });
  },

  clearEditor: function(editor) {
    editor.destroy();
    $('#editor-body').val('');
    editor.setup();
    editor.subscribe('focus', function() {
      $('#inline-editor').addClass('active');
      $('#title-dashS, #title-dashL').removeClass('hide');
      $('#cont-main').addClass('cont-choose');
      $('#choose').addClass('choose-form')
      $('#short, #large, #middle').show();
    });
  }
};

$(document).ready( InlineEditor.init );
$(document).on( 'page:load', InlineEditor.init );
