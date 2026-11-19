# 🎄 粒子圣诞树 · 项目汇总

Canvas 2D 粒子圣诞树网页：白粉银配色、丝带光精灵形态、底部星系旋臂、方片银光星顶饰。单文件零依赖，手机/电脑自适应，可直接发链接分享，另附横竖屏视频素材用于发布短视频平台。

---

## 🔗 在线链接

| 链接 | 版本 | 说明 |
|---|---|---|
| https://christmas-tree-qy2.surge.sh | **最新版（含彩蛋）** | 按 S 放烟花、按空格粒子汇聚 |
| https://christmas-tree-qy.surge.sh | 旧版（保留） | 无彩蛋 |
| https://qiyanwe1.github.io/christmas-tree/ | 同步最新版 | GitHub Pages，国内可能被墙 |
| https://cdn.jsdelivr.net/gh/qiyanwe1/christmas-tree@master/index.html | jsDelivr 镜像 | 国内 WiFi 可用，移动流量不稳 |

二维码：`qr-surge2.png`（新版）/ `qr-surge.png`（旧版），微信发送到手机扫码即可。

> ⚠️ 已作废：COS 链接（`cos-website` 域名，腾讯 2024 新规强制下载）、Cloudflare workers.dev（国内被污染）。

---

## 🎬 视频素材

| 文件 | 规格 | 用途 |
|---|---|---|
| `christmas-vertical.mp4` | 1080×1920、32s、H.264 CRF14 | **抖音/视频号/朋友圈竖屏发布** |
| `christmas-4k.mp4` | 3840×2160、30s、H.264 CRF14 | 横屏场景：B站、电视投屏 |

发布建议：抖音选轻柔圣诞 BGM（如 "Christmas lofi"）、封面选星星最亮的帧、晚上 8-10 点发布、电脑端 creator.douyin.com 上传勾选高清。

---

## 📁 文件清单

| 文件 | 说明 |
|---|---|
| `index.html` | 主页面（全部代码，单文件零依赖） |
| `site/index.html` | Surge 部署目录（每次发布前同步） |
| `_server.js` | 本地预览服务器（`node _server.js`，端口 8787） |
| `tools/record.mjs` | Playwright 录制脚本（支持自定义分辨率） |
| `tools/build-vertical.cmd` | 竖屏视频一键录制+转码流水线 |
| `christmas-vertical.mp4` / `christmas-4k.mp4` | 视频成品 |
| `qr-surge2.png` / `qr-surge.png` | 二维码 |
| `tools/` 下的 node_modules 等 | 本地工具依赖，勿上传/勿拖入部署包 |

---

## ⌨️ 页面操作

- **双击屏幕/画布**：切换全屏（安卓/电脑有效，iPhone Safari 不支持网页全屏）
- **S 键**：随机位置绽放一圈烟花（130 颗粒子，圆环爆开 + 重力下坠 + 闪白）
- **空格键**：整树粒子向中轴收拢 0.8 秒后弹回（卡音乐节拍用）

---

## 🎨 当前设计参数（想微调改这些）

| 参数 | 位置 | 现值 |
|---|---|---|
| 主题色相 | `hueAt()` | 318 起白粉渐变 |
| 丝带数量/圈数 | `RIBBONS / TURNS` | 4 条 / 4.6 圈 |
| 树粒子数 | `TREE_N` | 2200（手机 1400） |
| 星系盘粒子数 | `GAL_N` | 3000（手机 1900） |
| 构图中心 | `cx` | 屏宽 60% |
| 底部星系盘 | `baseY` | 屏高 80% |
| 顶饰 | `drawTopFlake` | 方片银光星 + 四芒 + 46 片旋转光尘 |

---

## 🚀 如何更新发布

1. **本地预览**：`node _server.js` → 浏览器开 `http://127.0.0.1:8787`
2. **发布 Surge**（改完 `index.html` 后）：
   ```
   copy index.html site\index.html
   cd tools && npx surge ../site christmas-tree-qy2.surge.sh
   ```
3. **同步 GitHub**（自动触发 Pages 更新）：
   ```
   git add -A && git commit -m "..." && git push
   ```
4. **重录视频**：
   ```
   cd tools && npx playwright install chromium   （首次）
   node record.mjs 30 3840 2160                  （横屏 4K）
   node record.mjs 30 1080 1920                  （竖屏）
   ffmpeg -y -i tools\out\xxx.webm -c:v libx264 -crf 14 -preset medium -pix_fmt yuv420p -movflags +faststart 成品.mp4
   ```

---

## 📷 手机拍电脑屏幕要点

- 电脑：F11 全屏、亮度拉高、刷新率调最高、勿扰模式、关灯拍
- 手机：后置主摄 1080p60、**锁定曝光对焦**（防呼吸式闪变）、专业模式快门 1/50 或 1/100 防频闪条纹、拉远+变焦防摩尔纹、三脚架固定
- 卡点：左手键盘（S/空格），卡 BGM 的 drop 点按空格看粒子汇聚回弹

---

## 📌 待办与提醒

- [ ] GitHub token（`ghp_...`，曾在聊天中暴露）：**去 https://github.com/settings/tokens 删除**
- [ ] 大陆 COS 存储桶（`qiyan-1404197794` / `test1-1404197794`）：确认不用后删除
- [ ] Cloudflare Worker（`flat-butterfly-d5b5`）：国内不可达，可删可留
- [ ] Surge 账号密码：自己记好（换电脑需重新登录才能更新站点）

---

*创建于 2026-11-19 · 圣诞快乐 🎄*
