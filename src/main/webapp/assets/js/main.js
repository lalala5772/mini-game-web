document.addEventListener("DOMContentLoaded", function () {

    // Particle Background
    const canvas = document.getElementById('particle-canvas');
    const ctx = canvas.getContext('2d');

    let w, h;

    const setCanvasExtents = () => {
        w = document.body.clientWidth;
        h = document.body.clientHeight;
        canvas.width = w;
        canvas.height = h;
    };

    setCanvasExtents();
    window.onresize = setCanvasExtents;

    const makeStars = count => {
        const out = [];
        for (let i = 0; i < count; i++) {
            const s = {
                x: Math.random() * w,
                y: Math.random() * h,
                z: Math.random() * 1000
            };
            out.push(s);
        }
        return out;
    };

    let stars = makeStars(2000);

    const clear = () => {
        ctx.fillStyle = 'black';
        ctx.fillRect(0, 0, canvas.width, canvas.height);
    };

    const putPixel = (x, y, brightness) => {
        const intensity = brightness * 255;
        const rgb = `rgb(${intensity},${intensity},${intensity})`;
        ctx.fillStyle = rgb;
        ctx.fillRect(x, y, 1, 1);
    };

    const moveStars = distance => {
        const count = stars.length;
        for (var i = 0; i < count; i++) {
            const s = stars[i];
            s.z -= distance;
            while (s.z <= 1) {
                s.z += 1000;
            }
        }
    };

    let prevTime;
    const init = time => {
        prevTime = time;
        requestAnimationFrame(tick);
    };

    const tick = time => {
        let elapsed = time - prevTime;
        prevTime = time;

        moveStars(elapsed * 0.1);

        clear();

        const cx = w / 2;
        const cy = h / 2;

        const count = stars.length;
        for (var i = 0; i < count; i++) {
            const star = stars[i];

            const x = cx + star.x / (star.z * 0.001);
            const y = cy + star.y / (star.z * 0.001);

            if (x < 0 || x >= w || y < 0 || y >= h) {
                continue;
            }

            const d = star.z / 1000.0;
            const b = 1 - d * d;

            putPixel(x, y, b);
        }

        requestAnimationFrame(tick);
    };

    // GSAP Animations
    gsap.registerPlugin(ScrollTrigger);

    // 첫 번째 섹션 애니메이션
    gsap.from(".vertical-line", {
        scrollTrigger: {
            trigger: ".first-section",
            start: "top 80%",
            toggleActions: "play none none reverse"
        },
        height: 0,
        duration: 1,
        ease: "power2.out"
    });
    
    gsap.from(".quote", {
        scrollTrigger: {
            trigger: ".first-section",
            start: "top 80%",
            toggleActions: "play none none reverse"
        },
        opacity: 0,
        y: 50,
        duration: 1,
        delay: 0.5,
        ease: "power2.out"
    });

    // TECH X 텍스트 애니메이션
    gsap.to(".techx-text", {
        scrollTrigger: {
            trigger: ".techx-section",
            start: "top center",
            toggleActions: "play none none reverse"
        },
        scale: 1,
        opacity: 1,
        duration: 0.5,
        ease: "power4.out"
    });

    // 설명 텍스트 애니메이션
    gsap.to(".description", {
        scrollTrigger: {
            trigger: ".techx-section",
            start: "top center",
            toggleActions: "play none none reverse"
        },
        opacity: 1,
        duration: 0.5,
        delay: 0.3,
        ease: "power2.out"
    });

    // Start particle animation
    requestAnimationFrame(init);


});