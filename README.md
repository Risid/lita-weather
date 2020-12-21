# lita-weather

[![Build Status](https://travis-ci.org/risid/lita-weather.png?branch=master)](https://travis-ci.org/risid/lita-weather)
[![Coverage Status](https://coveralls.io/repos/risid/lita-weather/badge.png)](https://coveralls.io/r/risid/lita-weather)

这是一个使用和风天气提供的天气数据来完成天气查询的Lita机器人插件

## 安装

将lita-weather加入到你Lita项目的Gemfile中

``` ruby
gem "lita-weather"
```

## 配置
在你的lita_config.rb中添加你在和风天气申请的API key

``` ruby
  config.handlers.weather.key = "1234567890"
```

## Usage

``` ruby
> lita, 北京天气如何
```
