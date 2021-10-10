Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417A14283DD
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Oct 2021 23:37:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HSFdw6R7jz2yNT
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Oct 2021 08:37:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HSFds0sKSz2xtW
 for <linux-erofs@lists.ozlabs.org>; Mon, 11 Oct 2021 08:37:50 +1100 (AEDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="226665307"
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; d="scan'208";a="226665307"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2021 14:36:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; d="scan'208";a="440536915"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
 by orsmga006.jf.intel.com with ESMTP; 10 Oct 2021 14:36:45 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mZgUv-0001Yt-7f; Sun, 10 Oct 2021 21:36:45 +0000
Date: Mon, 11 Oct 2021 05:36:15 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 71dbc5464c5c1e9d99b1c620cde6392bdfd4bb03
Message-ID: <61635ccf.Xw9Y41JsgQFji8Zd%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 71dbc5464c5c1e9d99b1c620cde6392bdfd4bb03  erofs: add multiple device support

elapsed time: 724m

configs tested: 169
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211010
alpha                            alldefconfig
openrisc                 simple_smp_defconfig
powerpc                   motionpro_defconfig
mips                         tb0219_defconfig
ia64                          tiger_defconfig
arm                   milbeaut_m10v_defconfig
mips                          rb532_defconfig
powerpc                     rainier_defconfig
arm                            qcom_defconfig
powerpc                       ebony_defconfig
arm                        cerfcube_defconfig
m68k                        mvme147_defconfig
m68k                          amiga_defconfig
mips                        bcm47xx_defconfig
mips                          ath25_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     kilauea_defconfig
powerpc                  iss476-smp_defconfig
mips                           ip28_defconfig
sh                          polaris_defconfig
mips                            gpr_defconfig
powerpc                     tqm8560_defconfig
arm                         bcm2835_defconfig
arm                          exynos_defconfig
arm                          simpad_defconfig
arm                         at91_dt_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                           stm32_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                    sam440ep_defconfig
powerpc                      tqm8xx_defconfig
sh                ecovec24-romimage_defconfig
arm                     am200epdkit_defconfig
xtensa                  audio_kc705_defconfig
m68k                       m5249evb_defconfig
x86_64                              defconfig
microblaze                          defconfig
sh                        edosk7705_defconfig
m68k                         amcore_defconfig
arc                              alldefconfig
arm                          badge4_defconfig
arm                         cm_x300_defconfig
powerpc                    ge_imp3a_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                          rsk7203_defconfig
sh                 kfr2r09-romimage_defconfig
arm                          gemini_defconfig
powerpc                      arches_defconfig
arm                            mmp2_defconfig
mips                         bigsur_defconfig
mips                     cu1000-neo_defconfig
mips                            e55_defconfig
arc                          axs103_defconfig
mips                         tb0287_defconfig
sh                   sh7724_generic_defconfig
powerpc                      mgcoge_defconfig
powerpc                       holly_defconfig
arm                       aspeed_g4_defconfig
arc                            hsdk_defconfig
csky                                defconfig
openrisc                    or1ksim_defconfig
powerpc                          g5_defconfig
arm                        realview_defconfig
powerpc                     sequoia_defconfig
sparc                       sparc32_defconfig
arm                         orion5x_defconfig
m68k                         apollo_defconfig
arm                        neponset_defconfig
h8300                     edosk2674_defconfig
arm                        clps711x_defconfig
mips                      maltasmvp_defconfig
powerpc                        icon_defconfig
powerpc                       ppc64_defconfig
powerpc                      ppc6xx_defconfig
h8300                            alldefconfig
mips                          malta_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                        cell_defconfig
sh                           se7724_defconfig
sh                             espt_defconfig
arc                           tb10x_defconfig
s390                             alldefconfig
arm                      integrator_defconfig
arm                  randconfig-c002-20211010
x86_64               randconfig-c001-20211010
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20211010
x86_64               randconfig-a006-20211010
x86_64               randconfig-a001-20211010
x86_64               randconfig-a005-20211010
x86_64               randconfig-a002-20211010
x86_64               randconfig-a003-20211010
i386                 randconfig-a001-20211010
i386                 randconfig-a003-20211010
i386                 randconfig-a004-20211010
i386                 randconfig-a005-20211010
i386                 randconfig-a002-20211010
i386                 randconfig-a006-20211010
arc                  randconfig-r043-20211010
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
arm                  randconfig-c002-20211010
mips                 randconfig-c004-20211010
i386                 randconfig-c001-20211010
s390                 randconfig-c005-20211010
x86_64               randconfig-c007-20211010
powerpc              randconfig-c003-20211010
riscv                randconfig-c006-20211010
x86_64               randconfig-a015-20211010
x86_64               randconfig-a012-20211010
x86_64               randconfig-a016-20211010
x86_64               randconfig-a014-20211010
x86_64               randconfig-a013-20211010
x86_64               randconfig-a011-20211010
i386                 randconfig-a016-20211010
i386                 randconfig-a014-20211010
i386                 randconfig-a011-20211010
i386                 randconfig-a015-20211010
i386                 randconfig-a012-20211010
i386                 randconfig-a013-20211010
hexagon              randconfig-r041-20211010
s390                 randconfig-r044-20211010
riscv                randconfig-r042-20211010
hexagon              randconfig-r045-20211010

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
