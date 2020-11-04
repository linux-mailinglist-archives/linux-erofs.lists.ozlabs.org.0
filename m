Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3B12A5AD8
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Nov 2020 01:00:54 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CQmyB3FzjzDqXd
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Nov 2020 11:00:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CQmy32fbpzDqJ2
 for <linux-erofs@lists.ozlabs.org>; Wed,  4 Nov 2020 11:00:38 +1100 (AEDT)
IronPort-SDR: cxF2spGqfQvFl1mRSpI3yS8DOD4a1uJ9el+enKcpIkTY3hiHjPb5/4bHtGjxtFZiw4vB2K9jlQ
 V7VKbzua1iew==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="148995062"
X-IronPort-AV: E=Sophos;i="5.77,449,1596524400"; d="scan'208";a="148995062"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 16:00:34 -0800
IronPort-SDR: HQKNCA4jxbmhG5+aVHItYT5ghsD1tvNmsszkSFhoxfNVgHjIaVPFqbw/OZ/SwY75a+dM0NP1ve
 999ja2W6FSIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,449,1596524400"; d="scan'208";a="305978642"
Received: from lkp-server02.sh.intel.com (HELO e61783667810) ([10.239.97.151])
 by fmsmga008.fm.intel.com with ESMTP; 03 Nov 2020 16:00:33 -0800
Received: from kbuild by e61783667810 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1ka6E4-0000Zc-Qw; Wed, 04 Nov 2020 00:00:32 +0000
Date: Wed, 04 Nov 2020 08:00:06 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:fixes] BUILD SUCCESS
 89210981f3745d146d40f00fa17bc430e6fc3b3c
Message-ID: <5fa1ef06.3wDvFLz9U2xHSQeD%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git  fixes
branch HEAD: 89210981f3745d146d40f00fa17bc430e6fc3b3c  erofs: fix setting up pcluster for temporary pages

elapsed time: 721m

configs tested: 183
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                         amcore_defconfig
sh                           sh2007_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                     kilauea_defconfig
mips                        nlm_xlp_defconfig
mips                  cavium_octeon_defconfig
mips                     loongson1b_defconfig
arm                           h3600_defconfig
powerpc                     sequoia_defconfig
sh                        sh7757lcr_defconfig
arm                        spear3xx_defconfig
powerpc                    sam440ep_defconfig
openrisc                         alldefconfig
sh                             espt_defconfig
arm                            xcep_defconfig
arc                           tb10x_defconfig
sh                          rsk7269_defconfig
powerpc                      obs600_defconfig
powerpc                mpc7448_hpc2_defconfig
ia64                             alldefconfig
arm                            zeus_defconfig
powerpc                     tqm5200_defconfig
sh                         ecovec24_defconfig
ia64                          tiger_defconfig
m68k                          atari_defconfig
powerpc                     taishan_defconfig
arm                         palmz72_defconfig
powerpc                 mpc85xx_cds_defconfig
riscv                            alldefconfig
powerpc                      arches_defconfig
powerpc                    gamecube_defconfig
arm                          pxa3xx_defconfig
mips                     cu1830-neo_defconfig
mips                      bmips_stb_defconfig
powerpc                      katmai_defconfig
arm                           spitz_defconfig
powerpc                   currituck_defconfig
powerpc                     redwood_defconfig
arm                        shmobile_defconfig
arm                         lubbock_defconfig
arm                        vexpress_defconfig
powerpc                     mpc512x_defconfig
mips                          rm200_defconfig
powerpc                    mvme5100_defconfig
mips                             allmodconfig
powerpc                        cell_defconfig
arc                          axs103_defconfig
sh                          rsk7203_defconfig
powerpc                    adder875_defconfig
powerpc                      cm5200_defconfig
arm                        mvebu_v5_defconfig
m68k                          sun3x_defconfig
mips                           gcw0_defconfig
xtensa                    smp_lx200_defconfig
sparc64                             defconfig
powerpc                     tqm8555_defconfig
arm                           h5000_defconfig
arm                         orion5x_defconfig
parisc                generic-64bit_defconfig
sh                   secureedge5410_defconfig
arm                          simpad_defconfig
powerpc                      ppc44x_defconfig
mips                      malta_kvm_defconfig
powerpc                     ep8248e_defconfig
arm                          pcm027_defconfig
powerpc                     stx_gp3_defconfig
arm                       aspeed_g5_defconfig
powerpc                     pseries_defconfig
arm                           viper_defconfig
m68k                          hp300_defconfig
powerpc                      walnut_defconfig
arm                         s5pv210_defconfig
arm                            dove_defconfig
mips                            e55_defconfig
openrisc                    or1ksim_defconfig
arm                      tct_hammer_defconfig
powerpc                      acadia_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                           se7722_defconfig
m68k                        mvme16x_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                ecovec24-romimage_defconfig
powerpc                  mpc885_ads_defconfig
sh                           se7751_defconfig
sh                   sh7770_generic_defconfig
riscv                            allmodconfig
powerpc                      tqm8xx_defconfig
powerpc                      ep88xc_defconfig
sh                               allmodconfig
mips                     cu1000-neo_defconfig
sh                           se7705_defconfig
sh                          r7780mp_defconfig
arm                       imx_v6_v7_defconfig
mips                            gpr_defconfig
sh                         apsh4a3a_defconfig
powerpc                     ppa8548_defconfig
powerpc                         ps3_defconfig
powerpc                     rainier_defconfig
mips                       bmips_be_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                       spear13xx_defconfig
arm                          pxa168_defconfig
xtensa                  nommu_kc705_defconfig
mips                        qi_lb60_defconfig
arm                       versatile_defconfig
sh                            shmin_defconfig
powerpc                 canyonlands_defconfig
arm                         lpc18xx_defconfig
ia64                                defconfig
nds32                             allnoconfig
xtensa                           allyesconfig
nios2                         3c120_defconfig
m68k                       m5475evb_defconfig
powerpc                          g5_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201103
x86_64               randconfig-a005-20201103
x86_64               randconfig-a003-20201103
x86_64               randconfig-a002-20201103
x86_64               randconfig-a006-20201103
x86_64               randconfig-a001-20201103
i386                 randconfig-a004-20201103
i386                 randconfig-a006-20201103
i386                 randconfig-a005-20201103
i386                 randconfig-a001-20201103
i386                 randconfig-a002-20201103
i386                 randconfig-a003-20201103
i386                 randconfig-a013-20201103
i386                 randconfig-a015-20201103
i386                 randconfig-a014-20201103
i386                 randconfig-a016-20201103
i386                 randconfig-a011-20201103
i386                 randconfig-a012-20201103
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20201103
x86_64               randconfig-a015-20201103
x86_64               randconfig-a011-20201103
x86_64               randconfig-a013-20201103
x86_64               randconfig-a014-20201103
x86_64               randconfig-a016-20201103

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
