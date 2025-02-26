class GamePlay extends Phaser.Scene {
    constructor() {
        super({ key: "GamePlay" });
        this.timeLimit = 60;
        this.tileSpeed = 1.5;
        this.speed = 46;
        this.frame = 0;
        this.cars = [];
        this.moveCooldown = false;
        this.gameOver = true;
        this.isGameInProgress = false;
        this.score = 0
    }

    preload() {
        this.load.image("player", "player.png");
        this.load.image("yellowCarR", "yellowCarR.png");
        this.load.image("redCarR", "redCarR.png");
        this.load.image("orangeCarL", "orangeCarL.png");
        this.load.image("whiteCarL", "whiteCarL.png");
        this.load.image("purpleCarR", "purpleCarR.png");
        this.load.image("grayCarR", "grayCarR.png");
        this.load.image("blueCarL", "blueCarL.png");
        this.load.image("greenCarL", "greenCarL.png");
        this.load.image("background", "background.jpg");
    }

    create() {

        

            // 시작 UI 추가
            const title = this.add.text(480, 150, "Cross Road", {
                fontSize: "64px",
                fill: "#000000",
                fontStyle: "bold",
                backgroundColor: "#ffffff",
                padding:{left:10, right:10, top:10, bottom:10}
            }).setOrigin(0.5).setDepth(1);;
    
            const description = this.add.text(480, 250, "도로를 건너 목적지에 도착하세요!\n제한시간: 60초", {
                fontSize: "24px",
                fill: "#000000",
                align: "center",
                backgroundColor: "#ffffff",
                padding:{left:10, right:10, top:10, bottom:10}
            }).setOrigin(0.5).setDepth(1);;
    
            const controls = this.add.text(480, 320, "조작법: 방향키 ← ↑ →", {
                fontSize: "20px",
                fill: "#000000",
                backgroundColor: "#ffffff",
                padding:{left:10, right:10, top:10, bottom:10}
            }).setOrigin(0.5).setDepth(1);;
    
            const startButton = this.add.text(480, 400, "게임 시작", {
                fontSize: "32px",
                fill: "#000000",
                backgroundColor: "#ffffff",
                padding: { left: 20, right: 20, top: 10, bottom: 10 }
            })
            .setOrigin(0.5).setDepth(1)
            .setInteractive();
    
            startButton.on("pointerover", () => {
                startButton.setBackgroundColor("#ff0000");
                startButton.setColor("#ffffff");
                this.game.canvas.style.cursor = "pointer";
            });
    
            startButton.on("pointerout", () => {
                startButton.setBackgroundColor("#ffffff");
                startButton.setColor("#000000");
                this.game.canvas.style.cursor = "default";
            });
    
            this.startUI = [title, description, controls, startButton];
    
            startButton.on("pointerdown", () => {
                this.startUI.forEach(element => element.destroy());
                this.gameOver = false;
            });
        
        this.input.keyboard.removeAllListeners();
        

        this.background = this.add.tileSprite(0, 0, 960, 550, "background").setOrigin(0, 0);
        this.timeText = this.add.text(10, 10, "Time: 0", { fontSize: "24px", fill: "#000" });

        this.player = this.physics.add.sprite(480, 480, "player").setScale(0.1);
        this.player.setCollideWorldBounds(true);
        this.player.setDepth(10);

        this.player.body.setSize(this.player.width * 0.5, this.player.height * 0.4);
        this.player.body.setOffset(this.player.width * 0.25, this.player.height * 0.5);

        this.cursor = this.input.keyboard.createCursorKeys();

        
        // 오른쪽 선 (충돌 시 차 제거)
        let cameraWidth = this.cameras.main.width;
        let cameraHeight = this.cameras.main.height;


        let rightBound = this.add.rectangle(1100, cameraHeight/2, 10, cameraHeight, 0xFFFFFF);
        
        this.physics.add.existing(rightBound, true);
        this.physics.add.collider(this.cars, rightBound, (car, rightBound)=>{
            car.destroy();
            this.cars.splice(this.cars.indexOf(car), 1);
        });

        // 왼쪽 선 (충돌 시 차 제거)
        let leftBound = this.add.rectangle(-150, cameraHeight/2, 10, cameraHeight, 0xFFFFFF);
        
        this.physics.add.existing(leftBound, true);
        this.physics.add.collider(this.cars, leftBound, (car, leftBound)=>{
            car.destroy();
            this.cars.splice(this.cars.indexOf(car), 1);
        });

  

        
        // Lane1 차 생성 이벤트
        this.time.addEvent({
            delay: 1200,
            callback: this.spawnCarInLane1,
            callbackScope: this,
            loop: true
        });
    
        // Lane2 차 생성 이벤트
        this.time.addEvent({
            delay: 1000,
            callback: this.spawnCarInLane2,
            callbackScope: this,
            loop: true
        });

        this.time.addEvent({
            delay: 1000,
            callback: this.spawnCarInLane3,
            callbackScope: this,
            loop: true
        });

        this.time.addEvent({
            delay: 1000,
            callback: this.spawnCarInLane4,
            callbackScope: this,
            loop: true
        });

        this.time.addEvent({
            delay: 900,
            callback: this.spawnCarInLane5,
            callbackScope: this,
            loop: true
        });
        this.time.addEvent({
            delay: 800,
            callback: this.spawnCarInLane6,
            callbackScope: this,
            loop: true
        });

        this.time.addEvent({
            delay: 800,
            callback: this.spawnCarInLane7,
            callbackScope: this,
            loop: true
        });
        this.time.addEvent({
            delay: 500,
            callback: this.spawnCarInLane8,
            callbackScope: this,
            loop: true
        });

        // 충돌 시 게임오버
        this.physics.add.collider(this.player, this.cars, () => {
			this.displayGameOverMessage();
        });

    }



    update() {
        if (this.gameOver) {
            return
        };

        this.frame++;

        if (this.frame % 60 === 0) {
            this.timeLimit--;
            this.timeText.setText("Time: " + this.timeLimit);
            if (this.timeLimit <= 0) {
                this.displayGameOverMessage();
            }
        }

        if (!this.moveCooldown) {
            if (this.cursor.left.isDown) {
                this.player.x -= this.speed;
                this.startCooldown();
            } else if (this.cursor.right.isDown) {
                this.player.x += this.speed;
                this.startCooldown();
            } else if (this.cursor.up.isDown) {
                this.player.y -= this.speed;
                this.startCooldown();
            }
        }

        if (this.player.y <= 20) {
            this.displaySuccessMessage();
        }

        // 아래쪽 이동 방지
        // if (this.player.y > 500) {
        //     this.player.y = 500;
        // }
    }

    startCooldown() {
        this.moveCooldown = true;
        this.time.delayedCall(150, () => {
            this.moveCooldown = false;
        });
    }

    spawnCarInLane1() {
        let y = 445; // 첫 번째 라인의 y-좌표
    
        let x = -50;
        let speed = 200; // 일정한 속도
    
        let car = this.physics.add.sprite(x, y, "yellowCarR").setScale(0.22);
        car.setVelocityX(speed);
        this.cars.push(car);
    }
    spawnCarInLane2() {
        let y = 400; // 두 번째 라인의 y-좌표
       
        let x = -50;
        let speed = 300; // 일정한 속도
    
        let car = this.physics.add.sprite(x, y, "redCarR").setScale(0.22);
        car.setVelocityX(speed);
        this.cars.push(car);
    }
    spawnCarInLane3() {
        let y = 350; 
    
        let x = 1000;
        let speed = -200;
    
        let car = this.physics.add.sprite(x, y, "orangeCarL").setScale(0.22);
        car.setVelocityX(speed);
        this.cars.push(car);
    }
    spawnCarInLane4() {
        let y = 300; 
    
        let x = 1000;
        let speed = -500;
    
        let car = this.physics.add.sprite(x, y, "whiteCarL").setScale(0.22);
        car.setVelocityX(speed);
        this.cars.push(car);
    }
    spawnCarInLane5() {
        let y = 215; 
    
        let x = -50;
        let speed = 400;
    
        let car = this.physics.add.sprite(x, y, "purpleCarR").setScale(0.22);
        car.setVelocityX(speed);
        this.cars.push(car);
    }
    spawnCarInLane6() {
        let y = 172; 
    
        let x = -50;
        let speed = 300;
    
        let car = this.physics.add.sprite(x, y, "grayCarR").setScale(0.22);
        car.setVelocityX(speed);
        this.cars.push(car);
    }
    spawnCarInLane7() {
        let y = 120; 
        let x = 1000;
        let speed = -500;
    
        let car = this.physics.add.sprite(x, y, "blueCarL").setScale(0.22);
        car.setVelocityX(speed);
        this.cars.push(car);
    }
    spawnCarInLane8() {
        let y = 75; 
    
        let x = 1000;
        let speed = -700;
    
        let car = this.physics.add.sprite(x, y, "greenCarL").setScale(0.22);
        car.setVelocityX(speed);
        this.cars.push(car);
    }

    displaySuccessMessage() {
        this.physics.pause()
        this.gameOver = true;
        this.input.keyboard.removeAllListeners();
        
        this.score = this.timeLimit * 10;
        
        // 게임 기록 전송
		sendGameRecord(this.score);
		//////////////

        this.add.text(480, 275, "Success!", {
            fontSize: "48px",
            fill: "#00FF00",
            backgroundColor: "#ffffff",
            padding:{left:10, right:10, top:10, bottom:10}
        }).setOrigin(0.5).setDepth(11);

        this.add.text(480, 320, "점수: " + this.score, {
            fontSize: "30px",
            fill: "#00FF00",
            backgroundColor: "#ffffff",
            padding:{left:10, right:10, top:10, bottom:10}
        }).setOrigin(0.5).setDepth(11);

        let restartBtn = this.add.text(this.cameras.main.width/2, 400, "REPLAY",{
            fontSize:'25px',
            padding:{left:10, right:10, top:10, bottom:10}
        }).setOrigin(0.5).setDepth(11).setInteractive();

        restartBtn.on("pointerover", ()=>{
            restartBtn.setBackgroundColor("#ff0000");
            this.game.canvas.style.cursor = "pointer";
        })

        restartBtn.on("pointerout", ()=>{
            restartBtn.setBackgroundColor("#000000");
            this.game.canvas.style.cursor = "default";
        })

        restartBtn.on("pointerdown", ()=>{
            this.timeLimit = 60;
            this.scene.restart();
        })
    }

    displayGameOverMessage(){
        this.physics.pause()
        this.gameOver = true;
        this.input.keyboard.removeAllListeners();

        this.score = 0;
        
        // 게임 기록 전송
		sendGameRecord(this.score);
		//////////////
	
        this.add.text(480, 275, "Game Over", {
            fontSize: "48px",
            fill: "#ffffff",
            backgroundColor: "#ff0000",
            padding:{left:10, right:10, top:10, bottom:10}
        }).setOrigin(0.5).setDepth(11);

        let restartBtn = this.add.text(this.cameras.main.width/2, this.cameras.main.height/2+60, "처음으로",{
            fontSize:'25px',
            padding:{left:10, right:10, top:10, bottom:10}
        }).setOrigin(0.5).setDepth(11).setInteractive();

        restartBtn.on("pointerover", ()=>{
            restartBtn.setBackgroundColor("#ff0000");
            this.game.canvas.style.cursor = "pointer";
        })

        restartBtn.on("pointerout", ()=>{
            restartBtn.setBackgroundColor("#000000");
            this.game.canvas.style.cursor = "default";
        })

        restartBtn.on("pointerdown", ()=>{
            this.timeLimit = 60;
            this.scene.restart();
        })
    }
    
}