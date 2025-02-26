class Barbecue extends Phaser.Scene {
    // 생성자
    constructor() {
        super({ key: 'Barbecue' }); // 장면 키 설정

        // 클래스 필드로 전역 변수 선언
        this.cookLevel = 0;  // 익힘 정도 (0: 생고기, 1: 중간, 2: 잘 익음)
        this.cookTimer = 0; // 고기 익힘 시간 추적
        this.isFlipped = false; // 고기 뒤집힘 상태
        this.isOnGrill = false;  // 불판 위 여부
        this.timeLeft = 10; // 제한 시간 (초)
        this.score = 0; // 점수
        this.meat = null; // 고기 스프라이트
        this.timerText = null; // 타이머 텍스트
        this.scoreText = null; // 점수 텍스트

        this.meatStatesFront = ["meat_raw_front", "meat_medium_front", "meat_well_done_front"];
        this.meatStatesBack = ["meat_raw_back", "meat_medium_back", "meat_well_done_back"];
    }

    preload() {
        this.load.image("background", "topview_background.jpg"); // 배경 이미지
        this.load.image('grill', 'grill.png');  // 불판 이미지
        this.load.image('plate1', 'plate1.png');  // 접시 이미지
        this.load.image('plate', 'plate.png');  // 접시 이미지
        this.load.image('meat', 'meat_raw.png');  // 생고기 이미지

        // 모든 고기 상태 이미지 로드
        this.load.image("meat_raw_front", "meat_raw_front.png");
        this.load.image("meat_medium_front", "meat_medium_front.png");
        this.load.image("meat_well_done_front", "meat_well_done_front.png");
        this.load.image("meat_raw_back", "meat_raw_back.png");
        this.load.image("meat_medium_back", "meat_medium_back.png");
        this.load.image("meat_well_done_back", "meat_well_done_back.png");

        this.load.audio('sizzlingSound', 'Sizzling.mp3'); // 고기굽기 효과음 파일 로드
    }

    create() {
        // 씬이 시작될 때마다 타이머 초기화
        this.timeLeft = 15;  // 여기에 추가
        this.score = 0;      // 점수도 초기화

        //게임시작 효과음 추가
        this.sizzlingSound = this.sound.add('sizzlingSound', {
            volume: 0.5,    // 볼륨 설정 (0~1)
            loop: false      // 반복 재생
        });

        const centerX = this.cameras.main.width / 2;
        const centerY = this.cameras.main.height / 2;

        // 배경 추가
        this.add.image(centerX, centerY, "background").setOrigin(0.5, 0.5).setScale(1);

        // 불판 추가
        let grill = this.add.image(centerX, centerY, 'grill').setScale(0.9).setOrigin(0.5, 0.5);

        // 접시 추가
        let plate = this.add.image(centerX + 330, centerY - 130, 'plate').setScale(0.31).setOrigin(0.5, 0.5);
        let plate1 = this.add.image(centerX - 330, centerY + 140, 'plate1').setScale(0.31).setOrigin(0.5, 0.5);

        // 제한 시간 표시
        this.timerText = this.add.text(50, 50, `시간: ${this.timeLeft}s`, { fontSize: '32px', fill: '#fff', padding: 10 })
            .setBackgroundColor('#000');

        // 점수 표시
        this.scoreText = this.add.text(50, 130, `점수: ${this.score}`, { fontSize: '32px', fill: '#fff', padding: 10 })
            .setBackgroundColor('#000');

        // 고기 추가 (초기 위치는 왼쪽)
        this.meat = this.add.sprite(150, 410, this.meatStatesFront[this.cookLevel])
            .setScale(0.3)
            .setInteractive({ draggable: true });

        // 고기 클릭 시 뒤집기
        this.meat.on("pointerdown", () => {
            this.isFlipped = !this.isFlipped; // 상태 반전 (앞면 ↔ 뒷면)
            if (this.isFlipped) {
                this.meat.setTexture(this.meatStatesBack[this.cookLevel]); // 뒷면 이미지 변경
                if (distanceToGrill < 100) {
                    this.sizzlingSound.play(); // 고기굽기 효과음 재생 시작
                }
            } else {
                this.meat.setTexture(this.meatStatesFront[this.cookLevel]); // 앞면 이미지 변경
                if (distanceToGrill < 100) {
                    this.sizzlingSound.play(); // 고기굽기 효과음 재생 시작
                }
            }
        });

        // 고기 드래그 기능
        this.input.setDraggable(this.meat);

        // 고기 드래그 이동
        this.input.on('drag', (pointer, gameObject, dragX, dragY) => {
            gameObject.x = dragX;
            gameObject.y = dragY;
        });

        // 고기 드래그 종료 시 처리
        this.input.on('dragend', (pointer, gameObject) => {
            let distanceToGrill = Phaser.Math.Distance.Between(gameObject.x, gameObject.y, grill.x, grill.y);
            let distanceToPlate = Phaser.Math.Distance.Between(gameObject.x, gameObject.y, plate.x, plate.y);

            if (distanceToGrill < 100) {
                this.isOnGrill = true; // 불판 위 상태로 변경
                this.sizzlingSound.play(); // 고기굽기 효과음 재생 시작
            } else {
                this.isOnGrill = false; // 불판에서 벗어나면 익히지 않음
            }

            if (distanceToPlate < 50) {
                if (this.cookLevel === 1) {
                    this.score += 100;
                } else {
                    this.score -= 50;
                }
                this.scoreText.setText(`점수: ${this.score}`);

                // 고기 초기화
                this.cookLevel = 0;
                this.isOnGrill = false;
                this.meat.setTexture(this.meatStatesFront[this.cookLevel]);
                this.meat.x = 150;
                this.meat.y = 410;
            }
        });

        // 제한 시간 타이머 (Arrow 함수 사용)
        this.time.addEvent({
            delay: 1000,
            loop: true,
            callback: () => {
                this.timeLeft -= 1;
                this.timerText.setText(`시간: ${this.timeLeft}s`);
                if (this.timeLeft <= 0) {
                    const data = {
                        score: this.score,
                    };
                    console.log(this.score); // 점수가 제대로 업데이트되는지 확인
                    sendGameRecord(this.score); //게임 스코어 DB 전달
                    this.scene.start('GameOver', { score: this.score }); // 씬 전환
                }
            },
            callbackScope: this // this 컨텍스트 명시
        });
    }

    update(time, delta) {
        if (this.isOnGrill) {
            this.cookTimer += delta; // 경과 시간 누적
            if (this.cookTimer >= 3000) { // 3초마다 익힘
                this.cookTimer = 0; // 타이머 리셋
                if (this.cookLevel < 2) { // 최대 익힘 단계까지만 증가
                    this.cookLevel++;
                    if (this.isFlipped) {
                        this.meat.setTexture(this.meatStatesBack[this.cookLevel]); // 뒤집힌 상태면 뒷면 이미지 변경
                    } else {
                        this.meat.setTexture(this.meatStatesFront[this.cookLevel]); // 앞면 이미지 변경
                    }
                }
            }
        }

    }
}
