<template>
  <div
    class="vue-live2d"
    ref="vue-live2d"
    :style="{ width: live2dWidth + 'px', height: live2dHeight + 'px' }"
    @mouseover="toolShow = true"
    @mouseout="toolShow = false">
    <div v-show="mainShow">
      <div class="vue-live2d-tip" v-html="tipText" v-show="tipShow"></div>
      <canvas :id="live2dMainId" ref="vue-live2d-main" :width="live2dWidth" :height="live2dHeight" class="vue-live2d-main"></canvas>
      <div
        class="vue-live2d-tool"
        ref="vue-live2d-tool"
        v-show="toolShow">
        <span
          class="vue-live2d-toolitem"
          v-for="(tool, index) in tools"
          :key="index"
          :class="tool.name"
          @click="tool.click"/>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import live2dJS from '../live2d/live2d.min.js'
// import 'font-awesome/css/font-awesome.min.css'

import tips from '../live2d/tips'

export default {
  name: 'live2d',
  props: {
    direction: {
      default: 'right',
      type: String
    },
    customId: {
      default: '',
      type: String
    },
    apiPath: {
      default: 'https://live2d.fghrsh.net/api',
	  // default: 'https://github.com/fghrsh/live2d_api',
      type: String
    },
    homePage: {
      default: 'https://github.com/evgo2017/vue-live2d',
      type: String
    },
    tips: {
      default: () => tips,
      type: Object
    },
    width: {
      default: 0,
      type: Number
    },
    height: {
      default: 0,
      type: Number
    },
    size: {
      default: 255,
      type: Number
    }
  },
  data () {
    return {
      messageTimer: null,
      mainShow: true,
      tipText: '',
      tipShow: false,
      toolShow: false,
      groupId: 0,
      modelName: 0,
      tools: [{
        name: 'iconfont icon-home',
        click: this.openHomePage
      }, {
		  name: 'iconfont icon-enjoy',
		  click: this.showSaying
	  }, {
		name: 'iconfont icon-skin',
		click: this.loadRandModel
	  }, {
        name: 'iconfont icon-takephoto',
        click: this.takePhoto
      },{
        name: 'iconfont icon-close',
        click: this.close
      }],
	  modelComb:[
		  {name: 'widgetModel', groups:[ 'chitose', 'Epsilon2_1', 'Gantzert_Felixander', 'haruto', 'hijiki', 'izumi', 'koharu', 'miku', 'nico', 'nietzsche', 'ni-j', 'nipsilon']},
		  {name: 'bilibili-live', groups: ['22', '33']},
		  {name: 'ShizukuTalk', groups: ['shizuku-48', 'shizuku-pajama']},
		  {name: 'Potion-Maker', groups: ['Pio', 'Tia']},
		  {name: 'KantaiCollection', groups: ['murakumo']},
		  {name: 'HyperdimensionNeptunia', groups: ['blanc_classic', 'blanc_normal', 'blanc_swimwear', 'histoire', 'histoirenohover', 'nepgear', 'nepgear_extra', 'nepgearswim', 'nepmaid', 'nepnep', 'nepswim', 'neptune_classic', 'neptune_santa', 'noir', 'noir_classic', 'noir_santa', 'noireswim', 'vert_classic', 'vert_normal', 'vert_swimwear']}
	  ],
	  model: [5,5]
    }
  },
  mounted () {
    this.groupId = this.model[0]
    this.modelName = this.model[1]
    this.loadModel()
    //this.setDirection()
    this.$nextTick(function () {
      this.loadEvent()
    })
  },
  computed: {
    live2dMainId () {
      const defaultId = 'vue-live2d-main'
      const customId = this.customId
      if (!customId) return defaultId
      return customId
    },
    live2dWidth () {
      return this.width ? this.width : this.size
    },
    live2dHeight () {
      return this.height ? this.height : this.size
    }
  },
  watch: {
    mainShow () {
      // const containers = ['vue-live2d']
      // const refs = this.$refs
      // containers.forEach(containerName => {
      //   refs[containerName].classList.toggle(`${containerName}-on-${this.direction}`)
      // })
    },
    direction () {
      this.setDirection()
    },
    width () {
      this.changeLive2dSize()
    },
    height () {
      this.changeLive2dSize()
    },
    size () {
      if (this.width || this.height) return
      this.changeLive2dSize()
    }
  },
  methods: {
    changeLive2dSize () {
      const { live2dMainId, live2dWidth: width, live2dHeight: height } = this
      // 不知还有调整宽高的好方法没？
      document.querySelector(`#${live2dMainId}`).outerHTML = `<canvas id=${live2dMainId} width="${width}" height="${height}" class="vue-live2d-main"></canvas>`
      this.loadModel()
    },
    setDirection () {
      const containers = ['vue-live2d', 'vue-live2d-tool', 'vue-live2d-toggle']
      const refs = this.$refs
      const addClassPostFix = this.direction
      const removeClassPostFix = this.direction === 'left' ? 'right' : 'left'
      containers.forEach(containerName => {
        refs[containerName].classList.remove(`${containerName}-on-${removeClassPostFix}`)
        refs[containerName].classList.add(`${containerName}-on-${addClassPostFix}`)
      })
    },
    loadModel () {
	  if(!window.loadlive2d){
		  const script = document.createElement('script');
		  script.innerHTML = live2dJS;
		  document.body.appendChild(script);
	  }
	  let modelName = this.modelComb[this.groupId].groups[this.modelName];
	  let groupName = this.modelComb[this.groupId].name;
	  if(this.groupId == 0){
		  const url = `/live2d/model/${groupName}/${modelName}/assets/${modelName}.model.json`;
		  window.loadlive2d(this.live2dMainId, url);
	  }else {
		  const url = `/live2d/model/${groupName}/${modelName}/index.json`;
		  window.loadlive2d(this.live2dMainId, url);
	  }
	  
	  // window.loadlive2d(live2dMainId, '/live2d/model/HyperdimensionNeptunia/blanc_classic/index.json');
      console.log(`Live2D 模型 ${groupName}-${modelName} 加载完成`)
    },
    loadRandModel () {
		this.groupId = Math.floor(Math.random(0,1) * this.modelComb.length);
		this.modelName = Math.floor(Math.random(0, 1) * this.modelComb[this.groupId].groups.length);
		this.loadModel();
    },
    showMessage (msg = '', timeout = 6000) {
      if (this.messageTimer) {
        clearTimeout(this.messageTimer)
        this.messageTimer = null
      } else {
        this.tipShow = true
      }
      this.tipText = msg
      this.messageTimer = setTimeout(() => {
        this.tipShow = false
        this.messageTimer = null
      }, timeout)
    },
    takePhoto () {
      this.showMessage('照好了嘛，留个纪念吖~')
      window.Live2D.captureName = 'photo.png'
      window.Live2D.captureFrame = true
    },
    showHitokoto () {
      const url = 'https://v1.hitokoto.cn'
      axios.get(url).then((res) => {
        const { hitokoto, id, creator } = res.data
        this.showMessage(`${hitokoto} <br> - by <a href="https://hitokoto.cn?id=${id}">${creator}</a> from 《${res.data.from} 》`)
      }).catch(function (err) {
        console.log(err)
      })
    },
	showSaying() {
		const url = 'https://api.66mz8.com/api/quotation.php';
		axios.get(url).then(res => {
			if(res && res.status == 200){
				const data = res.data;
				this.showMessage(`${data} <br> -by <a href="https://www.free-api.com/" target="_blank">free-api</a>`)
			}
		});
	},
    openHomePage () {
      open(this.homePage)
    },
	open () {
		this.mainShow = true;
	},
    close () {
      // this.mainShow = false;
	  this.$emit('close');
    },
    loadEvent () {
      for (const event in this.tips) {
        for (const obj of this.tips[event]) {
          const { selector, texts } = obj
          const dom = selector === 'document' ? document : document.querySelector(selector)
          if (dom == null) continue

          dom.addEventListener(event, () => {
            const msg = texts[Math.floor(Math.random() * texts.length)]
            this.showMessage(msg, 2000)
          })
        }
      }
    }
  }
}
</script>

