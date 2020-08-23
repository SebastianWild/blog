document.addEventListener('DOMContentLoaded', function(event) {
    if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
        // the default theme is light, so no need to check for it
        activateDarkTheme()
    }
})

window.matchMedia('(prefers-color-scheme: dark)').addListener(function (e) {
    const newColorScheme = e.matches ? "dark" : "light";

    switch(newColorScheme) {
        case "light":
            activateLightTheme();
            break;
        case "dark":
            activateDarkTheme();
            break;
        default:
            break;
    }
});

function activateLightTheme() {
    const lightSheet = document.getElementById("sheet_light");
    const darkSheet = document.getElementById("sheet_dark");
    const body = document.getElementsByTagName("BODY")[0];


    // lightSheet.media = '';
    darkSheet.media = 'none';
    body.classList.replace("theme--dark", "theme--light");
}

function activateDarkTheme() {
    const lightSheet = document.getElementById("sheet_light");
    const darkSheet = document.getElementById("sheet_dark");
    const body = document.getElementsByTagName("BODY")[0];

    // lightSheet.media = 'none';
    darkSheet.media = '';
    body.classList.replace("theme--light", "theme--dark");
}