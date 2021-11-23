Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B151B45AC81
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 20:31:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzDlC2JgQz2yp9
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 06:31:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzDl7618Pz2ygC
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 06:30:53 +1100 (AEDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="258989017"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; d="scan'208";a="258989017"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2021 11:29:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; d="scan'208";a="674604290"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
 by orsmga005.jf.intel.com with ESMTP; 23 Nov 2021 11:29:48 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mpbUB-0002Cb-Vd; Tue, 23 Nov 2021 19:29:47 +0000
Date: Wed, 24 Nov 2021 03:29:34 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <xiang@kernel.org>
Subject: [xiang-erofs:fixes] BUILD SUCCESS
 57bbeacdbee72a54eb97d56b876cf9c94059fc34
Message-ID: <619d411e.kOL0+d2LZ4w7kQaa%lkp@intel.com>
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
branch HEAD: 57bbeacdbee72a54eb97d56b876cf9c94059fc34  erofs: fix deadlock when shrink erofs slab

elapsed time: 726m

configs tested: 158
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211123
powerpc                      tqm8xx_defconfig
arm                         socfpga_defconfig
arm                          pcm027_defconfig
powerpc                        fsp2_defconfig
mips                  decstation_64_defconfig
sh                         ecovec24_defconfig
mips                         rt305x_defconfig
arm                         at91_dt_defconfig
arm                        mvebu_v5_defconfig
riscv                    nommu_virt_defconfig
powerpc                       eiger_defconfig
sh                           se7705_defconfig
powerpc                    adder875_defconfig
mips                        maltaup_defconfig
sparc                       sparc64_defconfig
sparc64                          alldefconfig
mips                           gcw0_defconfig
arm                          pxa3xx_defconfig
powerpc                 linkstation_defconfig
arm                        magician_defconfig
sh                           se7343_defconfig
ia64                             alldefconfig
sh                      rts7751r2d1_defconfig
powerpc                     pq2fads_defconfig
powerpc                      pasemi_defconfig
mips                            ar7_defconfig
sh                          lboxre2_defconfig
mips                  cavium_octeon_defconfig
mips                     decstation_defconfig
openrisc                            defconfig
mips                           xway_defconfig
powerpc                      pmac32_defconfig
powerpc                      chrp32_defconfig
mips                      pic32mzda_defconfig
powerpc                     tqm8560_defconfig
powerpc                     mpc512x_defconfig
m68k                       m5475evb_defconfig
powerpc                      walnut_defconfig
powerpc64                           defconfig
ia64                            zx1_defconfig
sh                              ul2_defconfig
powerpc                  mpc885_ads_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc834x_mds_defconfig
sh                           se7712_defconfig
mips                        qi_lb60_defconfig
arm                        vexpress_defconfig
h8300                               defconfig
arm                         axm55xx_defconfig
arm                      footbridge_defconfig
mips                      malta_kvm_defconfig
sh                             espt_defconfig
powerpc                      ppc64e_defconfig
powerpc                 canyonlands_defconfig
sh                        edosk7705_defconfig
mips                     loongson2k_defconfig
powerpc                   lite5200b_defconfig
arm                           h5000_defconfig
arm                          badge4_defconfig
mips                     cu1830-neo_defconfig
powerpc                 mpc8540_ads_defconfig
openrisc                 simple_smp_defconfig
sh                          r7785rp_defconfig
ia64                        generic_defconfig
powerpc                   currituck_defconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
mips                           mtx1_defconfig
arm                            xcep_defconfig
mips                       bmips_be_defconfig
mips                           ip32_defconfig
arm                  randconfig-c002-20211123
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a001-20211123
x86_64               randconfig-a003-20211123
x86_64               randconfig-a006-20211123
x86_64               randconfig-a004-20211123
x86_64               randconfig-a005-20211123
x86_64               randconfig-a002-20211123
i386                 randconfig-a001-20211123
i386                 randconfig-a002-20211123
i386                 randconfig-a005-20211123
i386                 randconfig-a006-20211123
i386                 randconfig-a004-20211123
i386                 randconfig-a003-20211123
arc                  randconfig-r043-20211123
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20211123
i386                 randconfig-c001-20211123
powerpc              randconfig-c003-20211123
arm                  randconfig-c002-20211123
riscv                randconfig-c006-20211123
x86_64               randconfig-c007-20211123
mips                 randconfig-c004-20211123
x86_64               randconfig-a014-20211123
x86_64               randconfig-a011-20211123
x86_64               randconfig-a012-20211123
x86_64               randconfig-a016-20211123
x86_64               randconfig-a013-20211123
x86_64               randconfig-a015-20211123
i386                 randconfig-a016-20211123
i386                 randconfig-a015-20211123
i386                 randconfig-a012-20211123
i386                 randconfig-a013-20211123
i386                 randconfig-a014-20211123
i386                 randconfig-a011-20211123
hexagon              randconfig-r045-20211123
s390                 randconfig-r044-20211123
hexagon              randconfig-r041-20211123
riscv                randconfig-r042-20211123

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
