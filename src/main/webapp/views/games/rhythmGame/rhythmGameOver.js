
class rhythmGameOver extends Phaser.Scene{

  constructor(){
    super({key:"rhythmGameOver"});
    
  }

  init(data) {
    this.finalScore = data.score || 0;
    this.playTime = data.playTime || 0;
    this.formattedPlayTime = this.formatTime(this.playTime);
  }

  formatTime(ms) {
    let totalSeconds = Math.floor(ms / 1000);
    let minutes = Math.floor(totalSeconds / 60);
    let seconds = totalSeconds % 60;
    return minutes + '분 ' + seconds + '초';
  }

  preload(){
    
    this.load.spritesheet('myAnimation', 'background.png', {
      frameWidth: 960,
      frameHeight: 550,
      endFrame: 60 - 1
  });



  }

  create(){
    //배경설정
    
    this.anims.create({
      key: 'playAnimation',
      frames: this.anims.generateFrameNumbers('myAnimation', { start: 0, end: 60 - 1 }),
      frameRate: 10, // 원하는 속도로 조절
      repeat: -1     // 반복 재생
  });
    

    this.bg = this.add.sprite(-40, 0, 'myAnimation').setOrigin(0, 0).play('playAnimation');
    this.bg.setDisplaySize(this.scale.width+80, this.scale.height);

    // 게임 오버 메시지
    let gameOverText = this.add.text(this.scale.width / 2, this.scale.height / 2 - 100, 'Game Over', { fontSize: '50px', fill: '#f00' }).setOrigin(0.5);

    // 최종 점수 표시
    this.add.text(this.scale.width / 2, this.scale.height / 2 - 10, 'Score : ' + this.finalScore, { fontSize: '32px', fill: '#fff' }).setOrigin(0.5);

    // 총 플레이 시간
    this.add.text(this.scale.width / 2, this.scale.height / 2 + 50, 'Play Time: ' + this.formattedPlayTime, { fontSize: '25px', fill: '#fff' }).setOrigin(0.5);

    this.tweens.add({
      targets: gameOverText,
      scale: { from: 0.8, to: 1.2 },
      duration: 500,
      ease: 'Linear',
      yoyo: true,
      repeat: -1
    });

    // 다시 시작 버튼
    let restartButton = this.add.text(this.scale.width / 2, this.scale.height / 2 + 200, '다시 시작', { fontSize: '28px', fill: '#fff' }).setOrigin(0.5);
    restartButton.setInteractive();
    restartButton.on('pointerdown', () => {
      this.scene.start('rhythmStart');
    });
    restartButton.on("pointerover",()=>{
      restartButton.setColor("#000000");
      this.game.canvas.style.cursor = "pointer";
    })

    restartButton.on("pointerout",()=>{
      restartButton.setColor("#ffffff");
      this.game.canvas.style.cursor = "default";
    
    })

  }

  update(){
   

  }



}