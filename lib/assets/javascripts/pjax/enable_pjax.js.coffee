$ -> $('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax]):not([href^="http"]):not([href^="#"]):not([target="_blank"])').pjax({
  container: '[data-pjax-container]',
  timeout: 2000,
  fragment: '#content'
})
