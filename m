Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797273534C1
	for <lists+linux-erofs@lfdr.de>; Sat,  3 Apr 2021 18:39:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FCN0g6vjqz30Dy
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Apr 2021 02:38:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FCN0d5rXpz30CK
 for <linux-erofs@lists.ozlabs.org>; Sun,  4 Apr 2021 02:38:51 +1000 (AEST)
IronPort-SDR: MwyPC7k+QRqoG9jUbKPj2YMbRZ80flTtwLZc69KPzsv3C6U5Yu/0YUarLrsDcadXng5ReI7m2g
 jDScZvzmRpCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9943"; a="256602511"
X-IronPort-AV: E=Sophos;i="5.81,302,1610438400"; d="scan'208";a="256602511"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2021 09:38:46 -0700
IronPort-SDR: MhShtTBikR5tmok+WyYTz1G6DuUuFhC5YhthmJwLwqMEEEGH47U64LQ4IUtCFFudH/I5Wm60Qi
 hvd3WlfuSr0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,302,1610438400"; d="scan'208";a="528930866"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 03 Apr 2021 09:38:45 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lSjIK-0007mB-Ig; Sat, 03 Apr 2021 16:38:44 +0000
Date: Sun, 04 Apr 2021 00:37:48 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 b0b677fd35ce614933b5dc6cc61cddcd2bcba673
Message-ID: <606899dc.MmAnujTRe+QzneHi%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: b0b677fd35ce614933b5dc6cc61cddcd2bcba673  erofs: enable big pcluster feature

elapsed time: 723m

configs tested: 119
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                       imx_v4_v5_defconfig
powerpc                     tqm5200_defconfig
arm                        mvebu_v5_defconfig
powerpc                 mpc834x_mds_defconfig
mips                        workpad_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     ksi8560_defconfig
powerpc                     ppa8548_defconfig
sh                           se7712_defconfig
powerpc                     tqm8555_defconfig
arm                         mv78xx0_defconfig
mips                        bcm47xx_defconfig
xtensa                          iss_defconfig
arm                          pxa910_defconfig
sh                          kfr2r09_defconfig
mips                         mpc30x_defconfig
arm                         hackkit_defconfig
arm                          moxart_defconfig
arm                           stm32_defconfig
sh                            hp6xx_defconfig
mips                           ip22_defconfig
sh                          polaris_defconfig
sh                             sh03_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     skiroot_defconfig
powerpc                        icon_defconfig
m68k                         apollo_defconfig
powerpc                   lite5200b_defconfig
arm                            hisi_defconfig
x86_64                              defconfig
xtensa                  nommu_kc705_defconfig
powerpc                  mpc885_ads_defconfig
arm                        spear6xx_defconfig
arm                           omap1_defconfig
arm                        multi_v5_defconfig
mips                          ath25_defconfig
ia64                             allmodconfig
ia64                                defconfig
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
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210403
i386                 randconfig-a003-20210403
i386                 randconfig-a001-20210403
i386                 randconfig-a004-20210403
i386                 randconfig-a002-20210403
i386                 randconfig-a005-20210403
x86_64               randconfig-a014-20210403
x86_64               randconfig-a015-20210403
x86_64               randconfig-a011-20210403
x86_64               randconfig-a013-20210403
x86_64               randconfig-a012-20210403
x86_64               randconfig-a016-20210403
i386                 randconfig-a014-20210401
i386                 randconfig-a011-20210401
i386                 randconfig-a016-20210401
i386                 randconfig-a012-20210401
i386                 randconfig-a013-20210401
i386                 randconfig-a015-20210401
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210401
x86_64               randconfig-a005-20210401
x86_64               randconfig-a003-20210401
x86_64               randconfig-a001-20210401
x86_64               randconfig-a002-20210401
x86_64               randconfig-a006-20210401
x86_64               randconfig-a003-20210403
x86_64               randconfig-a001-20210403
x86_64               randconfig-a002-20210403
x86_64               randconfig-a004-20210403
x86_64               randconfig-a005-20210403
x86_64               randconfig-a006-20210403

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
