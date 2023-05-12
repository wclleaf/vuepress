<template>
  <div
    class="body-bg"
    :style="`background: url(${bgImg}) top center / cover no-repeat;opacity:${opacity}`"
  ></div>
</template>

<script>
import { type } from '../util'
import axios from 'axios'

export default {
  data () {
    return {
      bgImg: '',
      opacity: 0.5
    }
  },
  mounted () {
    let { bodyBgImg, bodyBgImgOpacity } = this.$themeConfig
	
	if (type(bodyBgImg) === 'string') {
		// this.bgImg = 'https://v1.alapi.cn/api/acg?token=9IbGN4Th4fLiVCEH'
    this.bgImg = 'https://api.yimian.xyz/img?type=moe';
		//备用api：1、http://www.dmoe.cc/random.php 2、https://img.xjh.me/random_img.php 3、https://api.ghser.com/random/api.php 4、https://api.yimian.xyz/img?type=moe
	} else if (type(bodyBgImg) === 'array') {
      let count = 0
      let timer = null

      this.bgImg = bodyBgImg[count]
      clearInterval(timer)
      timer = setInterval(() => {
        if (++count >= bodyBgImg.length) {
          count = 0
        }
        this.bgImg = bodyBgImg[count]
      }, 15000);
    }
	
    if (bodyBgImgOpacity != undefined) {
      this.opacity = bodyBgImgOpacity
    }

  }
}
</script>

<style lang='stylus'>
.body-bg
  position fixed
  left 0
  top 0
  z-index -999999
  height 100vh
  width 100vw
  transition background 0.5s
</style>
