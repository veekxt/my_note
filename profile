# /etc/profile: system-wide .profile file for the Bourne shell (sh(1))
# and Bourne compatible shells (bash(1), ksh(1), ash(1), ...).

if [ "$PS1" ]; then
  if [ "$BASH" ] && [ "$BASH" != "/bin/sh" ]; then
    # The file bash.bashrc already sets the default PS1.
    # PS1='\h:\w\$ '
    if [ -f /etc/bash.bashrc ]; then
      . /etc/bash.bashrc
    fi
  else
    if [ "`id -u`" -eq 0 ]; then
      PS1='# '
    else
      PS1='$ '
    fi
  fi
fi

if [ -d /etc/profile.d ]; then
  for i in /etc/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

# 2016年 08月 23日 星期二 13:27:31 CST
# Hisilicon Linux, Cross-Toolchain PATH
export PATH="/opt/hisi-linux-nptl/arm-hisiv100-linux/target/bin:$PATH" 
# 


# 2016年 08月 23日 星期二 13:30:08 CST
# Hisilicon Linux, Cross-Toolchain PATH
# 


# 2016年 08月 23日 星期二 13:30:37 CST
# Hisilicon Linux, Cross-Toolchain PATH
export PATH="/opt/hisi-linux/x86-arm/arm-hisiv200-linux/target/bin:$PATH" 
# 


# 2016年 08月 23日 星期二 13:31:50 CST
# Hisilicon Linux, Cross-Toolchain PATH
export PATH="/opt/hisi-linux/x86-arm/arm-hisiv400-linux/target/bin:$PATH" 
# 


# 2016年 08月 23日 星期二 14:54:19 CST
# Hisilicon Linux, Cross-Toolchain PATH
# 


# 2016年 08月 23日 星期二 15:26:31 CST
# Hisilicon Linux, Cross-Toolchain PATH
export PATH="/opt/hisi-linux/x86-arm/arm-hisiv300-linux/target/bin:$PATH" 
# 

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
