(function () {
  "use strict";

  var SITE_ROOT = "/swiftui-theming/";
  var VERSIONS_URL = SITE_ROOT + "versions.json";

  function getCurrentVersion() {
    var path = window.location.pathname;

    if (path.startsWith(SITE_ROOT)) {
      var segment = path.substring(SITE_ROOT.length).split("/")[0];

      if (segment) {
        return segment;
      }
    }

    return "latest";
  }

  function createPicker(versions, currentVersion) {
    var container = document.createElement("div");
    container.className = "version-picker";

    var label = document.createElement("span");
    label.className = "version-picker-label";
    label.textContent = "Version";

    var select = document.createElement("select");
    select.className = "version-picker-select";
    select.setAttribute("aria-label", "Documentation version");

    versions.forEach(function (version) {
      var option = document.createElement("option");
      option.value = version.url;
      option.textContent = version.version;

      if (version.version === currentVersion) {
        option.selected = true;
      }

      select.appendChild(option);
    });

    select.addEventListener("change", function () {
      window.location.href = select.value;
    });

    container.appendChild(label);
    container.appendChild(select);

    return container;
  }

  function injectPicker(picker) {
    function tryInject() {
      var target = document.querySelector(".nav-content");

      if (!target) {
        target = document.querySelector("nav.nav");
      }

      if (!target) {
        target = document.querySelector("#app nav");
      }

      if (target && !target.querySelector(".version-picker")) {
        target.appendChild(picker);
        return true;
      }

      return false;
    }

    if (tryInject()) {
      return;
    }

    var observer = new MutationObserver(function (_, observer) {
      if (tryInject()) {
        observer.disconnect();
      }
    });

    observer.observe(document.body, {
      childList: true,
      subtree: true,
    });

    setTimeout(function () {
      observer.disconnect();

      if (!document.querySelector(".version-picker")) {
        document.body.insertBefore(picker, document.body.firstChild);
      }
    }, 5000);
  }

  var css = document.createElement("link");
  css.rel = "stylesheet";
  css.href = SITE_ROOT + "version-picker.css";
  document.head.appendChild(css);

  fetch(VERSIONS_URL)
    .then(function (response) {
      return response.json();
    })
    .then(function (versions) {
      if (versions.length <= 1) {
        return;
      }

      var currentVersion = getCurrentVersion();
      var picker = createPicker(versions, currentVersion);

      injectPicker(picker);
    })
    .catch(function (error) {
      console.warn("Version picker: could not load versions.json", error);
    });
})();
