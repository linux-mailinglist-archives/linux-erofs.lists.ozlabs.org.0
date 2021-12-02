Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AF69B465C19
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Dec 2021 03:22:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J4KTy2T80z2ynt
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Dec 2021 13:22:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J4KTt72Dqz2y7M
 for <linux-erofs@lists.ozlabs.org>; Thu,  2 Dec 2021 13:22:05 +1100 (AEDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="299996328"
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; d="scan'208";a="299996328"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2021 18:21:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; d="scan'208";a="477761101"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
 by orsmga002.jf.intel.com with ESMTP; 01 Dec 2021 18:21:00 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1msbiV-000FhD-FE; Thu, 02 Dec 2021 02:20:59 +0000
Date: Thu, 02 Dec 2021 10:20:47 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 7e508f2ca8bbda8cabbd4753bc727a7f66837a12
Message-ID: <61a82d7f.VBA54l1o6oKLgAzn%lkp@intel.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 7e508f2ca8bbda8cabbd4753bc727a7f66837a12  erofs: rename lz4_0pading to zero_padding

elapsed time: 720m

configs tested: 224
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211128
i386                 randconfig-c001-20211201
arm                       cns3420vb_defconfig
arm                            hisi_defconfig
arm                        mvebu_v7_defconfig
arc                              alldefconfig
arm                  colibri_pxa270_defconfig
arm                      integrator_defconfig
openrisc                  or1klitex_defconfig
xtensa                    xip_kc705_defconfig
m68k                          atari_defconfig
sh                          sdk7786_defconfig
mips                          rb532_defconfig
arm                          ixp4xx_defconfig
mips                          rm200_defconfig
ia64                          tiger_defconfig
mips                        qi_lb60_defconfig
mips                         mpc30x_defconfig
s390                             alldefconfig
mips                           ci20_defconfig
m68k                       m5208evb_defconfig
m68k                        m5407c3_defconfig
powerpc                      makalu_defconfig
sh                           se7721_defconfig
sh                               alldefconfig
arc                         haps_hs_defconfig
arm                          exynos_defconfig
xtensa                              defconfig
arc                      axs103_smp_defconfig
sparc                       sparc32_defconfig
mips                           ip22_defconfig
arm                          moxart_defconfig
sh                               j2_defconfig
powerpc                      arches_defconfig
sparc64                          alldefconfig
powerpc                     mpc83xx_defconfig
mips                        bcm63xx_defconfig
i386                             alldefconfig
powerpc                      mgcoge_defconfig
mips                           rs90_defconfig
arm                           sunxi_defconfig
arm                      jornada720_defconfig
arc                          axs101_defconfig
arm                        clps711x_defconfig
powerpc                 mpc8272_ads_defconfig
nios2                         10m50_defconfig
powerpc                    mvme5100_defconfig
s390                       zfcpdump_defconfig
sh                          rsk7269_defconfig
arm                       imx_v6_v7_defconfig
mips                        bcm47xx_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                         ap325rxa_defconfig
openrisc                            defconfig
powerpc                     tqm8560_defconfig
arm                       spear13xx_defconfig
sh                          rsk7203_defconfig
powerpc                     rainier_defconfig
xtensa                       common_defconfig
sh                        dreamcast_defconfig
sh                   secureedge5410_defconfig
arm                        cerfcube_defconfig
riscv                    nommu_virt_defconfig
powerpc                      ep88xc_defconfig
arm                     eseries_pxa_defconfig
arm                        multi_v7_defconfig
mips                      maltaaprp_defconfig
powerpc                      chrp32_defconfig
mips                            ar7_defconfig
powerpc                   microwatt_defconfig
sh                          sdk7780_defconfig
powerpc                     pseries_defconfig
arm                   milbeaut_m10v_defconfig
um                           x86_64_defconfig
csky                                defconfig
m68k                         amcore_defconfig
mips                       capcella_defconfig
arm                        multi_v5_defconfig
h8300                       h8s-sim_defconfig
arm                       imx_v4_v5_defconfig
powerpc64                           defconfig
mips                      pic32mzda_defconfig
ia64                             alldefconfig
nios2                            alldefconfig
powerpc                 mpc832x_rdb_defconfig
sh                              ul2_defconfig
sh                         ecovec24_defconfig
arc                     nsimosci_hs_defconfig
arm                  randconfig-c002-20211128
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20211130
i386                 randconfig-a002-20211130
i386                 randconfig-a006-20211130
i386                 randconfig-a004-20211130
i386                 randconfig-a003-20211130
i386                 randconfig-a001-20211130
i386                 randconfig-a001-20211201
i386                 randconfig-a005-20211201
i386                 randconfig-a003-20211201
i386                 randconfig-a002-20211201
i386                 randconfig-a006-20211201
i386                 randconfig-a004-20211201
i386                 randconfig-a001-20211129
i386                 randconfig-a002-20211129
i386                 randconfig-a006-20211129
i386                 randconfig-a005-20211129
i386                 randconfig-a004-20211129
i386                 randconfig-a003-20211129
x86_64               randconfig-a011-20211128
x86_64               randconfig-a014-20211128
x86_64               randconfig-a012-20211128
x86_64               randconfig-a016-20211128
x86_64               randconfig-a013-20211128
x86_64               randconfig-a015-20211128
i386                 randconfig-a015-20211128
i386                 randconfig-a016-20211128
i386                 randconfig-a013-20211128
i386                 randconfig-a012-20211128
i386                 randconfig-a014-20211128
i386                 randconfig-a011-20211128
arc                  randconfig-r043-20211128
s390                 randconfig-r044-20211128
riscv                randconfig-r042-20211128
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20211128
i386                 randconfig-c001-20211128
riscv                randconfig-c006-20211128
arm                  randconfig-c002-20211128
powerpc              randconfig-c003-20211128
x86_64               randconfig-c007-20211128
mips                 randconfig-c004-20211128
arm                  randconfig-c002-20211201
x86_64               randconfig-c007-20211201
riscv                randconfig-c006-20211201
mips                 randconfig-c004-20211201
i386                 randconfig-c001-20211201
powerpc              randconfig-c003-20211201
s390                 randconfig-c005-20211201
x86_64               randconfig-a001-20211128
x86_64               randconfig-a006-20211128
x86_64               randconfig-a003-20211128
x86_64               randconfig-a005-20211128
x86_64               randconfig-a004-20211128
x86_64               randconfig-a002-20211128
i386                 randconfig-a001-20211128
i386                 randconfig-a002-20211128
i386                 randconfig-a006-20211128
i386                 randconfig-a005-20211128
i386                 randconfig-a004-20211128
i386                 randconfig-a003-20211128
x86_64               randconfig-a014-20211130
x86_64               randconfig-a016-20211130
x86_64               randconfig-a013-20211130
x86_64               randconfig-a012-20211130
x86_64               randconfig-a015-20211130
x86_64               randconfig-a011-20211130
i386                 randconfig-a011-20211130
i386                 randconfig-a015-20211130
i386                 randconfig-a012-20211130
i386                 randconfig-a013-20211130
i386                 randconfig-a014-20211130
i386                 randconfig-a016-20211130
i386                 randconfig-a015-20211129
i386                 randconfig-a016-20211129
i386                 randconfig-a013-20211129
i386                 randconfig-a012-20211129
i386                 randconfig-a014-20211129
i386                 randconfig-a011-20211129
i386                 randconfig-a013-20211201
i386                 randconfig-a016-20211201
i386                 randconfig-a011-20211201
i386                 randconfig-a014-20211201
i386                 randconfig-a012-20211201
i386                 randconfig-a015-20211201
hexagon              randconfig-r045-20211129
hexagon              randconfig-r041-20211129
s390                 randconfig-r044-20211129
riscv                randconfig-r042-20211129

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
