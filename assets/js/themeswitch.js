if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
    activateDarkTheme()
}

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


    // lightSheet.media = '';
    darkSheet.media = 'none';
}

function activateDarkTheme() {
    const lightSheet = document.getElementById("sheet_light");
    const darkSheet = document.getElementById("sheet_dark");

    // lightSheet.media = 'none';
    darkSheet.media = '';
}