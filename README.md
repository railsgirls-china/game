## 命令行版本

```ruby
  arr = User.pluck(:name)
  arr.shuffle!

  # 隐藏结果
  arr.shuffle!; nil
  arr.pop

  # 或者
  arr.shift
```
