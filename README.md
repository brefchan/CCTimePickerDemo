# CCTimePickerDemo
时间选择器的另一种样子

#### 如果觉得有用,不妨给个Star呗~

### 项目演示
![image](https://github.com/bref-Chan/CCTimePickerDemo/blob/master/gif/CCTimePickerGIF.gif)   

### 使用方法

将CCTimePicker文件夹导入项目.

```
- (void)showTimePickerView{
    CCTimePickerView *pickerView = [CCTimePickerView viewFromXib];
    pickerView.delegate = self;
    pickerView.isAutoNext = YES;
    [pickerView setCurrentDate:[NSDate date]];
    
    [self.pickerView popInView:self.view];
}

#pragma mark CCTimePickerViewDelegate
- (void)pickerView:(CCTimePickerView *)timePickerView didSelectTime:(NSDate *)date
{
    NSLog(@"%@",date);
}

- (void)pickerViewCancelSelect:(CCTimePickerView *)timePickerView
{
    NSLog(@"取消");
}   
```


