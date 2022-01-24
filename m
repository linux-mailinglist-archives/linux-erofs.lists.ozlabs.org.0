Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D87849797F
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jan 2022 08:33:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jj1ts33yCz30Md
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jan 2022 18:33:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MUZKm2mU;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MUZKm2mU; dkim-atps=neutral
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jj1tj5Hblz2xXy
 for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jan 2022 18:33:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643009613; x=1674545613;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=XYg4jQDZIOouX5dsojBLamOArge3cBQMSg1rbSYgs68=;
 b=MUZKm2mUWP+iI4cPqiFieYlXErsAL+24k46xn7kecBZIWp6Sn3GDgrfj
 DYbxHWdqRJwacDqq/LTjHHnn6ejfyAy8DbzuyNyn3W//mZbcXLp1c4nPQ
 ZSKTHnmnoW6ysBhrH02J1X6xqyKq4O/vFFOkFcksX1NwHa1dZlZNKmB05
 k8Nil4vPBCVzeG6ORorq8usiOvr6lx0mKMGW8H0hBPgRgGjIJgu7ogCJg
 FsY34LnqjEddMKBpL0CBQRsN1kt1mpM9dI97zX8ipIDIyU8P40VCN6gS8
 AZZdxIXqgvtuVILN4BztCPsEJfzegNAmBWDlnvdOtmoToAWtJYPCXRsx7 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245931097"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; d="scan'208";a="245931097"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2022 23:32:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; d="scan'208";a="531992303"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by fmsmga007.fm.intel.com with ESMTP; 23 Jan 2022 23:32:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nBtpq-000HrY-FP; Mon, 24 Jan 2022 07:32:18 +0000
Date: Mon, 24 Jan 2022 15:31:54 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:fixes] BUILD SUCCESS
 0a7d31775cc83045247bc1b964d12f2f3a950fe6
Message-ID: <61ee55ea.cRqGaUXJOE2FJtBV%lkp@intel.com>
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
branch HEAD: 0a7d31775cc83045247bc1b964d12f2f3a950fe6  erofs: avoid unnecessary z_erofs_decompressqueue_work() declaration

elapsed time: 1280m

configs tested: 235
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220124
arc                 nsimosci_hs_smp_defconfig
arm                       imx_v6_v7_defconfig
xtensa                       common_defconfig
m68k                          multi_defconfig
i386                                defconfig
mips                     decstation_defconfig
powerpc                     taishan_defconfig
powerpc                     mpc83xx_defconfig
sh                          r7780mp_defconfig
m68k                        m5407c3_defconfig
sh                         apsh4a3a_defconfig
arm                        cerfcube_defconfig
sh                           se7343_defconfig
sh                          urquell_defconfig
arm                       aspeed_g5_defconfig
powerpc64                        alldefconfig
openrisc                 simple_smp_defconfig
h8300                       h8s-sim_defconfig
arc                        vdk_hs38_defconfig
mips                     loongson1b_defconfig
powerpc                      bamboo_defconfig
mips                        bcm47xx_defconfig
sh                          landisk_defconfig
powerpc                       eiger_defconfig
parisc                              defconfig
sh                           se7751_defconfig
sh                         microdev_defconfig
powerpc                     stx_gp3_defconfig
sh                           se7750_defconfig
powerpc                      cm5200_defconfig
sparc64                          alldefconfig
mips                         rt305x_defconfig
sh                            titan_defconfig
powerpc                      ppc6xx_defconfig
mips                        vocore2_defconfig
arm                         cm_x300_defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                      pasemi_defconfig
arm                          badge4_defconfig
sh                          rsk7269_defconfig
arm                         vf610m4_defconfig
sh                            shmin_defconfig
parisc                           alldefconfig
powerpc                 mpc85xx_cds_defconfig
sparc                       sparc32_defconfig
s390                          debug_defconfig
nios2                            alldefconfig
xtensa                           allyesconfig
xtensa                generic_kc705_defconfig
mips                         tb0226_defconfig
sh                  sh7785lcr_32bit_defconfig
nds32                            alldefconfig
xtensa                  audio_kc705_defconfig
powerpc                      ppc40x_defconfig
sh                           se7619_defconfig
sh                           se7705_defconfig
um                             i386_defconfig
mips                           ci20_defconfig
i386                             alldefconfig
sh                           se7780_defconfig
sh                           se7724_defconfig
arm                            lart_defconfig
arm                       multi_v4t_defconfig
sh                             shx3_defconfig
sh                         ap325rxa_defconfig
arc                         haps_hs_defconfig
h8300                            alldefconfig
sparc64                             defconfig
powerpc                   currituck_defconfig
h8300                    h8300h-sim_defconfig
sh                        edosk7705_defconfig
arm                       omap2plus_defconfig
powerpc                     rainier_defconfig
h8300                               defconfig
ia64                             alldefconfig
powerpc                     tqm8541_defconfig
sh                          sdk7780_defconfig
mips                            gpr_defconfig
microblaze                      mmu_defconfig
mips                         cobalt_defconfig
arm                      integrator_defconfig
arm                        clps711x_defconfig
powerpc                      ep88xc_defconfig
ia64                      gensparse_defconfig
arc                          axs103_defconfig
arm                         lubbock_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                           u8500_defconfig
arm                           h5000_defconfig
arm                        oxnas_v6_defconfig
xtensa                  cadence_csp_defconfig
arm                        shmobile_defconfig
powerpc                     sequoia_defconfig
sh                            migor_defconfig
arm                  randconfig-c002-20220123
arm                  randconfig-c002-20220124
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a001-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a002-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a006-20220124
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220123
arc                  randconfig-r043-20220123
s390                 randconfig-r044-20220123
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220123
arm                  randconfig-c002-20220124
riscv                randconfig-c006-20220124
riscv                randconfig-c006-20220123
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220123
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220123
mips                 randconfig-c004-20220124
x86_64               randconfig-c007-20220124
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc                     tqm5200_defconfig
arm                          imote2_defconfig
powerpc                       ebony_defconfig
mips                       rbtx49xx_defconfig
arm                        spear3xx_defconfig
mips                        qi_lb60_defconfig
mips                        bcm63xx_defconfig
powerpc                      obs600_defconfig
arm                          collie_defconfig
mips                   sb1250_swarm_defconfig
powerpc                   lite5200b_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                   milbeaut_m10v_defconfig
arm                           sama7_defconfig
powerpc                    gamecube_defconfig
powerpc                      acadia_defconfig
powerpc                          allmodconfig
mips                            e55_defconfig
powerpc                     mpc512x_defconfig
mips                           ip22_defconfig
arm                         bcm2835_defconfig
riscv                          rv32_defconfig
powerpc                          g5_defconfig
arm                       versatile_defconfig
arm                        magician_defconfig
powerpc                  mpc885_ads_defconfig
mips                     cu1000-neo_defconfig
arm                         lpc32xx_defconfig
arm                        multi_v5_defconfig
arm                          ixp4xx_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
riscv                randconfig-r042-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r041-20220124
hexagon              randconfig-r045-20220123
hexagon              randconfig-r041-20220123

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
