


#从github下载并解压一个项目
vcpkg_form_github(      
    OUT_SOURCE_PATH SOURCE_PATH      #指定将包提取到指定位置的路径,一般都指定为SOURCE_PATH
    REPO shibatch/sleef              #port sleef在github上的仓库地址
    REF cc4b0213f2f57a2f7e8f6355758dc40973ae9998       #参考标签名字，一般最好选择稳定版本的commit号，有时候也可以选择最新的master提交commit
    SHA512 1                         #与存档匹配的哈希值，一般先以错误的使用，会自动返回正确的哈希值
    HEAD_REF master                  #一般都是master，偶尔在update的时候会有用户特殊要求时选择 --head
    PATCHES                          #基于${SOURCE_PATH}目录所制作的补丁
)

#如果${CMAKE_CURRENT_LIST_DIR}目录下自带CMakeLists.txt文件则需要将它拷贝到${SOURCE_PATH}路径下，没有则不用
#file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

#配置CMAKE
vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}       #一般指包含CMakeLists.txt的路径 ${SOURCE_PATH}
    PREFER_NINJA                     #如果不支持NINJA编译就不写
    OPTIONS                          #cmake配置期间会传递给cmake的编译选项
        -DBUILD_SHARED_LIBS=ON       # Build shared libs 
        -DSLEEF_SHOW_CONFIG=ON       # Show SLEEF configuration status messages
)

#构建并安装cmake
vcpkg_cmake_install()  
#合并或者纠正cmake存放的错误路径
vcpkg_cmake_config_fixup()
#修复*.pc文件的路径
vcpkg_fixup_pkgconfig()

#将pdb文件复制到bin目录下 
vcpkg_copy_pdbs()

#删除多余文件debug目录下只留下bin和lib文件夹
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

#将LICENSE拷贝到package正确路径下
file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} copyright)

           