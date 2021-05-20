Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEC738B934
	for <lists+linux-erofs@lfdr.de>; Thu, 20 May 2021 23:51:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FmNjp5frlz306Q
	for <lists+linux-erofs@lfdr.de>; Fri, 21 May 2021 07:51:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FmNjg2FN5z302L
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 May 2021 07:51:29 +1000 (AEST)
IronPort-SDR: 0KKTKS4KCNKKdePNpDfx0e/pcfxFYRHXvxCpSWPQmVXukHjGA//dseifDOLtvwqGHvW8dtrxTd
 k05cMaBb8vpg==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="188475251"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="188475251"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2021 14:51:21 -0700
IronPort-SDR: +fOmVOwpJyVesSfRCiSa5vyOfgEEgZuC4Fx4SIwKX6o0wX+GgxlREeeucP7XY4d8vXwvKetqCR
 FmpB1H0cemLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="395067425"
Received: from lkp-server02.sh.intel.com (HELO 1b329be5b008) ([10.239.97.151])
 by orsmga003.jf.intel.com with ESMTP; 20 May 2021 14:51:20 -0700
Received: from kbuild by 1b329be5b008 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1ljqZb-0000pD-M3; Thu, 20 May 2021 21:51:19 +0000
Date: Fri, 21 May 2021 05:50:52 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <xiang@kernel.org>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 6f1f4cc13c421ba2a812060287cd322a8364d9bb
Message-ID: <60a6d9bc.oko5ItV3KNv/3pMn%lkp@intel.com>
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
branch HEAD: 6f1f4cc13c421ba2a812060287cd322a8364d9bb  erofs: fix error return code in erofs_read_superblock()

elapsed time: 721m

configs tested: 153
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     mpc5200_defconfig
openrisc                         alldefconfig
powerpc                      walnut_defconfig
mips                      malta_kvm_defconfig
mips                           mtx1_defconfig
sh                         microdev_defconfig
mips                         tb0219_defconfig
powerpc                       ebony_defconfig
mips                      pistachio_defconfig
microblaze                      mmu_defconfig
mips                      maltasmvp_defconfig
openrisc                    or1ksim_defconfig
arm                         shannon_defconfig
sh                      rts7751r2d1_defconfig
powerpc                      pasemi_defconfig
powerpc                     powernv_defconfig
mips                        qi_lb60_defconfig
arm                          badge4_defconfig
m68k                       m5208evb_defconfig
arm                          pcm027_defconfig
sh                         ap325rxa_defconfig
arm                         socfpga_defconfig
powerpc                 mpc8272_ads_defconfig
arm                           sama5_defconfig
m68k                       bvme6000_defconfig
xtensa                    xip_kc705_defconfig
mips                           jazz_defconfig
h8300                            alldefconfig
mips                   sb1250_swarm_defconfig
mips                         tb0287_defconfig
arm                         hackkit_defconfig
powerpc                     ep8248e_defconfig
arm                    vt8500_v6_v7_defconfig
arm                       aspeed_g4_defconfig
m68k                         amcore_defconfig
arc                          axs103_defconfig
arc                                 defconfig
m68k                        m5307c3_defconfig
m68k                         apollo_defconfig
mips                        bcm47xx_defconfig
xtensa                         virt_defconfig
m68k                       m5275evb_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                  mpc885_ads_defconfig
sh                            hp6xx_defconfig
sh                           se7721_defconfig
mips                  cavium_octeon_defconfig
arm                        mini2440_defconfig
arm                     am200epdkit_defconfig
powerpc                     tqm8548_defconfig
um                            kunit_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                           se7206_defconfig
powerpc                    mvme5100_defconfig
mips                        jmr3927_defconfig
arc                        nsim_700_defconfig
xtensa                  audio_kc705_defconfig
ia64                                defconfig
um                             i386_defconfig
x86_64                              defconfig
nios2                         3c120_defconfig
arc                     haps_hs_smp_defconfig
arm                         lubbock_defconfig
arm                          iop32x_defconfig
arm                         orion5x_defconfig
powerpc                      obs600_defconfig
arm                        keystone_defconfig
powerpc                     tqm5200_defconfig
arm                             ezx_defconfig
sh                          lboxre2_defconfig
arc                          axs101_defconfig
sh                          kfr2r09_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                        mvebu_v7_defconfig
powerpc                     stx_gp3_defconfig
arm                           sunxi_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20210520
x86_64               randconfig-a006-20210520
x86_64               randconfig-a005-20210520
x86_64               randconfig-a003-20210520
x86_64               randconfig-a004-20210520
x86_64               randconfig-a002-20210520
i386                 randconfig-a001-20210520
i386                 randconfig-a005-20210520
i386                 randconfig-a002-20210520
i386                 randconfig-a006-20210520
i386                 randconfig-a004-20210520
i386                 randconfig-a003-20210520
i386                 randconfig-a016-20210520
i386                 randconfig-a011-20210520
i386                 randconfig-a015-20210520
i386                 randconfig-a012-20210520
i386                 randconfig-a014-20210520
i386                 randconfig-a013-20210520
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-b001-20210520
x86_64               randconfig-a013-20210520
x86_64               randconfig-a014-20210520
x86_64               randconfig-a012-20210520
x86_64               randconfig-a016-20210520
x86_64               randconfig-a015-20210520
x86_64               randconfig-a011-20210520

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