<style scoped>
	/* 使用在线iconfont */
	/* @import url("../live2d/iconfont.css"); */
	@media screen and (max-width: 900px) {
	    .vue-live2d {
			display: none;
		}
	  }
/* live2d */
.vue-live2d {
	position: fixed;
	bottom: 0;
  transform: translateY(0);
  transition: transform .3s ease-in-out;
}
.vue-live2d-on-left:hover {
  transform: translateX(21px);
}
.vue-live2d-on-right:hover {
  transform: translateX(-21px);
}
/* live2d-tip */
.vue-live2d-tip {
  position: absolute;
  width: 100%;
  min-height: 3rem;
  line-height: 1.5rem;
  margin-top: -20px;
  padding: 5px 10px;
  font-size: .9rem;
  word-break: break-all;
  text-overflow: ellipsis;
  border: 1px solid rgba(224, 186, 140, 0.62);
  border-radius: 12px;
  background-color: rgba(236, 217, 188, 0.5);
  box-shadow: 0 3px 15px 2px rgba(191, 158, 118, 0.2);
  animation: shake 50s ease-in-out 5s infinite;
}
/* live2d-main */
.vue-live2d-main {
  cursor: grab;
  cursor: -webkit-grab;
  cursor: -o-grab;
  cursor: -ms-grab;
}
/* live2d-tool */
.vue-live2d-tool {
  position: absolute;
  width: 50px;
  top: 50px;
  /* color: rgba(0, 50, 60, .4); */
  color: var(--textColor);
  text-align: center;
  cursor: pointer;
}
.vue-live2d-tool-on-left {
  left: -18px;
}
.vue-live2d-tool-on-right {
  right: -18px;
}
.vue-live2d-tool span {
  display: block;
  line-height: 30px;
  font-size: 22px;
}
.vue-live2d-tool span:hover {
  color: #0684bd;
}

