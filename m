Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E98445B08
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Nov 2021 21:23:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HlZpN15cgz2yMV
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Nov 2021 07:23:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.31; helo=mga06.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HlZpH5xBvz2x9V
 for <linux-erofs@lists.ozlabs.org>; Fri,  5 Nov 2021 07:23:13 +1100 (AEDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="292622691"
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; d="scan'208";a="292622691"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2021 13:22:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; d="scan'208";a="468611889"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
 by orsmga002.jf.intel.com with ESMTP; 04 Nov 2021 13:22:08 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mijFP-0006jg-Ak; Thu, 04 Nov 2021 20:22:07 +0000
Date: Fri, 05 Nov 2021 04:21:28 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <xiang@kernel.org>
Subject: [xiang-erofs:fixes] BUILD SUCCESS
 1eceffaec88b336f021010f0eeea1a3948afd73d
Message-ID: <618440c8.EG5RNoNN/CWHQl/w%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git fixes
branch HEAD: 1eceffaec88b336f021010f0eeea1a3948afd73d  erofs: fix unsafe pagevec reuse of hooked pclusters

elapsed time: 1469m

configs tested: 316
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211103
i386                 randconfig-c001-20211105
i386                 randconfig-c001-20211104
powerpc                   motionpro_defconfig
ia64                        generic_defconfig
powerpc                     tqm8560_defconfig
mips                           gcw0_defconfig
powerpc                      walnut_defconfig
mips                     cu1000-neo_defconfig
m68k                       bvme6000_defconfig
parisc                           allyesconfig
riscv                    nommu_k210_defconfig
arm                      tct_hammer_defconfig
powerpc                    klondike_defconfig
parisc                generic-32bit_defconfig
powerpc                    sam440ep_defconfig
sh                 kfr2r09-romimage_defconfig
mips                      bmips_stb_defconfig
xtensa                  audio_kc705_defconfig
arm                       spear13xx_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                       imx_v4_v5_defconfig
sh                               alldefconfig
powerpc                 canyonlands_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     ppa8548_defconfig
arm                     eseries_pxa_defconfig
mips                        qi_lb60_defconfig
arm                           sama7_defconfig
powerpc                   microwatt_defconfig
sh                        sh7785lcr_defconfig
sh                          kfr2r09_defconfig
powerpc                      mgcoge_defconfig
arm                          exynos_defconfig
riscv                             allnoconfig
m68k                        stmark2_defconfig
arm                          gemini_defconfig
powerpc                          g5_defconfig
arm                         lpc32xx_defconfig
arm                          collie_defconfig
arm                         at91_dt_defconfig
m68k                       m5208evb_defconfig
powerpc                        fsp2_defconfig
arm                  colibri_pxa270_defconfig
m68k                       m5475evb_defconfig
mips                     loongson1b_defconfig
m68k                         amcore_defconfig
powerpc                    adder875_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                   secureedge5410_defconfig
microblaze                      mmu_defconfig
arm                           sunxi_defconfig
powerpc                 linkstation_defconfig
arm                         s3c6400_defconfig
powerpc                         wii_defconfig
mips                  cavium_octeon_defconfig
arm                             pxa_defconfig
xtensa                          iss_defconfig
sh                           se7619_defconfig
powerpc                 mpc85xx_cds_defconfig
nios2                            alldefconfig
mips                      fuloong2e_defconfig
powerpc                     mpc512x_defconfig
arm                        oxnas_v6_defconfig
arm                         lpc18xx_defconfig
powerpc                    amigaone_defconfig
um                           x86_64_defconfig
arm                       multi_v4t_defconfig
nds32                             allnoconfig
csky                             alldefconfig
arm                          ixp4xx_defconfig
openrisc                 simple_smp_defconfig
arm                          simpad_defconfig
arm                            mmp2_defconfig
arm                         mv78xx0_defconfig
powerpc                   currituck_defconfig
um                               alldefconfig
sh                      rts7751r2d1_defconfig
sh                ecovec24-romimage_defconfig
h8300                               defconfig
arm                           corgi_defconfig
nios2                         10m50_defconfig
mips                           rs90_defconfig
sh                        apsh4ad0a_defconfig
sh                        edosk7705_defconfig
mips                         tb0287_defconfig
sh                             sh03_defconfig
mips                      pic32mzda_defconfig
mips                        omega2p_defconfig
sh                        sh7757lcr_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                       aspeed_g4_defconfig
mips                           mtx1_defconfig
powerpc                      cm5200_defconfig
powerpc                      acadia_defconfig
powerpc                          allyesconfig
sh                   sh7724_generic_defconfig
powerpc                     kmeter1_defconfig
arc                        vdk_hs38_defconfig
sh                          landisk_defconfig
powerpc                      katmai_defconfig
sh                        edosk7760_defconfig
mips                malta_qemu_32r6_defconfig
sh                             espt_defconfig
sh                           se7712_defconfig
arc                              alldefconfig
arc                        nsimosci_defconfig
powerpc                      tqm8xx_defconfig
powerpc                   bluestone_defconfig
arc                            hsdk_defconfig
sh                               allmodconfig
openrisc                            defconfig
powerpc                      arches_defconfig
arm                       omap2plus_defconfig
arm                        shmobile_defconfig
mips                            ar7_defconfig
arm                            hisi_defconfig
powerpc                    gamecube_defconfig
arm                         orion5x_defconfig
powerpc                       ppc64_defconfig
powerpc                     tqm8555_defconfig
mips                          rb532_defconfig
m68k                                defconfig
openrisc                         alldefconfig
powerpc                     mpc83xx_defconfig
powerpc                     asp8347_defconfig
s390                             alldefconfig
powerpc                     tqm8548_defconfig
arm                         axm55xx_defconfig
powerpc                      ep88xc_defconfig
sh                          rsk7269_defconfig
sh                           se7751_defconfig
arm                            dove_defconfig
arc                          axs101_defconfig
arm                       aspeed_g5_defconfig
mips                           xway_defconfig
arc                        nsim_700_defconfig
sh                        dreamcast_defconfig
arm                        trizeps4_defconfig
powerpc                  storcenter_defconfig
arm                            zeus_defconfig
arm                      footbridge_defconfig
powerpc                   lite5200b_defconfig
mips                     loongson1c_defconfig
arm                           tegra_defconfig
powerpc                 mpc836x_mds_defconfig
sh                          polaris_defconfig
arm                         assabet_defconfig
mips                       capcella_defconfig
sparc                       sparc64_defconfig
arm                     am200epdkit_defconfig
sh                           se7721_defconfig
parisc                generic-64bit_defconfig
sh                   sh7770_generic_defconfig
powerpc                       eiger_defconfig
sparc                       sparc32_defconfig
mips                           ip22_defconfig
powerpc                     pq2fads_defconfig
arm                         bcm2835_defconfig
arm                        multi_v5_defconfig
arc                                 defconfig
arm                            pleb_defconfig
ia64                                defconfig
powerpc               mpc834x_itxgp_defconfig
sparc                               defconfig
powerpc                     ep8248e_defconfig
powerpc                      bamboo_defconfig
powerpc                     sequoia_defconfig
riscv                          rv32_defconfig
arm                        spear6xx_defconfig
powerpc                     rainier_defconfig
xtensa                  cadence_csp_defconfig
m68k                       m5249evb_defconfig
mips                        bcm63xx_defconfig
arm                           u8500_defconfig
arm                         s5pv210_defconfig
x86_64                              defconfig
powerpc                     skiroot_defconfig
m68k                          amiga_defconfig
arm                     davinci_all_defconfig
mips                         cobalt_defconfig
openrisc                  or1klitex_defconfig
powerpc                      ppc6xx_defconfig
mips                      maltasmvp_defconfig
arm64                            alldefconfig
h8300                    h8300h-sim_defconfig
powerpc                     redwood_defconfig
powerpc                     pseries_defconfig
m68k                            mac_defconfig
mips                     cu1830-neo_defconfig
arm                          pxa168_defconfig
sh                     sh7710voipgw_defconfig
powerpc                       holly_defconfig
arc                     nsimosci_hs_defconfig
powerpc                         ps3_defconfig
arm                        mvebu_v7_defconfig
powerpc                     tqm8540_defconfig
arm                    vt8500_v6_v7_defconfig
arm                            qcom_defconfig
sh                          r7785rp_defconfig
arm                        cerfcube_defconfig
mips                     loongson2k_defconfig
arm                  randconfig-c002-20211103
arm                  randconfig-c002-20211104
arm                  randconfig-c002-20211105
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                                defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20211104
x86_64               randconfig-a006-20211104
x86_64               randconfig-a001-20211104
x86_64               randconfig-a002-20211104
x86_64               randconfig-a003-20211104
x86_64               randconfig-a005-20211104
i386                 randconfig-a005-20211104
i386                 randconfig-a001-20211104
i386                 randconfig-a003-20211104
i386                 randconfig-a004-20211104
i386                 randconfig-a006-20211104
i386                 randconfig-a002-20211104
x86_64               randconfig-a012-20211103
x86_64               randconfig-a015-20211103
x86_64               randconfig-a016-20211103
x86_64               randconfig-a011-20211103
x86_64               randconfig-a013-20211103
x86_64               randconfig-a014-20211103
i386                 randconfig-a014-20211103
i386                 randconfig-a016-20211103
i386                 randconfig-a013-20211103
i386                 randconfig-a015-20211103
i386                 randconfig-a011-20211103
i386                 randconfig-a012-20211103
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
mips                 randconfig-c004-20211104
i386                 randconfig-c001-20211104
arm                  randconfig-c002-20211104
s390                 randconfig-c005-20211104
riscv                randconfig-c006-20211104
powerpc              randconfig-c003-20211104
x86_64               randconfig-c007-20211104
mips                 randconfig-c004-20211105
i386                 randconfig-c001-20211105
arm                  randconfig-c002-20211105
s390                 randconfig-c005-20211105
riscv                randconfig-c006-20211105
powerpc              randconfig-c003-20211105
x86_64               randconfig-c007-20211105
mips                 randconfig-c004-20211103
arm                  randconfig-c002-20211103
i386                 randconfig-c001-20211103
s390                 randconfig-c005-20211103
powerpc              randconfig-c003-20211103
riscv                randconfig-c006-20211103
x86_64               randconfig-c007-20211103
x86_64               randconfig-a006-20211103
x86_64               randconfig-a004-20211103
x86_64               randconfig-a001-20211103
x86_64               randconfig-a002-20211103
x86_64               randconfig-a005-20211103
x86_64               randconfig-a003-20211103
i386                 randconfig-a005-20211103
i386                 randconfig-a003-20211103
i386                 randconfig-a001-20211103
i386                 randconfig-a004-20211103
i386                 randconfig-a006-20211103
i386                 randconfig-a002-20211103
x86_64               randconfig-a012-20211104
x86_64               randconfig-a016-20211104
x86_64               randconfig-a015-20211104
x86_64               randconfig-a013-20211104
x86_64               randconfig-a011-20211104
x86_64               randconfig-a014-20211104
i386                 randconfig-a016-20211104
i386                 randconfig-a014-20211104
i386                 randconfig-a015-20211104
i386                 randconfig-a013-20211104
i386                 randconfig-a011-20211104
i386                 randconfig-a012-20211104
hexagon              randconfig-r041-20211104
riscv                randconfig-r042-20211104
s390                 randconfig-r044-20211104
hexagon              randconfig-r045-20211104
hexagon              randconfig-r041-20211103
hexagon              randconfig-r045-20211103
hexagon              randconfig-r041-20211105
hexagon              randconfig-r045-20211105

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
