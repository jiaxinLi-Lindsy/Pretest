#!/bin/bash

# 需要保留的文件列表
KEEP_FILES=(
    # odd_level.html 使用的文件
    "level_standard.wav"
    "level_1_h.wav"
    "level_2_h.wav"
    "level_3_h.wav"
    "level_4_h.wav"
    "level_5_h.wav"
    "level_6_h.wav"
    "level_7_h.wav"
    "level_8_h.wav"
    "level_9_h.wav"
    "level_10_h.wav"
    "level_1_l.wav"
    "level_2_l.wav"
    "level_3_l.wav"
    "level_4_l.wav"
    "level_5_l.wav"
    "level_6_l.wav"
    "level_7_l.wav"
    "level_8_l.wav"
    "level_9_l.wav"
    "level_10_l.wav"
    
    # odd_rising.html 使用的文件
    "mid_rising_standard.wav"
    "mid_rising_1.wav"
    "mid_rising_2.wav"
    "mid_rising_3.wav"
    "mid_rising_4.wav"
    "mid_rising_5.wav"
    "mid_rising_6.wav"
    "mid_rising_7.wav"
    "mid_rising_8.wav"
    "mid_rising_9.wav"
    "mid_rising_10.wav"
    
    # odd_falling.html 使用的文件
    "mid_falling_standard.wav"
    "mid_falling_1.wav"
    "mid_falling_2.wav"
    "mid_falling_3.wav"
    "mid_falling_4.wav"
    "mid_falling_5.wav"
    "mid_falling_6.wav"
    "mid_falling_7.wav"
    "mid_falling_8.wav"
    "mid_falling_9.wav"
    "mid_falling_10.wav"
)

echo "=== 清理未使用的音频文件 ==="
echo ""
echo "保留的文件数: ${#KEEP_FILES[@]}"
echo ""

# 创建删除列表
TO_DELETE=()

# 遍历所有 wav 文件
for file in Media/*.wav; do
    basename=$(basename "$file")
    
    # 检查是否在保留列表中
    keep=false
    for keepfile in "${KEEP_FILES[@]}"; do
        if [ "$basename" == "$keepfile" ]; then
            keep=true
            break
        fi
    done
    
    if [ "$keep" == false ]; then
        TO_DELETE+=("$file")
    fi
done

echo "将删除 ${#TO_DELETE[@]} 个未使用的文件:"
echo ""
for file in "${TO_DELETE[@]}"; do
    echo "  - $(basename "$file")"
done

echo ""
read -p "确认删除这些文件吗？(y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    for file in "${TO_DELETE[@]}"; do
        rm "$file"
        echo "已删除: $file"
    done
    echo ""
    echo "✅ 清理完成！删除了 ${#TO_DELETE[@]} 个文件"
else
    echo "已取消"
fi

