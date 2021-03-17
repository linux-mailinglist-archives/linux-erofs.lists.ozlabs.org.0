Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B30233F920
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Mar 2021 20:27:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F10Xs18nmz30Ll
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Mar 2021 06:27:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.115; helo=mga14.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F10Xp4PZhz30JP
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Mar 2021 06:27:21 +1100 (AEDT)
IronPort-SDR: H907XDIJZCd6dA/HTKq7FSBfygMljdSAUi2Vy58jtOa+FzGlvUYPou5mTO7/wJ+8vXevoYCcCy
 +bSRPbq+REoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="188899631"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; d="scan'208";a="188899631"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2021 12:27:19 -0700
IronPort-SDR: bVr30JsfSVXsCYxwlDXCPUU8kdMLzvaLqlZf7dSEREOrlVVSY34dppBHBf/fQlTjwOqwU0QVL4
 5YgUlSS017Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; d="scan'208";a="411584973"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
 by orsmga007.jf.intel.com with ESMTP; 17 Mar 2021 12:27:17 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lMbp6-0000pQ-V6; Wed, 17 Mar 2021 19:27:16 +0000
Date: Thu, 18 Mar 2021 03:26:48 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 49f9e359229ccfb3a8c7df7e6ef793b7fbd3fb52
Message-ID: <605257f8.neEfXTje7sgljcxA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 49f9e359229ccfb3a8c7df7e6ef793b7fbd3fb52  erofs: use sync decompression for atomic contexts only

elapsed time: 722m

configs tested: 132
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
nds32                            alldefconfig
arm                      pxa255-idp_defconfig
arm                         lpc32xx_defconfig
sh                     sh7710voipgw_defconfig
powerpc                    socrates_defconfig
arc                         haps_hs_defconfig
arm                       spear13xx_defconfig
powerpc                     mpc512x_defconfig
sh                          landisk_defconfig
powerpc                    mvme5100_defconfig
m68k                       m5249evb_defconfig
sh                            titan_defconfig
powerpc                      ppc40x_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc8540_ads_defconfig
mips                         bigsur_defconfig
riscv                            alldefconfig
powerpc                     ep8248e_defconfig
powerpc                        icon_defconfig
mips                           ip28_defconfig
arm                         lpc18xx_defconfig
sh                          kfr2r09_defconfig
powerpc                      arches_defconfig
ia64                        generic_defconfig
sh                           se7206_defconfig
sh                           se7724_defconfig
arm                       cns3420vb_defconfig
mips                           rs90_defconfig
arm                          simpad_defconfig
mips                     loongson1c_defconfig
sh                        sh7785lcr_defconfig
arm                        clps711x_defconfig
sparc                       sparc32_defconfig
powerpc                     stx_gp3_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      pcm030_defconfig
arm                     eseries_pxa_defconfig
powerpc                   lite5200b_defconfig
powerpc                     ppa8548_defconfig
arm                         hackkit_defconfig
ia64                                defconfig
mips                          malta_defconfig
mips                        vocore2_defconfig
powerpc                     mpc5200_defconfig
powerpc                   motionpro_defconfig
nios2                            alldefconfig
mips                           ip27_defconfig
arm                         palmz72_defconfig
m68k                            q40_defconfig
m68k                          atari_defconfig
parisc                generic-64bit_defconfig
m68k                       bvme6000_defconfig
powerpc                    adder875_defconfig
sh                          sdk7786_defconfig
powerpc                      cm5200_defconfig
powerpc                  storcenter_defconfig
sh                   sh7770_generic_defconfig
mips                    maltaup_xpa_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210317
i386                 randconfig-a005-20210317
i386                 randconfig-a002-20210317
i386                 randconfig-a003-20210317
i386                 randconfig-a004-20210317
i386                 randconfig-a006-20210317
i386                 randconfig-a013-20210317
i386                 randconfig-a016-20210317
i386                 randconfig-a011-20210317
i386                 randconfig-a012-20210317
i386                 randconfig-a015-20210317
i386                 randconfig-a014-20210317
x86_64               randconfig-a006-20210317
x86_64               randconfig-a001-20210317
x86_64               randconfig-a005-20210317
x86_64               randconfig-a004-20210317
x86_64               randconfig-a003-20210317
x86_64               randconfig-a002-20210317
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210317
x86_64               randconfig-a016-20210317
x86_64               randconfig-a013-20210317
x86_64               randconfig-a014-20210317
x86_64               randconfig-a015-20210317
x86_64               randconfig-a012-20210317

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
