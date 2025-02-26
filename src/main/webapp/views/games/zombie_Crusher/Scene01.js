class Scene01 extends Phaser.Scene {
    constructor() {
        super({ key: "Scene01" });
        this.spawnTimer = 0;  // 적 스폰 타이머
        this.score = 0; // 스코어
        this.playtime = 0; // 플레이 타임
        this.maxenemies = 200; // 최대 적 수 제한
    };

    preload() {
        this.load.image("bg", "img/background.png");
        this.load.spritesheet("player", "img/player.png", { frameWidth: 480 / 8, frameHeight: 240 / 4 });
        this.load.spritesheet("enemy", "img/enemy.png", { frameWidth: 1200 / 6, frameHeight: 308 });
        this.load.spritesheet("stone", "img/blade.png", { frameWidth: 360, frameHeight: 360 });


    };

    create() {
        // 배경 생성
        this.bg = this.add.tileSprite(0, 0, 1024, 1024, "bg");
        this.bg.setOrigin(0, 0);

        // 플레이어 생성
        this.player = this.physics.add.sprite(this.cameras.main.width / 2, this.cameras.main.height / 2, "player");
        this.player.setCollideWorldBounds(true);



        // 적 그룹 생성
        this.enemy = this.physics.add.group({maxSize : this.maxenemies});

        // 카메라 설정 (배경 크기 이상으로 이동하지 않음)
        this.cameras.main.setBounds(0, 0, 1024, 1024);
        this.physics.world.setBounds(0, 0, 1024, 1024);
        this.cameras.main.startFollow(this.player);

        // 키 입력 설정
        this.cursors = this.input.keyboard.createCursorKeys();

        this.input.keyboard.on("keydown-SPACE", () => {
            this.throwStone();
        });

        // 적 걸어오는 모션
        this.anims.create({
            key: "enemymove",
            frames: this.anims.generateFrameNumbers("enemy", { start: 0, end: 7 }),
            frameRate: 3,
            repeat: -1
        })

        // 플레이어 우측 움직임
        this.anims.create({
            key: "playerright",
            frames: this.anims.generateFrameNumbers("player", { start: 16, end: 23 }),
            frameRate: 3,
            repeat: -1
        })

        // 플레이어 좌측 움직임
        this.anims.create({
            key: "playerleft",
            frames: this.anims.generateFrameNumbers("player", { start: 8, end: 17 }),
            frameRate: 3,
            repeat: -1
        })

        // 플레이어 위 움직임
        this.anims.create({
            key: "playerup",
            frames: this.anims.generateFrameNumbers("player", { start: 24, end: 31 }),
            frameRate: 3,
            repeat: -1
        })

        // 플레이어 아래 움직임
        this.anims.create({
            key: "playerdown",
            frames: this.anims.generateFrameNumbers("player", { start: 0, end: 7 }),
            frameRate: 3,
            repeat: -1
        })

        this.scoreText = this.add.text(20, 20, "Score : 0", {
            fontSize: "24px",
            fill: "#fff",
        }).setScrollFactor(0);
        this.timeText = this.add.text(20, 50, "Time: 0s", {
            fontSize: "24px",
            fill: "#fff",
        }).setScrollFactor(0);
        this.time.addEvent({
            delay: 1000,
            callback: () => {
                this.playtime++;
                this.timeText.setText("Time: " + this.playtime + "s");
            },
            callbackScope: this,
            loop: true
        });

        this.physics.add.overlap(this.player, this.enemy, this.onPlayerHit, null, this);


    };

    update(time, delta) {
        this.player.setVelocity(0);
        const speed = 200;

        let moving = false;

        // 플레이어 이동
        if (this.cursors.left.isDown) {
            this.player.setVelocityX(-speed);
            this.player.anims.play("playerleft", true);
            moving = true;

        } else if (this.cursors.right.isDown) {
            this.player.setVelocityX(speed);
            this.player.anims.play("playerright", true);
            moving = true;
        }
        if (this.cursors.up.isDown) {
            this.player.setVelocityY(-speed);
            this.player.anims.play("playerup", true);
            moving = true;

        } else if (this.cursors.down.isDown) {
            this.player.setVelocityY(speed);
            this.player.anims.play("playerdown", true);
            moving = true;

        }


        // 적 스폰 타이머
        this.spawnTimer += delta;

        // 적 개수 제한
        if (this.enemy.getChildren().length < this.maxenemies) {
            if (this.spawnTimer > this.spawnTime) {
                this.spawnEnemy();
                this.spawnTimer = 0;
            }
    
        }

        if (this.playtime > 20) {
            this.spawnTime = 50;
        } else if (this.playtime > 15) {
            this.spawnTime = 100;
        } else if (this.playtime > 10) {
            this.spawnTime = 200;
        } else if (this.playtime > 5) {
            this.spawnTime = 500;
        } else {
            this.spawnTime = 2000; // 초기 값
        }

        


        // 적이 플레이어를 따라 움직이도록 설정
        this.enemy.getChildren().forEach((enemy) => {
            this.physics.moveToObject(enemy, this.player, enemy.speed);
        });
    };
    findClosestEnemy() {
        let closestEnemy = null;
        let minDistance = Infinity;

        this.enemy.getChildren().forEach((enemy) => {
            let distance = Phaser.Math.Distance.Between(this.player.x, this.player.y, enemy.x, enemy.y);
            if (distance < minDistance) {
                minDistance = distance;
                closestEnemy = enemy;
            }
        });

        return closestEnemy;
    }

    // 적과 충돌 시 게임 종료
    onPlayerHit(player, enemy) {
        this.scene.start("GameOver", { score: this.score });
    }

    


    throwStone() {
        let targetEnemy = this.findClosestEnemy();

        if (!targetEnemy) return;

        let stone = this.physics.add.sprite(this.player.x, this.player.y, "stone");
        stone.setScale(0.1);

        let speed = 300;
        this.physics.moveToObject(stone, targetEnemy, speed);

        this.physics.add.overlap(stone, this.enemy, this.hitEnemy, null, this);
    }
    hitEnemy(stone, enemy) {
        enemy.destroy();
        stone.destroy();
        this.score += 1;
        this.scoreText.setText("Score: " + this.score);
    }


    // 적 생성 함수 (전역 함수에서 클래스 메서드로 변경)
    spawnEnemy() {
        let spawnEdge = Phaser.Math.Between(1, 4);
        let x, y;

        if (spawnEdge === 1) { // 위쪽
            x = Phaser.Math.Between(0, this.scale.width);
            y = 0;
        } else if (spawnEdge === 2) { // 아래쪽
            x = Phaser.Math.Between(0, this.scale.width);
            y = this.scale.height;
        } else if (spawnEdge === 3) { // 왼쪽
            x = 0;
            y = Phaser.Math.Between(0, this.scale.height);
        } else { // 오른쪽
            x = this.scale.width;
            y = Phaser.Math.Between(0, this.scale.height);
        }
        // 적 생성
        let enemy = this.enemy.create(x, y, "enemy");
        this.textures.get("enemy").setFilter(Phaser.Textures.FilterMode.LINEAR);
        enemy.setScale(0.3);
        enemy.speed = Phaser.Math.Between(50, 100);
        enemy.setCollideWorldBounds(true);

        enemy.anims.play("enemymove");


    }
}
