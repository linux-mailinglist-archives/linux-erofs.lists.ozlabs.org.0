Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EC45F349B80
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Mar 2021 22:21:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F5yhD6NpDz30Bk
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Mar 2021 08:21:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F5yhC1HfFz2yR1
 for <linux-erofs@lists.ozlabs.org>; Fri, 26 Mar 2021 08:20:53 +1100 (AEDT)
IronPort-SDR: h9lsng+UFvPad96bYRT7mvaV/Gf+DoZkss6KqLPPT3fVwsOApU3f9CndMfMeFQRy/JVRLC2GtE
 4vg+89ngaWkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="171000214"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; d="scan'208";a="171000214"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2021 14:20:49 -0700
IronPort-SDR: VXM8M63kbtLw/CFqP+9hNJBD2aRoFo5qcx+ghlXK77lIH0hTqKQoD+DRLUfa1KAdAG2jEW9Tv6
 xfJXX1mKX3gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; d="scan'208";a="514809064"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
 by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2021 14:20:47 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lPXPL-0002Gg-9B; Thu, 25 Mar 2021 21:20:47 +0000
Date: Fri, 26 Mar 2021 05:19:48 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:erofs/bigpcluster] BUILD SUCCESS
 16a26a97614f95067d504448db4f54a3b88aed3b
Message-ID: <605cfe74.ab7RpVeB0BhZZPuM%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git erofs/bigpcluster
branch HEAD: 16a26a97614f95067d504448db4f54a3b88aed3b  erofs: support decompress big pcluster for lz4 backend

elapsed time: 720m

configs tested: 206
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                           ip28_defconfig
powerpc                   lite5200b_defconfig
arm                         s5pv210_defconfig
powerpc                   currituck_defconfig
h8300                            alldefconfig
powerpc                     ksi8560_defconfig
powerpc                  mpc885_ads_defconfig
xtensa                         virt_defconfig
arm                           corgi_defconfig
powerpc64                           defconfig
sh                            titan_defconfig
m68k                        m5407c3_defconfig
mips                        qi_lb60_defconfig
mips                         tb0226_defconfig
arm                              alldefconfig
sh                               alldefconfig
m68k                       m5475evb_defconfig
sh                   secureedge5410_defconfig
arm                        cerfcube_defconfig
powerpc                     mpc5200_defconfig
arm                          pxa3xx_defconfig
sh                          rsk7264_defconfig
csky                                defconfig
sh                     sh7710voipgw_defconfig
m68k                        stmark2_defconfig
arm                       mainstone_defconfig
mips                       bmips_be_defconfig
arm                        multi_v7_defconfig
s390                          debug_defconfig
arc                      axs103_smp_defconfig
arm                        keystone_defconfig
sh                           se7619_defconfig
arm                        spear3xx_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                           gcw0_defconfig
arc                         haps_hs_defconfig
um                             i386_defconfig
arm                          badge4_defconfig
sh                           se7780_defconfig
alpha                            alldefconfig
mips                      pic32mzda_defconfig
ia64                          tiger_defconfig
parisc                generic-32bit_defconfig
mips                         db1xxx_defconfig
powerpc                      cm5200_defconfig
arm                       cns3420vb_defconfig
mips                         tb0287_defconfig
um                                allnoconfig
m68k                          atari_defconfig
arm                          pcm027_defconfig
microblaze                      mmu_defconfig
mips                           ip27_defconfig
sparc64                             defconfig
mips                       rbtx49xx_defconfig
ia64                      gensparse_defconfig
arm                      jornada720_defconfig
mips                     loongson1c_defconfig
powerpc                     sequoia_defconfig
powerpc                      katmai_defconfig
powerpc                     sbc8548_defconfig
arm                   milbeaut_m10v_defconfig
arm                           sunxi_defconfig
arm                       aspeed_g5_defconfig
microblaze                          defconfig
mips                  cavium_octeon_defconfig
powerpc                       ppc64_defconfig
m68k                           sun3_defconfig
xtensa                  cadence_csp_defconfig
mips                     cu1830-neo_defconfig
powerpc                   bluestone_defconfig
powerpc                     redwood_defconfig
arm                             mxs_defconfig
riscv                            alldefconfig
powerpc                     pq2fads_defconfig
sh                        sh7763rdp_defconfig
arm                         vf610m4_defconfig
powerpc                      acadia_defconfig
s390                             alldefconfig
powerpc                 mpc834x_mds_defconfig
arc                          axs103_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     tqm5200_defconfig
powerpc                 linkstation_defconfig
mips                          malta_defconfig
csky                             alldefconfig
powerpc                     tqm8548_defconfig
arm                        multi_v5_defconfig
sh                           sh2007_defconfig
powerpc                        fsp2_defconfig
arm                            xcep_defconfig
m68k                        mvme147_defconfig
ia64                             allmodconfig
m68k                          amiga_defconfig
arc                            hsdk_defconfig
arm                          imote2_defconfig
xtensa                    xip_kc705_defconfig
mips                  maltasmvp_eva_defconfig
mips                          rm200_defconfig
arm                         lpc32xx_defconfig
mips                      maltaaprp_defconfig
sh                          lboxre2_defconfig
arm                         axm55xx_defconfig
ia64                        generic_defconfig
m68k                            mac_defconfig
sh                         ecovec24_defconfig
nds32                            alldefconfig
arm                           spitz_defconfig
powerpc                        icon_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                            dove_defconfig
arm                          gemini_defconfig
sh                           se7751_defconfig
powerpc                    klondike_defconfig
sh                           se7343_defconfig
openrisc                    or1ksim_defconfig
m68k                                defconfig
powerpc                      pasemi_defconfig
arm64                            alldefconfig
arm                       multi_v4t_defconfig
arm                          ixp4xx_defconfig
arc                        nsimosci_defconfig
sh                          polaris_defconfig
arm                       imx_v6_v7_defconfig
mips                       lemote2f_defconfig
powerpc                     powernv_defconfig
mips                 decstation_r4k_defconfig
arm                       aspeed_g4_defconfig
sh                          kfr2r09_defconfig
mips                             allmodconfig
mips                           ip32_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
s390                                defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210325
x86_64               randconfig-a003-20210325
x86_64               randconfig-a006-20210325
x86_64               randconfig-a001-20210325
x86_64               randconfig-a005-20210325
x86_64               randconfig-a004-20210325
i386                 randconfig-a003-20210325
i386                 randconfig-a004-20210325
i386                 randconfig-a001-20210325
i386                 randconfig-a002-20210325
i386                 randconfig-a006-20210325
i386                 randconfig-a005-20210325
i386                 randconfig-a014-20210325
i386                 randconfig-a011-20210325
i386                 randconfig-a015-20210325
i386                 randconfig-a016-20210325
i386                 randconfig-a013-20210325
i386                 randconfig-a012-20210325
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210325
x86_64               randconfig-a015-20210325
x86_64               randconfig-a014-20210325
x86_64               randconfig-a013-20210325
x86_64               randconfig-a011-20210325
x86_64               randconfig-a016-20210325

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
