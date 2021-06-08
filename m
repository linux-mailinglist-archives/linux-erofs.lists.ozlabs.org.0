Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACDB39EDD5
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jun 2021 06:53:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FzdDW5jBXz2yyM
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jun 2021 14:53:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FzdDR1VY9z2yWT
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Jun 2021 14:53:40 +1000 (AEST)
IronPort-SDR: mCQUE8jY7jkzfYhAs6JGJESqPzvEMU5lvoIb9susQJkGUTK/Kcnk1WFawiloMQ3VNfWR0RtkRi
 Dj0GNbnx4idA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="290400551"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; d="scan'208";a="290400551"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2021 21:53:36 -0700
IronPort-SDR: qwendfEKDv+QWTUaMlxrHu9/pKEmRN2TVfSzeXrGPbWKXZoGQkIC5lMNpb3SLGDp3siZ2zudnV
 cd2aACNC6XJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; d="scan'208";a="476466720"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
 by FMSMGA003.fm.intel.com with ESMTP; 07 Jun 2021 21:53:34 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lqTk6-0008oU-AJ; Tue, 08 Jun 2021 04:53:34 +0000
Date: Tue, 08 Jun 2021 12:53:15 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 c5fcb51111b85323cafe3f02784f7f0bf6a7cf07
Message-ID: <60bef7bb.OI8BGKB7xabgPetO%lkp@intel.com>
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
branch HEAD: c5fcb51111b85323cafe3f02784f7f0bf6a7cf07  erofs: clean up file headers & footers

elapsed time: 727m

configs tested: 186
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                     loongson2k_defconfig
sh                          r7780mp_defconfig
arc                    vdk_hs38_smp_defconfig
arm                      pxa255-idp_defconfig
arm                         assabet_defconfig
arc                          axs103_defconfig
arm                     davinci_all_defconfig
powerpc64                           defconfig
powerpc                     sbc8548_defconfig
arm                       versatile_defconfig
arm                        oxnas_v6_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     akebono_defconfig
openrisc                  or1klitex_defconfig
powerpc                       ppc64_defconfig
arm                        multi_v7_defconfig
powerpc                    sam440ep_defconfig
m68k                         amcore_defconfig
arm                           viper_defconfig
sh                     sh7710voipgw_defconfig
mips                         tb0219_defconfig
sh                ecovec24-romimage_defconfig
arm                            mmp2_defconfig
arm                           tegra_defconfig
xtensa                           alldefconfig
powerpc                      makalu_defconfig
mips                          rm200_defconfig
powerpc                 mpc8560_ads_defconfig
arm                           omap1_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                             sh03_defconfig
arm                           sama5_defconfig
mips                        omega2p_defconfig
s390                             alldefconfig
sh                            migor_defconfig
m68k                            q40_defconfig
powerpc                 mpc8272_ads_defconfig
arm                             ezx_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                           se7343_defconfig
arc                     nsimosci_hs_defconfig
powerpc                     powernv_defconfig
mips                           rs90_defconfig
arm                         mv78xx0_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          simpad_defconfig
sh                   sh7724_generic_defconfig
mips                       capcella_defconfig
mips                           ip32_defconfig
powerpc                     skiroot_defconfig
powerpc                  mpc866_ads_defconfig
sh                 kfr2r09-romimage_defconfig
arm                            lart_defconfig
powerpc                   motionpro_defconfig
ia64                             allmodconfig
arm                      jornada720_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                    adder875_defconfig
x86_64                           alldefconfig
arm                            hisi_defconfig
arm                             pxa_defconfig
arm                        shmobile_defconfig
sh                   sh7770_generic_defconfig
m68k                                defconfig
xtensa                           allyesconfig
arc                            hsdk_defconfig
mips                       bmips_be_defconfig
s390                                defconfig
powerpc                      pasemi_defconfig
arm                        realview_defconfig
mips                           ci20_defconfig
arm                         axm55xx_defconfig
mips                         db1xxx_defconfig
arm                      footbridge_defconfig
nds32                             allnoconfig
sh                          sdk7780_defconfig
mips                           jazz_defconfig
arm                        mvebu_v5_defconfig
arc                        nsimosci_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                 mpc832x_mds_defconfig
sh                             espt_defconfig
arc                           tb10x_defconfig
powerpc                         wii_defconfig
powerpc                         ps3_defconfig
powerpc                     mpc5200_defconfig
m68k                       m5208evb_defconfig
sparc                       sparc64_defconfig
powerpc                 canyonlands_defconfig
sh                          lboxre2_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                           ip28_defconfig
powerpc                      ep88xc_defconfig
mips                        maltaup_defconfig
arm                        vexpress_defconfig
mips                          rb532_defconfig
mips                         tb0226_defconfig
powerpc                     ppa8548_defconfig
um                           x86_64_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                            qcom_defconfig
mips                           mtx1_defconfig
arm                         s5pv210_defconfig
nios2                               defconfig
arc                        vdk_hs38_defconfig
nios2                         10m50_defconfig
parisc                              defconfig
sh                         microdev_defconfig
sh                     magicpanelr2_defconfig
sh                      rts7751r2d1_defconfig
sh                                  defconfig
powerpc                        warp_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                        fsp2_defconfig
x86_64                              defconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210607
i386                 randconfig-a006-20210607
i386                 randconfig-a004-20210607
i386                 randconfig-a002-20210607
i386                 randconfig-a001-20210607
i386                 randconfig-a005-20210607
x86_64               randconfig-a015-20210607
x86_64               randconfig-a011-20210607
x86_64               randconfig-a014-20210607
x86_64               randconfig-a012-20210607
x86_64               randconfig-a016-20210607
x86_64               randconfig-a013-20210607
i386                 randconfig-a015-20210607
i386                 randconfig-a013-20210607
i386                 randconfig-a011-20210607
i386                 randconfig-a016-20210607
i386                 randconfig-a014-20210607
i386                 randconfig-a012-20210607
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210607
x86_64               randconfig-a002-20210607
x86_64               randconfig-a004-20210607
x86_64               randconfig-a003-20210607
x86_64               randconfig-a006-20210607
x86_64               randconfig-a005-20210607
x86_64               randconfig-a001-20210607

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
