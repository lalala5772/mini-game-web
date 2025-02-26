class TutorialScene extends Phaser.Scene {
    constructor() {
        super({ key: 'TutorialScene' });
    }

    preload() {
        this.load.image("bg2", "bg2.jpg"); // 배경 이미지
        this.load.audio('startSound', 'KeyboardKey.mp3'); // 게임시작 효과음 파일 로드
    }

    create() {
        //게임시작 효과음 추가
        this.startSound = this.sound.add('startSound', {
            volume: 0.5,    // 볼륨 설정 (0~1)
            loop: false      // 반복 재생
        });

        const centerX = this.cameras.main.width / 2;
        const centerY = this.cameras.main.height / 2;

        // 배경 추가
        this.add.image(centerX, centerY, "bg2").setOrigin(0.5, 0.5).setScale(1);

        // 반투명 오버레이 배경
        let background = this.add.rectangle(80, 50, 800, 450, 0xCCCCCC, 0.8);
        background.setOrigin(0, 0);

        // 제목 추가
        const title = this.add.text(480, 80, '게임 방법', {
            fontSize: '48px',
            fontFamily: 'Arial',
            color: '#8B4513',
            fontWeight: 'bold'
        }).setOrigin(0.5);

        // 설명 텍스트 스타일
        const textStyle = {
            fontSize: '22px',
            fontFamily: 'Arial',
            color: '#4A4A4A',
            lineSpacing: 8,
            wordWrap: { width: 700 }
        };

        // 게임 설명 텍스트
        const instructions = [
            '1. 고기를 선택한 후, 마우스로 드래그하여 불판 위에 올려놓습니다.',
            '2. 고기의 익힘 정도를 파악하여 적절한 타이밍에 뒤집어줍니다.',
            '3. 익은 고기는 오른쪽 접시에 놓습니다.',
            '4. 제한 시간 내에 최대한 많은 고기를 구워서 높은 점수를 얻는 것이\n   목표입니다.',
            '5. 고기를 태우면 점수가 깎이므로 주의해야 합니다.'
        ];

        // 설명 텍스트 추가
        let yPosition = 160;
        instructions.forEach((text, index) => {
            this.add.text(120, yPosition, text, textStyle);
            yPosition += 60; // 줄 간격 조정
        });

        // 시작 버튼 생성
        const buttonWidth = 200;
        const buttonHeight = 60;
        const button = this.add.graphics();
        button.fillStyle(0xcd853f);
        button.fillRoundedRect(centerX - buttonWidth / 2, 460, buttonWidth, buttonHeight, 15);

        // 시작 버튼 텍스트
        const startText = this.add.text(480, 490, '게임 시작', {
            fontSize: '32px',
            fontFamily: 'Arial',
            color: '#FFFFFF'
        }).setOrigin(0.5);

        // 버튼 상호작용 영역
        const buttonZone = this.add.zone(480, 490, buttonWidth, buttonHeight);
        buttonZone.setOrigin(0.5); // 중심을 기준으로 크기 조정
        buttonZone.setInteractive({ useHandCursor: true }); // 마우스 오버 시 커서 변경

        // 버튼 호버 효과
        buttonZone.on('pointerover', () => {
            button.clear();
            button.fillStyle(0xdeb887);
            button.fillRoundedRect(centerX - buttonWidth / 2, 460, buttonWidth, buttonHeight, 15);
        });

        buttonZone.on('pointerout', () => {
            button.clear();
            button.fillStyle(0xcd853f);
            button.fillRoundedRect(centerX - buttonWidth / 2, 460, buttonWidth, buttonHeight, 15);
        });

        // 버튼 클릭 이벤트
        buttonZone.on('pointerdown', () => {
            this.startSound.play(); // 시작 버튼 효과음 재생
            this.scene.start('Barbecue');
        });

    }

}