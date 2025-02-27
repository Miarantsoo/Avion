document.getElementById('toggleButton').addEventListener('click', function () {
    const linksContainer = document.getElementById('linksContainer');
    const computedStyle = window.getComputedStyle(linksContainer);
    const footer = document.querySelector('.footer');
    const buttonStyle = document.getElementsByClassName('menu-icons')[0];
    const menu = document.getElementById('menu');

    if (computedStyle.display === 'none' || computedStyle.maxHeight === '0px') {
        linksContainer.style.display = 'block';
        setTimeout(() => {
            footer.style.borderRadius = '50px 50px 0 0';
            linksContainer.classList.add('show');
        }, 100);
        buttonStyle.className = 'fa-solid fa-close menu-icons';
        menu.textContent = 'Close';
    } else {
        linksContainer.classList.remove('show');
        footer.style.borderRadius = '0 0 0 0';
        setTimeout(() => {
            linksContainer.style.display = 'none';
        }, 500);
        buttonStyle.className = 'fa-solid fa-bars menu-icons';
        menu.textContent = 'Menu';
    }
});

document.getElementsByClassName("footer")[0].addEventListener("mouseleave", function () {
    const linksContainer = document.getElementById('linksContainer');
    const computedStyle = window.getComputedStyle(linksContainer);
    const footer = document.querySelector('.footer');
    const buttonStyle = document.getElementsByClassName('menu-icons')[0];
    const menu = document.getElementById('menu');

    if (computedStyle.display !== 'none' || computedStyle.maxHeight !== '0px') {
        linksContainer.classList.remove('show');
        footer.style.borderRadius = '0 0 0 0';
        setTimeout(() => {
            linksContainer.style.display = 'none';
        }, 500);
        buttonStyle.className = 'fa-solid fa-bars menu-icons';
        menu.textContent = 'Menu';
    }
});

document.querySelectorAll('.toggle-flight').forEach(icon => {
    icon.addEventListener('click', () => {
        const details = icon.closest('.flight-info').querySelector('.flight-details');
        details.style.display = details.style.display === 'none' ? 'block' : 'none';
        icon.classList.toggle('fa-circle-plus');
        icon.classList.toggle('fa-circle-minus');
    });
});

function handleDateTimeOpacity() {
    const dateTimeInputs = document.querySelectorAll('input[type="datetime-local"]');
    dateTimeInputs.forEach((input) => {
        const setOpacity = () => {
            input.style.opacity = input.value ? '1' : '0.5';
        };
        setOpacity();
        input.addEventListener('input', setOpacity);
    });
}
handleDateTimeOpacity();
