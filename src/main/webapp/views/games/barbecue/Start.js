class Start extends Phaser.Scene {
    constructor() {
        super({ key: "Start" });
    }

    preload() {
        this.load.image("bg", "bg.jpg"); // 배경 이미지

        this.load.audio('bgMusic', 'BackStep.mp3'); // 음악 파일 로드
        this.load.audio('startSound', 'KeyboardKey.mp3'); // 게임시작 효과음 파일 로드
    }

    create() {
        // 배경 음악 추가 및 설정
        this.bgMusic = this.sound.add('bgMusic', {
            volume: 0.5,    // 볼륨 설정 (0~1)
            loop: true      // 반복 재생
        });
        this.bgMusic.play(); // 음악 재생 시작

        //게임시작 효과음 추가
        this.startSound = this.sound.add('startSound', {
            volume: 0.5,    // 볼륨 설정 (0~1)
            loop: false      // 반복 재생
        });

        const centerX = this.cameras.main.width / 2;
        const centerY = this.cameras.main.height / 2;

        // 배경 추가
        this.add.image(centerX, centerY, "bg").setOrigin(0.5, 0.5).setScale(1);


        // 게임 제목
        const title = this.add.text(centerX, centerY - 125, 'Barbecue Game', {
            fontSize: '64px',
            fontFamily: 'Arial',
            color: '#111',
            fontWeight: 'bold'
        });
        title.setOrigin(0.5);

        const fullText = '고기 먹을 시간이에요~ 냠냠';
        let currentText = '';
        let index = 0;

        const subtitle = this.add.text(centerX, centerY - 45, '', {
            fontSize: '33px',
            fontFamily: 'Arial',
            color: '#111',
            fontWeight: 'bold'
        });
        subtitle.setOrigin(0.5);

        // 한 글자씩 추가하는 타이머 이벤트
        this.time.addEvent({
            delay: 100, // 글자가 나오는 속도 (100ms마다 한 글자 추가)
            repeat: fullText.length - 1, // 글자 수만큼 반복
            callback: () => {
                currentText += fullText[index];
                subtitle.setText(currentText); // 텍스트 갱신
                index++;
            }
        });

        // 시작 버튼 배경
        const buttonWidth = 200;
        const buttonHeight = 60;
        const button = this.add.graphics();
        button.fillStyle(0xcd853f);
        button.fillRoundedRect(centerX - buttonWidth / 2, centerY + 25, buttonWidth, buttonHeight, 15);

        // 시작 버튼 텍스트
        const startText = this.add.text(centerX, centerY + 55, '게임 시작', {
            fontSize: '32px',
            fontFamily: 'Arial',
            color: '#FFFFFF'
        });
        startText.setOrigin(0.5);

        // 버튼 상호작용 추가
        const buttonZone = this.add.zone(centerX, centerY + 55, buttonWidth, buttonHeight);
        buttonZone.setOrigin(0.5); // 중심을 기준으로 크기 조정
        buttonZone.setInteractive({ useHandCursor: true }); // 마우스 오버 시 커서 변경

        // 마우스 오버 효과
        buttonZone.on('pointerover', () => {
            button.clear();
            button.fillStyle(0xdeb887);
            button.fillRoundedRect(centerX - buttonWidth / 2, centerY + 25, buttonWidth, buttonHeight, 15);
        });

        // 마우스 아웃 효과
        buttonZone.on('pointerout', () => {
            button.clear();
            button.fillStyle(0xcd853f);
            button.fillRoundedRect(centerX - buttonWidth / 2, centerY + 25, buttonWidth, buttonHeight, 15);
        });

        // 버튼 클릭 시 배경음악 정지 후 씬 전환
        buttonZone.on('pointerdown', () => {
            this.startSound.play(); // 시작 버튼 효과음 재생
            this.bgMusic.stop(); // 배경 음악 정지
            this.scene.start('TutorialScene');
        });
    }


    update() { }
}