/* live2d-toggle */
.vue-live2d-toggle {
  width: 1.5rem;
  position: absolute;
  bottom: 1rem;
  padding: .3rem 0;
  writing-mode: vertical-lr;
  color: #fff;
  background-color: #fa0;
  font-size: 1rem;
  cursor: pointer;
}
.vue-live2d-toggle-on-left {
  left: 0;
  border-radius: 0 .5rem .5rem 0;
}
.vue-live2d-toggle-on-right {
  right: 0;
  border-radius: .5rem 0 0 .5rem;
}
.vue-live2d-toggle:hover {
  width: 1.7rem;
}
@keyframes shake {
  2% {
    transform: translate(0.5px, -1.5px) rotate(-0.5deg);
  }
  4% {
    transform: translate(0.5px, 1.5px) rotate(1.5deg);
  }
  6% {
    transform: translate(1.5px, 1.5px) rotate(1.5deg);
  }
  8% {
    transform: translate(2.5px, 1.5px) rotate(0.5deg);
  }
  10% {
    transform: translate(0.5px, 2.5px) rotate(0.5deg);
  }
  12% {
    transform: translate(1.5px, 1.5px) rotate(0.5deg);
  }
  14% {
    transform: translate(0.5px, 0.5px) rotate(0.5deg);
  }
  16% {
    transform: translate(-1.5px, -0.5px) rotate(1.5deg);
  }
  18% {
    transform: translate(0.5px, 0.5px) rotate(1.5deg);
  }
  20% {
    transform: translate(2.5px, 2.5px) rotate(1.5deg);
  }
  22% {
    transform: translate(0.5px, -1.5px) rotate(1.5deg);
  }
  24% {
    transform: translate(-1.5px, 1.5px) rotate(-0.5deg);
  }
  26% {
    transform: translate(1.5px, 0.5px) rotate(1.5deg);
  }
  28% {
    transform: translate(-0.5px, -0.5px) rotate(-0.5deg);
  }
  30% {
    transform: translate(1.5px, -0.5px) rotate(-0.5deg);
  }
  32% {
    transform: translate(2.5px, -1.5px) rotate(1.5deg);
  }
  34% {
    transform: translate(2.5px, 2.5px) rotate(-0.5deg);
  }
  36% {
    transform: translate(0.5px, -1.5px) rotate(0.5deg);
  }
  38% {
    transform: translate(2.5px, -0.5px) rotate(-0.5deg);
  }
  40% {
    transform: translate(-0.5px, 2.5px) rotate(0.5deg);
  }
  42% {
    transform: translate(-1.5px, 2.5px) rotate(0.5deg);
  }
  44% {
    transform: translate(-1.5px, 1.5px) rotate(0.5deg);
  }
  46% {
    transform: translate(1.5px, -0.5px) rotate(-0.5deg);
  }
  48% {
    transform: translate(2.5px, -0.5px) rotate(0.5deg);
  }
  50% {
    transform: translate(-1.5px, 1.5px) rotate(0.5deg);
  }
  52% {
    transform: translate(-0.5px, 1.5px) rotate(0.5deg);
  }
  54% {
    transform: translate(-1.5px, 1.5px) rotate(0.5deg);
  }
  56% {
    transform: translate(0.5px, 2.5px) rotate(1.5deg);
  }
  58% {
    transform: translate(2.5px, 2.5px) rotate(0.5deg);
  }
  60% {
    transform: translate(2.5px, -1.5px) rotate(1.5deg);
  }
  62% {
    transform: translate(-1.5px, 0.5px) rotate(1.5deg);
  }
  64% {
    transform: translate(-1.5px, 1.5px) rotate(1.5deg);
  }
  66% {
    transform: translate(0.5px, 2.5px) rotate(1.5deg);
  }
  68% {
    transform: translate(2.5px, -1.5px) rotate(1.5deg);
  }
  70% {
    transform: translate(2.5px, 2.5px) rotate(0.5deg);
  }
  72% {
    transform: translate(-0.5px, -1.5px) rotate(1.5deg);
  }
  74% {
    transform: translate(-1.5px, 2.5px) rotate(1.5deg);
  }
  76% {
    transform: translate(-1.5px, 2.5px) rotate(1.5deg);
  }
  78% {
    transform: translate(-1.5px, 2.5px) rotate(0.5deg);
  }
  80% {
    transform: translate(-1.5px, 0.5px) rotate(-0.5deg);
  }
  82% {
    transform: translate(-1.5px, 0.5px) rotate(-0.5deg);
  }
  84% {
    transform: translate(-0.5px, 0.5px) rotate(1.5deg);
  }
  86% {
    transform: translate(2.5px, 1.5px) rotate(0.5deg);
  }
  88% {
    transform: translate(-1.5px, 0.5px) rotate(1.5deg);
  }
  90% {
    transform: translate(-1.5px, -0.5px) rotate(-0.5deg);
  }
  92% {
    transform: translate(-1.5px, -1.5px) rotate(1.5deg);
  }
  94% {
    transform: translate(0.5px, 0.5px) rotate(-0.5deg);
  }
  96% {
    transform: translate(2.5px, -0.5px) rotate(-0.5deg);
  }
  98% {
    transform: translate(-1.5px, -1.5px) rotate(-0.5deg);
  }
  0%, 100% {
    transform: translate(0, 0) rotate(0deg);
  }
}
</style>
