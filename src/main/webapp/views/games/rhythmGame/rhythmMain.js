
class rhythmMain extends Phaser.Scene{

  constructor(){
    super({key:"rhythmMain"});
    this.tracks = [];      // 4개의 트랙
    this.notes = [];       // 떨어지는 노트들
    this.speed = 200;      // 노트 떨어지는 속도
    this.spawnInterval = 1000; // 노트 생성 간격 (밀리초)
    
    
    this.score;
    this.playTime;
  }

  

  preload(){
    
    this.load.spritesheet('myAnimation', 'background.png', {
      frameWidth: 960,
      frameHeight: 550,
      endFrame: 60 - 1
  });

  this.load.image('trackBackground', 'trackBackground.png');

  // 배경음악 파일 로드
  this.load.audio('music', 'music.mp3');

  this.load.image('notebar', 'notebar.png');

  this.load.image('note1', 'note1.png');
  

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

    // 배경음악 추가
    this.music = this.sound.add('music');

    // 배경음악 재생 및 루프 설정
    this.music.play({ loop: false });

    // 배경음악이 끝났을 때 이벤트 처리
    this.music.on('complete', this.onMusicComplete, this);

    // 배경음악 음량 설정 (선택사항)
    this.music.setVolume(0.5); // 0.0 ~ 1.0 사이 값으로 음량 조절
    this.score = 0;
    this.playTime = 0;
    this.isWarning = false;
    this.maxMissCount = 5;
    this.missCount = 0;
    // 미스 카운트 표시
    this.missText = this.add.text(10, 40, 'Miss : 0 / ' + this.maxMissCount, { fontSize: '24px', fill: '#fff' });
    // 시간 표시
    this.playTime = 0;

    this.timeText = this.add.text(10, 70, '시간: 0초', { fontSize: '24px', fill: '#fff' });
      // 4개의 트랙 생성
      this.createTracks();
  
      // 입력 키 설정
      this.cursors = this.input.keyboard.addKeys({
        key1: Phaser.Input.Keyboard.KeyCodes.D,
        key2: Phaser.Input.Keyboard.KeyCodes.F,
        key3: Phaser.Input.Keyboard.KeyCodes.J,
        key4: Phaser.Input.Keyboard.KeyCodes.K,
      });
  
      // 노트 생성 타이머 설정
      this.noteTimer = this.time.addEvent({
        delay: this.spawnInterval,
        callback: this.spawnNote,
        callbackScope: this,
        loop: true
      });
  
      // 점수 표시
      this.score = 0;
      this.scoreText = this.add.text(10, 10, '점수: 0', { fontSize: '24px', fill: '#fff' });

      this.judgementLine = this.add.image(this.scale.width / 2, this.scale.height - 50, 'notebar').setOrigin(0.5);
      this.judgementLine.setDepth(3); // 노트보다 앞에 오도록 깊이 설정
      this.judgementLine.setDisplaySize(this.scale.width+45, 80);
      
      // 노트를 맞췄을 때 판정선 반짝임 효과
      this.tweens.add({
      targets: this.judgementLine,
      alpha: { from: 1, to: 0.5 },
      duration: 200,
      yoyo: true,
      });

      
  }

  update(time, delta) {
    // 노트 이동
    this.moveNotes(delta);

    // 플레이어 입력 처리
    this.handleInput();

  // 플레이 시간 업데이트
  this.playTime += delta;
  let formattedTime = this.formatTime(this.playTime);
  this.timeText.setText('시간: ' + formattedTime);
  }

  formatTime(ms) {
    let totalSeconds = Math.floor(ms / 1000);
    let minutes = Math.floor(totalSeconds / 60);
    let seconds = totalSeconds % 60;
    return minutes + '분 ' + seconds + '초';
  }

 

