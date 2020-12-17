#!/bin/bash

# 取最新一条短信。特别注意通知类短信的权限。
# MIUI 要在应用权限里开启通知类短信权限。
# EMUI 的是：信息 > 更多 > 设置 > 高级 关闭验证码安全保护开关。
termux-sms-list -l 1

# 列出通知
termux-notification-list

