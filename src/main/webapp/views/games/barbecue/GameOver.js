class GameOver extends Phaser.Scene {
    constructor() {
        super({ key: "GameOver" });
    }

    preload() {
        this.load.audio('startSound', 'KeyboardKey.mp3'); // 게임시작 효과음 파일 로드
        this.load.audio('clappingSound', 'Clapping.mp3'); // 박수 소리 파일 로드
    }

    create(data) {
        //게임시작 효과음 추가
        this.startSound = this.sound.add('startSound', {
            volume: 0.5,    // 볼륨 설정 (0~1)
            loop: false      // 반복 재생
        });

        //박수 효과음 추가
        this.clappingSound = this.sound.add('clappingSound', {
            volume: 0.5,    // 볼륨 설정 (0~1)
            loop: false      // 반복 재생
        });
        this.clappingSound.play(); // 음악 재생 시작

        const centerX = this.cameras.main.width / 2;
        const centerY = this.cameras.main.height / 2;

        // data가 존재하면 그 값을 사용하고, 없으면 0을 기본값으로 사용
        const score = data ? data.score : 0;

        const gameOverText = this.add.text(centerX, centerY - 100, '게임 종료! 🎉', {
            fontSize: '64px',
            fill: '#fff',
            align: 'center',
            lineHeight: 1.2,
            padding: { top: 8, bottom: 8 }
        }).setOrigin(0.5);

        const scoreText = this.add.text(centerX, centerY, `점수: ${score}`, {
            fontSize: '32px',
            fill: '#fff',
            align: 'center',
            lineHeight: 1.2,
            padding: { top: 8, bottom: 8 }
        }).setOrigin(0.5);

        const restartText = this.add.text(centerX, centerY + 100, '다시 시작하려면 클릭하세요 🔄', {
            fontSize: '32px',
            fill: '#fff',
            align: 'center',
            lineHeight: 1.2,
            padding: { top: 8, bottom: 8 }
        }).setOrigin(0.5).setInteractive({ useHandCursor: true });

        restartText.on('pointerdown', () => {
            this.clappingSound.stop(); // 배경 음악 정지
            this.scene.start('Start', data);
        });
    }
}
