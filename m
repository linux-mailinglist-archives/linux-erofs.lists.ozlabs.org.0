Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D8546B1BC
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Dec 2021 05:09:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J7Rdl5dkkz2yfZ
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Dec 2021 15:09:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J7Rdd5fkMz2yLd
 for <linux-erofs@lists.ozlabs.org>; Tue,  7 Dec 2021 15:09:36 +1100 (AEDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="323742933"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; d="scan'208";a="323742933"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2021 20:08:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; d="scan'208";a="462144829"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
 by orsmga006.jf.intel.com with ESMTP; 06 Dec 2021 20:08:30 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1muRmI-000M8s-0f; Tue, 07 Dec 2021 04:08:30 +0000
Date: Tue, 07 Dec 2021 12:08:02 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 ac913fada7e1bba6d1aa9fbb707c8cc4529af9b8
Message-ID: <61aede22.lQ5T3RqGz2H/g4aR%lkp@intel.com>
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
branch HEAD: ac913fada7e1bba6d1aa9fbb707c8cc4529af9b8  erofs: Replace zero-length array with flexible-array member

possible Warning in current branch (please contact us if interested):

fs/erofs/sysfs.c:131 erofs_attr_store() warn: impossible condition '(t > (~0)) => (0-u32max > u32max)'

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-m021-20211207
    `-- fs-erofs-sysfs.c-erofs_attr_store()-warn:impossible-condition-(t-(-))-(-u32max-u32max)

elapsed time: 726m

configs tested: 171
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211206
i386                 randconfig-c001-20211207
arm                         shannon_defconfig
powerpc                     pq2fads_defconfig
powerpc                    gamecube_defconfig
powerpc                      ppc40x_defconfig
arm                      integrator_defconfig
mips                     decstation_defconfig
m68k                       m5275evb_defconfig
mips                            e55_defconfig
mips                        workpad_defconfig
openrisc                            defconfig
nios2                         3c120_defconfig
sh                   sh7770_generic_defconfig
powerpc                        cell_defconfig
parisc                           allyesconfig
mips                      maltasmvp_defconfig
xtensa                         virt_defconfig
mips                     loongson1b_defconfig
ia64                                defconfig
xtensa                  audio_kc705_defconfig
mips                           ip22_defconfig
arm                        spear3xx_defconfig
xtensa                generic_kc705_defconfig
m68k                         apollo_defconfig
sh                           se7619_defconfig
mips                          ath79_defconfig
powerpc                     kmeter1_defconfig
arm                             pxa_defconfig
sh                          sdk7780_defconfig
arc                    vdk_hs38_smp_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                  mpc885_ads_defconfig
mips                     cu1000-neo_defconfig
csky                             alldefconfig
arm                        cerfcube_defconfig
arm                        trizeps4_defconfig
arm                            zeus_defconfig
powerpc                      pasemi_defconfig
mips                            ar7_defconfig
sparc                            alldefconfig
mips                        jmr3927_defconfig
powerpc                 mpc836x_mds_defconfig
sh                        apsh4ad0a_defconfig
arm                         lpc32xx_defconfig
h8300                    h8300h-sim_defconfig
sh                   rts7751r2dplus_defconfig
arm                         at91_dt_defconfig
arm                           spitz_defconfig
arc                           tb10x_defconfig
arm                          simpad_defconfig
arm                       imx_v4_v5_defconfig
mips                         tb0219_defconfig
arm                           sama7_defconfig
powerpc                    amigaone_defconfig
powerpc                 linkstation_defconfig
arm                      pxa255-idp_defconfig
xtensa                       common_defconfig
xtensa                           alldefconfig
nds32                            alldefconfig
powerpc                    adder875_defconfig
mips                      malta_kvm_defconfig
arm                          iop32x_defconfig
powerpc                   microwatt_defconfig
arm                        vexpress_defconfig
mips                  cavium_octeon_defconfig
mips                      fuloong2e_defconfig
m68k                       bvme6000_defconfig
arm                       multi_v4t_defconfig
sparc                            allyesconfig
openrisc                  or1klitex_defconfig
powerpc                      ep88xc_defconfig
arm                         bcm2835_defconfig
powerpc                 mpc8560_ads_defconfig
mips                        qi_lb60_defconfig
arm                        spear6xx_defconfig
arc                              alldefconfig
powerpc                     stx_gp3_defconfig
powerpc                        icon_defconfig
arm                  randconfig-c002-20211207
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211207
x86_64               randconfig-a005-20211207
x86_64               randconfig-a001-20211207
x86_64               randconfig-a002-20211207
x86_64               randconfig-a004-20211207
x86_64               randconfig-a003-20211207
i386                 randconfig-a001-20211207
i386                 randconfig-a005-20211207
i386                 randconfig-a002-20211207
i386                 randconfig-a003-20211207
i386                 randconfig-a006-20211207
i386                 randconfig-a004-20211207
x86_64               randconfig-a016-20211206
x86_64               randconfig-a011-20211206
x86_64               randconfig-a013-20211206
x86_64               randconfig-a014-20211206
x86_64               randconfig-a012-20211206
x86_64               randconfig-a015-20211206
arc                  randconfig-r043-20211207
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
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
x86_64               randconfig-c007-20211207
arm                  randconfig-c002-20211207
riscv                randconfig-c006-20211207
mips                 randconfig-c004-20211207
i386                 randconfig-c001-20211207
powerpc              randconfig-c003-20211207
s390                 randconfig-c005-20211207
x86_64               randconfig-a016-20211207
x86_64               randconfig-a011-20211207
x86_64               randconfig-a013-20211207
x86_64               randconfig-a014-20211207
x86_64               randconfig-a015-20211207
x86_64               randconfig-a012-20211207
i386                 randconfig-a013-20211207
i386                 randconfig-a011-20211207
i386                 randconfig-a014-20211207
i386                 randconfig-a012-20211207
i386                 randconfig-a015-20211207
i386                 randconfig-a016-20211207
s390                 randconfig-r044-20211207
hexagon              randconfig-r041-20211207
hexagon              randconfig-r045-20211207
riscv                randconfig-r042-20211207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
