Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D721288F97
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Oct 2020 19:10:32 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C7F2D5PgCzDqbm
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Oct 2020 04:10:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C7F2725h3zDqZj
 for <linux-erofs@lists.ozlabs.org>; Sat, 10 Oct 2020 04:10:17 +1100 (AEDT)
IronPort-SDR: xHpKOp+Nikq0mEkN5f2n9KTVZ/Jqa4uYSFI2oq0rB9vheXuCYqnb6Q1prTOF3CapCoLBcu08tY
 JWQsIaLU5vQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="165625918"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; d="scan'208";a="165625918"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2020 10:10:12 -0700
IronPort-SDR: F3hW4BdyuzPBL7SHccR4Vmv+P1RFdTrDkb20n8taJi0J6Sk/OEnSMNUTdxc2f1zTe9RUubEQQ4
 vxSvYPttZcYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; d="scan'208";a="345108978"
Received: from lkp-server02.sh.intel.com (HELO 80eb06af76cf) ([10.239.97.151])
 by orsmga008.jf.intel.com with ESMTP; 09 Oct 2020 10:10:10 -0700
Received: from kbuild by 80eb06af76cf with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kQvuE-0000dt-5J; Fri, 09 Oct 2020 17:10:10 +0000
Date: Sat, 10 Oct 2020 01:09:42 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 915f4c9358db6f96f08934dd683ae297aaa0fb91
Message-ID: <5f809956.TSwLjQTmUi9VoAAS%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git  dev
branch HEAD: 915f4c9358db6f96f08934dd683ae297aaa0fb91  erofs: remove unnecessary enum entries

elapsed time: 721m

configs tested: 185
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
riscv                    nommu_virt_defconfig
powerpc                      katmai_defconfig
mips                      loongson3_defconfig
s390                                defconfig
arm                            lart_defconfig
m68k                          atari_defconfig
powerpc                     pseries_defconfig
mips                       rbtx49xx_defconfig
arc                     nsimosci_hs_defconfig
sh                        sh7757lcr_defconfig
powerpc                     akebono_defconfig
s390                          debug_defconfig
arm                           corgi_defconfig
sh                          rsk7264_defconfig
mips                     decstation_defconfig
powerpc                 mpc832x_mds_defconfig
arm                        mvebu_v5_defconfig
arm                           omap1_defconfig
mips                   sb1250_swarm_defconfig
m68k                          hp300_defconfig
arc                    vdk_hs38_smp_defconfig
sparc64                          alldefconfig
arm                     am200epdkit_defconfig
arm                        magician_defconfig
powerpc                      ppc44x_defconfig
arc                          axs101_defconfig
powerpc                 mpc8540_ads_defconfig
mips                         bigsur_defconfig
arm                       imx_v6_v7_defconfig
i386                             allyesconfig
arc                      axs103_smp_defconfig
arm                         s3c6400_defconfig
arm                           efm32_defconfig
powerpc                 mpc8560_ads_defconfig
arm                             rpc_defconfig
m68k                          sun3x_defconfig
mips                      pistachio_defconfig
arm                  colibri_pxa300_defconfig
arm                          moxart_defconfig
arm                            u300_defconfig
mips                      maltasmvp_defconfig
arm                          simpad_defconfig
powerpc                   motionpro_defconfig
sparc64                             defconfig
arc                        nsim_700_defconfig
arm                        multi_v7_defconfig
powerpc                          allyesconfig
sh                           se7724_defconfig
arm                       aspeed_g5_defconfig
sh                           sh2007_defconfig
sh                        sh7785lcr_defconfig
sh                   rts7751r2dplus_defconfig
arm                         cm_x300_defconfig
powerpc                      walnut_defconfig
mips                     loongson1b_defconfig
sh                             shx3_defconfig
arm                       spear13xx_defconfig
mips                 decstation_r4k_defconfig
powerpc                      obs600_defconfig
riscv                               defconfig
mips                           gcw0_defconfig
nios2                         3c120_defconfig
sh                          rsk7203_defconfig
sh                        dreamcast_defconfig
xtensa                              defconfig
arm                       mainstone_defconfig
powerpc                     tqm5200_defconfig
um                             i386_defconfig
openrisc                 simple_smp_defconfig
sh                        edosk7705_defconfig
sh                   secureedge5410_defconfig
arm                         mv78xx0_defconfig
arm                         assabet_defconfig
mips                          ath25_defconfig
powerpc                      pcm030_defconfig
xtensa                    xip_kc705_defconfig
arm                          pcm027_defconfig
sh                         microdev_defconfig
arm                            xcep_defconfig
parisc                generic-32bit_defconfig
microblaze                    nommu_defconfig
openrisc                            defconfig
powerpc                      cm5200_defconfig
powerpc                       eiger_defconfig
arm                          imote2_defconfig
powerpc                   currituck_defconfig
arm                           tegra_defconfig
mips                            gpr_defconfig
arm                          collie_defconfig
arm                         nhk8815_defconfig
arm                         lpc18xx_defconfig
openrisc                         alldefconfig
mips                      pic32mzda_defconfig
arm                          pxa168_defconfig
arc                        vdk_hs38_defconfig
arm                        trizeps4_defconfig
mips                           ip28_defconfig
powerpc                     powernv_defconfig
m68k                         apollo_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                  mpc885_ads_defconfig
mips                        qi_lb60_defconfig
c6x                        evmc6472_defconfig
sh                     sh7710voipgw_defconfig
m68k                          multi_defconfig
sh                 kfr2r09-romimage_defconfig
ia64                             alldefconfig
arm                        oxnas_v6_defconfig
h8300                     edosk2674_defconfig
sh                             espt_defconfig
arm                   milbeaut_m10v_defconfig
mips                    maltaup_xpa_defconfig
arm                     davinci_all_defconfig
sh                      rts7751r2d1_defconfig
sparc                            allyesconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201009
i386                 randconfig-a005-20201009
i386                 randconfig-a001-20201009
i386                 randconfig-a004-20201009
i386                 randconfig-a002-20201009
i386                 randconfig-a003-20201009
x86_64               randconfig-a012-20201009
x86_64               randconfig-a015-20201009
x86_64               randconfig-a013-20201009
x86_64               randconfig-a014-20201009
x86_64               randconfig-a011-20201009
x86_64               randconfig-a016-20201009
i386                 randconfig-a015-20201009
i386                 randconfig-a013-20201009
i386                 randconfig-a014-20201009
i386                 randconfig-a016-20201009
i386                 randconfig-a011-20201009
i386                 randconfig-a012-20201009
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201009
x86_64               randconfig-a003-20201009
x86_64               randconfig-a005-20201009
x86_64               randconfig-a001-20201009
x86_64               randconfig-a002-20201009
x86_64               randconfig-a006-20201009

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
