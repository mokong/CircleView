# CircleView
自动轮播的实现，两种方式，这里只有前两种方法的参考代码，第三种的话大家自行百度。

假设有5张图片，分别是：12345，实现轮播图
> 方法1：用scrollView加NSTimer实现，思路：12345五张图片，实现轮播，我添加两张，变成5123451，当滑到最后一个1时，无动画位移回第一个1；当倒着滑到5时，无动画回最后的5。

方法1 难点在于：给定数组的个数，及两个边界的判断


> 方法2：用collectionView加NSTimer实现，思路：12345五张图片，对应collectionView的1个section，即一个section有5个row；至于有多少个section，尽量设置的大一些，eg：100；（collectionView有重用机制）所以不用担心内存问题。

方法2 难点在于：滑动的逻辑处理；如果你把section设置的非常大，就不用担心倒着滑的问题，毕竟不是每个人都那么闲。

> 方法3：用scrollView加NSTimer实现，12345，只用3个imageView，每次滑动的时候，始终保证下一个是居中，eg：512，123，234，当你从2滑到3的时候，结束后位移从123变为到234；
