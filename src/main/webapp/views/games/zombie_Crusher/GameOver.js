class GameOver extends Phaser.Scene {
    constructor() {
        super({ key: "GameOver" });
    }

    init(data) {
        this.finalScore = data.score || 0; // 🔥 Scene01에서 받은 점수 저장
    }

    create() {
        // 배경 설정 (선택 사항)
        this.add.rectangle(0, 0, this.cameras.main.width, this.cameras.main.height, 0x000000).setOrigin(0, 0);

        // "Game Over" 텍스트
        this.add.text(this.cameras.main.width / 2 - 100, this.cameras.main.height / 2 - 50, "GAME OVER", {
            fontSize: "40px",
            fill: "#ff0000",
        });

        // 최종 점수 표시
        this.add.text(this.cameras.main.width / 2 - 100, this.cameras.main.height / 2, "Final Score: " + this.finalScore, {
            fontSize: "32px",
            fill: "#ffffff",
        });

        // "Restart" 버튼
        let restartBtn = this.add.text(this.cameras.main.width / 2 - 50, this.cameras.main.height / 2 + 50, "RESTART", {
            fontSize: "32px",
            fill: "#00ff00",
            backgroundColor: "#000",
        }).setInteractive();

        // 버튼 클릭 시 게임 다시 시작
        restartBtn.on("pointerdown", () => {
            this.scene.start("Scene01"); // 🔥 Scene01 다시 시작
        });


        sendGameRecord(this.finalScore);
    }
}
