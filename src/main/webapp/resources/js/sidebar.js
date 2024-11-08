document.addEventListener("DOMContentLoaded", function() {
    const links = document.querySelectorAll('.side-nav-link');
    const currentPath = window.location.pathname;

    links.forEach(link => {
        // 현재 URL이 링크의 href와 일치하는지 확인하여 active 클래스 추가
        if (link.getAttribute('href') === currentPath) {
            link.classList.add('active');
        }
    });
});
