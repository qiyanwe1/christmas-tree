// 用 Playwright 无头浏览器以 4K 分辨率录制 30 秒视频
// 前置：本地静态服务器运行中（_server.js, 端口 8787），chromium 已安装
import { chromium } from 'playwright';
import { mkdirSync } from 'fs';
import { dirname, join } from 'path';
import { fileURLToPath } from 'url';

const root = dirname(fileURLToPath(import.meta.url));
const outDir = join(root, 'out');
mkdirSync(outDir, { recursive: true });

const DURATION = Number(process.argv[2] || 30); // 录制秒数
const W = Number(process.argv[3] || 3840);      // 视口宽
const H = Number(process.argv[4] || 2160);      // 视口高

const browser = await chromium.launch({ channel: 'chromium' });
const ctx = await browser.newContext({
  viewport: { width: W, height: H },
  deviceScaleFactor: 2, // 2x 渲染超采样，视频输出更锐利
  recordVideo: { dir: outDir, size: { width: W, height: H } },
});
const page = await ctx.newPage();
await page.goto('http://127.0.0.1:8787/index.html');
await page.waitForTimeout(2000);          // 等首帧粒子就位
await page.waitForTimeout(DURATION * 1000);
await ctx.close();                        // 关闭上下文才会落盘 webm
await browser.close();
console.log('DONE');
