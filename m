Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1982C441224
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Nov 2021 03:26:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HjH2Z662hz2yQ9
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Nov 2021 13:25:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HjH2V3d42z2xr5
 for <linux-erofs@lists.ozlabs.org>; Mon,  1 Nov 2021 13:25:48 +1100 (AEDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="230790637"
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; d="scan'208";a="230790637"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2021 19:24:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; d="scan'208";a="530986385"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
 by orsmga001.jf.intel.com with ESMTP; 31 Oct 2021 19:24:40 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mhN04-0002wg-44; Mon, 01 Nov 2021 02:24:40 +0000
Date: Mon, 01 Nov 2021 10:24:02 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 a0961f351d82d43ab0b845304caa235dfe249ae9
Message-ID: <617f4fc2.j0H/lScYBoIMHmww%lkp@intel.com>
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
branch HEAD: a0961f351d82d43ab0b845304caa235dfe249ae9  erofs: don't trigger WARN() when decompression fails

elapsed time: 725m

configs tested: 162
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
m68k                        m5407c3_defconfig
arm64                            alldefconfig
mips                           xway_defconfig
powerpc                      bamboo_defconfig
arm                         mv78xx0_defconfig
mips                      loongson3_defconfig
powerpc                         ps3_defconfig
h8300                     edosk2674_defconfig
sh                           se7206_defconfig
sh                          polaris_defconfig
arm                         at91_dt_defconfig
mips                        maltaup_defconfig
arm                    vt8500_v6_v7_defconfig
mips                  cavium_octeon_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                             ezx_defconfig
xtensa                  cadence_csp_defconfig
riscv                               defconfig
sh                   secureedge5410_defconfig
arm                            mps2_defconfig
arm                       omap2plus_defconfig
m68k                          atari_defconfig
arm                         palmz72_defconfig
mips                           ip32_defconfig
powerpc                     ppa8548_defconfig
xtensa                  nommu_kc705_defconfig
arc                        vdk_hs38_defconfig
m68k                        m5307c3_defconfig
powerpc64                           defconfig
powerpc                     sequoia_defconfig
s390                                defconfig
sh                 kfr2r09-romimage_defconfig
mips                  maltasmvp_eva_defconfig
mips                            ar7_defconfig
mips                             allyesconfig
mips                           ci20_defconfig
m68k                          multi_defconfig
arm                            mmp2_defconfig
sh                        apsh4ad0a_defconfig
powerpc                         wii_defconfig
arm                      integrator_defconfig
mips                         rt305x_defconfig
arm                         s3c6400_defconfig
sh                ecovec24-romimage_defconfig
ia64                      gensparse_defconfig
arm                      jornada720_defconfig
powerpc                     redwood_defconfig
arm                        shmobile_defconfig
powerpc                     tqm5200_defconfig
sh                        edosk7760_defconfig
arm                           tegra_defconfig
powerpc                     mpc512x_defconfig
arm                        mvebu_v5_defconfig
mips                             allmodconfig
riscv             nommu_k210_sdcard_defconfig
mips                  decstation_64_defconfig
nios2                               defconfig
arm                            zeus_defconfig
alpha                            alldefconfig
arm                           h3600_defconfig
s390                          debug_defconfig
arm                          gemini_defconfig
arm                        spear6xx_defconfig
arm                     am200epdkit_defconfig
arm                          ixp4xx_defconfig
m68k                         apollo_defconfig
sh                            titan_defconfig
arm                          iop32x_defconfig
mips                   sb1250_swarm_defconfig
arm                             rpc_defconfig
sh                        sh7757lcr_defconfig
arm                  randconfig-c002-20211031
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
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
parisc                              defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
sparc                            allyesconfig
sparc                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a003-20211031
i386                 randconfig-a006-20211031
i386                 randconfig-a002-20211031
i386                 randconfig-a005-20211031
i386                 randconfig-a001-20211031
i386                 randconfig-a004-20211031
x86_64               randconfig-a005-20211031
x86_64               randconfig-a004-20211031
x86_64               randconfig-a002-20211031
x86_64               randconfig-a003-20211031
x86_64               randconfig-a001-20211031
x86_64               randconfig-a006-20211031
arc                  randconfig-r043-20211031
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
powerpc              randconfig-c003-20211031
riscv                randconfig-c006-20211031
x86_64               randconfig-c007-20211031
mips                 randconfig-c004-20211031
s390                 randconfig-c005-20211031
arm                  randconfig-c002-20211031
i386                 randconfig-c001-20211031
mips                 randconfig-c004-20211101
arm                  randconfig-c002-20211101
i386                 randconfig-c001-20211101
s390                 randconfig-c005-20211101
powerpc              randconfig-c003-20211101
riscv                randconfig-c006-20211101
x86_64               randconfig-c007-20211101
x86_64               randconfig-a013-20211031
x86_64               randconfig-a015-20211031
x86_64               randconfig-a014-20211031
x86_64               randconfig-a011-20211031
x86_64               randconfig-a016-20211031
x86_64               randconfig-a012-20211031
i386                 randconfig-a013-20211031
i386                 randconfig-a012-20211031
i386                 randconfig-a014-20211031
i386                 randconfig-a015-20211031
i386                 randconfig-a011-20211031
i386                 randconfig-a016-20211031
riscv                randconfig-r042-20211031
s390                 randconfig-r044-20211031
hexagon              randconfig-r045-20211031
hexagon              randconfig-r041-20211031

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
