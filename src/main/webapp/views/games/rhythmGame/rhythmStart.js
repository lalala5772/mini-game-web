
class rhythmStart extends Phaser.Scene{

  constructor(){
    super({key:"rhythmStart"});
    
  }

  preload(){
    
    this.load.spritesheet('myAnimation', 'background.png', {
      frameWidth: 960,
      frameHeight: 550,
      endFrame: 60 - 1
  });

  this.load.image('startlogo','startLogo.png');

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

    this.add.image(180,80,"startlogo").setOrigin(0, 0);

    let startBtn = this.add.text(this.cameras.main.width/2,this.cameras.main.height/2+150,"게임 시작",{
      fontSize : "25px",
      padding:{left:10,right:10,top:10,bottom:10}
    }).setOrigin(0.5).setInteractive();

    startBtn.on("pointerover",()=>{
      startBtn.setColor("#000000");
      this.game.canvas.style.cursor = "pointer";
    })

    startBtn.on("pointerout",()=>{
      startBtn.setColor("#ffffff");
      this.game.canvas.style.cursor = "default";
    
    })

    startBtn.on("pointerdown",()=>{

      this.scene.start("rhythmMain");
    })

  }

  update(){
   

  }



}