  createTracks() {
    let trackWidth = this.scale.width / 4;
    for (let i = 0; i < 4; i++) {
        let x = trackWidth * i + trackWidth / 2;
        let track = this.add.image(x, this.scale.height / 2, 'trackBackground').setOrigin(0.5);
        track.displayWidth = trackWidth - 10; // 트랙의 너비 조절
        track.displayHeight = this.scale.height; // 트랙의 높이 조절
        track.setDepth(1); // 트랙의 깊이 설정
        this.tracks.push(track);
    }

    for (let i = 1; i < 4; i++) {
      let x = (this.scale.width / 4) * i;
      let line = this.add.line(0, 0, x, 0, x, this.scale.height-75, 0x000020).setOrigin(0);
      line.setDepth(3); // 노트보다 앞에 오도록
  }
}
spawnNote() {
  let trackIndex = Phaser.Math.Between(0, 3);
  this.spawnNoteAt(trackIndex);

  
}

spawnNoteAt(trackIndex) {
  let track = this.tracks[trackIndex];
  let note = this.add.sprite(track.x, 0, 'note1').setOrigin(0.5);
  note.setScale(1,0.6);
  this.physics.add.existing(note);
  note.body.setVelocityY(this.speed);
  note.trackIndex = trackIndex;
  note.setDepth(2); // 노트의 깊이 설정 (트랙보다 앞에 오도록)
  this.notes.push(note);
  
}


  moveNotes(delta) {
    for (let i = this.notes.length - 1; i >= 0; i--) {
      let note = this.notes[i];
      if (note.y > this.scale.height) {
        // 노트가 화면 아래로 벗어나면 제거
        note.destroy();
        this.notes.splice(i, 1);

        // 미스 카운트 증가
        this.missCount++;
        this.missText.setText('Miss : ' + this.missCount + ' / ' + this.maxMissCount);

        // **경고 상태 체크**
      if (this.missCount >= this.maxMissCount - 2 && !this.isWarning) {
        this.activateWarning();
      }

        // 미스 카운트가 최대치를 넘으면 게임 오버 처리
        if (this.missCount >= this.maxMissCount) {
          this.gameOver();
          return;
        }
      }
    }
  }

  activateWarning() {
    this.isWarning = true;
  
    // 화면 주위에 붉은 테두리 추가
    this.warningBorder = this.add.rectangle(this.scale.width / 2, this.scale.height / 2, this.scale.width, this.scale.height);
    this.warningBorder.setStrokeStyle(5, 0xff0000); // 빨간색 테두리, 두께 5
    this.warningBorder.setDepth(5); // 가장 앞에 보이도록 깊이 설정
  
    // 테두리 깜박이는 효과 추가
    this.tweens.add({
      targets: this.warningBorder,
      alpha: { from: 1, to: 0 },
      ease: 'Linear',
      duration: 500,
      yoyo: true,
      repeat: -1 // 무한 반복
    });
  
    // 경고 메시지 추가
    this.warningText = this.add.text(this.scale.width / 2, 100, 'Waring!!', { fontSize: '40px', fill: '#ff0000' }).setOrigin(0.5);
    this.warningText.setDepth(5);
  
    // 메시지 깜박이는 효과 추가
    this.tweens.add({
      targets: this.warningText,
      alpha: { from: 1, to: 0 },
      ease: 'Linear',
      duration: 500,
      yoyo: true,
      repeat: -1
    });
  }

  

  


  handleInput() {
    let keys = [this.cursors.key1, this.cursors.key2, this.cursors.key3, this.cursors.key4];
    for (let i = 0; i < keys.length; i++) {
      if (Phaser.Input.Keyboard.JustDown(keys[i])) {
        this.checkHit(i);
      }
    }
  }

  checkHit(trackIndex) {
    // 해당 트랙에 가장 가까운 노트 찾기
    for (let i = 0; i < this.notes.length; i++) {
      let note = this.notes[i];
      if (note.trackIndex === trackIndex) {
        let distance = Math.abs(note.y - (this.scale.height - 50)); // 키 입력 판정 위치
        if (distance < 30) {
          // 정확한 타이밍에 맞췄을 때
          
          note.destroy();
          this.notes.splice(i, 1);
          this.score += 2;
          this.scoreText.setText('점수: ' + this.score);
          return;
        }
      }
     
    }
    
  
  

    
    // 미스 처리
    
    this.scoreText.setText('점수: ' + this.score);

    
  }

  onMusicComplete() {
    // 게임 종료 처리
    sendGameRecord(this.score);
    this.scene.start('rhythmComplete', { score: this.score, playTime: this.playTime });
  }


  gameOver(){
    // GameOverScene으로 데이터 전달
    if (this.music) {
      this.music.stop();
    }
  sendGameRecord(this.score);
  this.scene.start('rhythmGameOver', { score: this.score, playTime: this.playTime });
  }

  
}