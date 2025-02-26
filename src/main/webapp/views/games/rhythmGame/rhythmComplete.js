
class rhythmComplete extends Phaser.Scene{

  constructor(){
    super({key:"rhythmComplete"});
    
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

  this.load.image('complete','complete.png');

  // WebFont Loader 스크립트 로드
  this.load.script('webfont','https://ajax.googleapis.com/ajax/libs/webfont/1.6.26/webfont.js');

  }

  create(){
     // 커스텀 폰트 로드 및 사용
      WebFont.load({
      google: {
        families: ['Noto Sans KR'] // 원하는 폰트로 교체
      },
      active: () => {
    //배경설정
    
    this.anims.create({
      key: 'playAnimation',
      frames: this.anims.generateFrameNumbers('myAnimation', { start: 0, end: 60 - 1 }),
      frameRate: 10, // 원하는 속도로 조절
      repeat: -1     // 반복 재생
  });
    

    this.bg = this.add.sprite(-40, 0, 'myAnimation').setOrigin(0, 0).play('playAnimation');
    this.bg.setDisplaySize(this.scale.width+80, this.scale.height);

    this.add.image(180,20,"complete").setOrigin(0, 0).setDisplaySize(this.scale.width-350, this.scale.height-200);
    
    

    // 최종 점수 표시
    this.add.text(this.scale.width / 2, this.scale.height / 2 +80, 'Score : ' + this.finalScore, { fontSize: '32px', fill: '#fff' }).setOrigin(0.5);

    // 총 플레이 시간
    this.add.text(this.scale.width / 2, this.scale.height / 2 + 130, 'Play Time: ' + this.formattedPlayTime, { fontSize: '25px', fill: '#fff' }).setOrigin(0.5);

    

    // 다시 시작 버튼
    let restartButton = this.add.text(this.scale.width / 2, this.scale.height / 2 + 200, '다시 시작', { fontSize: '28px', fill: '#fff' }).setOrigin(0.5);
    restartButton.setInteractive();
    restartButton.on('pointerdown', () => {
      this.scene.start('rhythmStart');
    });
    restartButton.on("pointerover",()=>{
      restartButton.setColor("#000000");
      this.game.canvas.style.cursor = "pointer";
    });

    restartButton.on("pointerout",()=>{
      restartButton.setColor("#ffffff");
      this.game.canvas.style.cursor = "default";
    
    });
  }
  });
  }

  update(){


  }



}