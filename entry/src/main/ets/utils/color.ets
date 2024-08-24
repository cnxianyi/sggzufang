export function rgbaToHex(rgba: string): string {
  // 从 rgba 字符串中提取数字部分
  const matches = rgba.match(/\d+/g);
  if (!matches || matches.length < 3) {
    throw new Error("Invalid RGBA input");
  }

  // 提取 RGBA 值
  const r = parseInt(matches[0]);
  const g = parseInt(matches[1]);
  const b = parseInt(matches[2]);
  const a = matches[3] ? parseFloat(matches[3]) : 1;

  // 将每个通道转换为两位的十六进制字符串
  const toHex = (num: number): string => {
    const hex = num.toString(16);
    return hex.length === 1 ? '0' + hex : hex;
  };

  // 透明度需要转换为 0-255 的整数，再转换为十六进制
  const alphaHex = toHex(Math.round(a * 255));

  return `#${toHex(r)}${toHex(g)}${toHex(b)}`;
}