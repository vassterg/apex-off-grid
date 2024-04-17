<div>
  <script>
    function loadCSS(href) {
      const link = document.createElement("link");
      link.href = href;
      link.rel = "stylesheet";
      link.type = "text/css";

      const head = document.getElementsByTagName("head")[0];
      head.appendChild(link);
    }

    loadCSS(
      "https://static.oracle.com/cdn/apex/23.2.4/themes/theme_42/23.2/css/Core.min.css?v=23.2.4"
    );
    loadCSS(
      "https://static.oracle.com/cdn/apex/23.2.4/themes/theme_42/23.2/css/Vita.min.css?v=23.2.4"
    );
    loadCSS(
      "https://static.oracle.com/cdn/apex/23.2.4/libraries/font-apex/2.2.1/css/font-apex.min.css?v=23.2.4"
    );
  </script>

  <script>
    function allLoaded() {
      apex.debug.setLevel(apex.debug.LOG_LEVEL.APP_TRACE);
      console.log("apex.debug", apex.debug);

      apex.jQuery(function () {
        apex.page.init(this, function () {
          try {
            (function () {
              console.log("init search: 10663688983655842");
            })();
            (function () {
              apex.jQuery("body").addClass("t-PageBody--leftNav");
            })();
          } catch (e) {
            apex.debug.error(e);
          }
          apex.item.waitForDelayLoadItems().done(function () {
            try {
              apex.theme42.initializePage.noSideCol();

              apex.page.warnOnUnsavedChanges();
            } finally {
              apex.event.trigger(apex.gPageContext$, "apexreadyend");
              window.dispatchEvent(new Event("apexready"));
            }
          });
        });
      });
    }
  </script>
  <script>
    var apex_img_dir = "\u002Fi\u002F";
    var apex = {
      env: {
        APP_USER: "ADMIN",
        APP_ID: "111",
        APP_PAGE_ID: "500",
        APP_SESSION: "3364513634026",
        APP_FILES:
          "r\u002Foffl_recipes\u002F111\u002Ffiles\u002Fstatic\u002Fv31\u002F",
        WORKSPACE_FILES:
          "r\u002Foffl_recipes\u002Ffiles\u002Fstatic\u002Fv1\u002F",
        APEX_VERSION: "23.2.0",
        APEX_BASE_VERSION: "23.2",
      },
      libVersions: {
        ckeditor5: "36.0.0",
        cropperJs: "1.5.13",
        domPurify: "3.0.5",
        fullcalendar: "6.1.8",
        hammer: "2.0.8",
        jquery: "3.6.4",
        jqueryUi: "1.13.2",
        maplibre: "2.4.0",
        markedJs: "5.1.2",
        prismJs: "1.29.0",
        oraclejet: "15.0.7",
        tinymce: "6.7.1",
        turndown: "7.1.1",
        monacoEditor: "0.32.1",
        lessJs: "4.1.3",
      },
    };
  </script>
  <script
    src="https://apex.oracle.com/i/libraries/jquery/3.6.4/jquery-3.6.4.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/core.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/debug.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/util.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/locale.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/lang.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/message.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/wwv_flow.js_messages?p_app_id=111&p_lang=en-us&p_version=23.2.0-56836979&p_builder=Y"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/date.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/storage.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/event.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/webComponent.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/region.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/item.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/binding.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/apex_5_0.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/navigation.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/server.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/page.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/widget.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/widget.util.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/clipboard.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/dynamic_actions_core.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/dynamic_actions.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/session.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/jquery-ui/1.13.2/jquery-ui-apex.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/actions.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/hammer/2.0.8/hammer-2.0.8.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/widget.checkbox.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/widget.checkboxAndRadio.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/item.Datepicker.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/widget.popupLov.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/widget.selectList.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/widget.textField.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/widget.textarea.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/widget.yesNo.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/widget.menu.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/widget.popup.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/widget.toggleCore.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/widget.collapsible.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/region.dynamicContent.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/tooltipManager.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/theme.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/pwa.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/legacy_pre18.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/libraries/apex/legacy_18.js?v=23.2.0"
  ></script>

  <script
    src="https://apex.oracle.com/i/libraries/apex/widget.stickyWidget.js?v=23.2.0"
  ></script>
  <script
    src="https://apex.oracle.com/i/themes/theme_42/23.2/js/theme42.js?v=23.2.0"
    onload="allLoaded()"
  ></script>
</div>

<style>
  @font-face {
    font-family: "Font APEX Small";
    src:
      url(https://static.oracle.com/cdn/apex/23.2.4/libraries/font-apex/2.2.1/fonts/Font-APEX-Small.woff2?)
        format("woff2"),
      url(https://static.oracle.com/cdn/apex/23.2.4/libraries/font-apex/2.2.1/fonts/Font-APEX-Small.woff?)
        format("woff");
    font-weight: 400;
    font-style: normal;
  }

  @font-face {
    font-family: "Font APEX Large";
    src:
      url(https://static.oracle.com/cdn/apex/23.2.4/libraries/font-apex/2.2.1/fonts/Font-APEX-Large.woff2?)
        format("woff2"),
      url(https://static.oracle.com/cdn/apex/23.2.4/libraries/font-apex/2.2.1/fonts/Font-APEX-Large.woff?)
        format("woff");
    font-weight: 400;
    font-style: normal;
  }
</style>
