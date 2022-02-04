Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767904A9EE7
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Feb 2022 19:23:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jr3p516spz3bVt
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Feb 2022 05:23:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E01YP1gF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=E01YP1gF; dkim-atps=neutral
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jr3ny6nzBz2yLK
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Feb 2022 05:23:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643999031; x=1675535031;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=6rlJplZX/FMKCpuQKR5p5dGxQ8d1OChQ95uQhgT3ULA=;
 b=E01YP1gFG1DzsA5CEMawKqkXeqSHlB5TBlB5/olLP4qQZpoFzsmfxJAL
 a6LiXLYP8jvMrBa7iKyGKoxIt4hexJFYGHiHwk/Rw5yItDdQQYO3PkxGH
 tRNPk2hoz+MzrukU50VCsCHn4wHZPziJgklvcO8Kh06Y2aZGmDB12E0wT
 IUdPYslujVnpJcKI8w18D2kvndRt/P6fqEazgLKEQsRwb93UMFNLlRqld
 5JTu1OSFd5SX/wFi7EGeaKp/U99E8MAmdWnnagqsReNpwH5lHG+OWARya
 LZSo36h+mzsSRozJN1RnOJwfYUVmVxHpxP6nRcWwBkYVTUHqYbPJ30Y4M Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="235817499"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; d="scan'208";a="235817499"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2022 10:22:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; d="scan'208";a="539252081"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by orsmga008.jf.intel.com with ESMTP; 04 Feb 2022 10:22:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nG3EF-000Xzv-0o; Fri, 04 Feb 2022 18:22:39 +0000
Date: Sat, 05 Feb 2022 02:21:46 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 24331050a3e6afcd4451409831dd9ae8085a42f6
Message-ID: <61fd6eba.uW0Wum0ztzGtyi5U%lkp@intel.com>
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
branch HEAD: 24331050a3e6afcd4451409831dd9ae8085a42f6  erofs: fix small compressed files inlining

elapsed time: 726m

configs tested: 172
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220131
powerpc              randconfig-c003-20220131
m68k                          hp300_defconfig
sh                   sh7724_generic_defconfig
arc                    vdk_hs38_smp_defconfig
mips                      fuloong2e_defconfig
arm                         vf610m4_defconfig
powerpc64                        alldefconfig
sh                        sh7757lcr_defconfig
powerpc                        cell_defconfig
mips                 decstation_r4k_defconfig
um                               alldefconfig
sh                         ap325rxa_defconfig
mips                  maltasmvp_eva_defconfig
mips                         db1xxx_defconfig
sh                           se7206_defconfig
sh                             sh03_defconfig
arm                       aspeed_g5_defconfig
powerpc                      cm5200_defconfig
arm                      footbridge_defconfig
powerpc                      ppc6xx_defconfig
sh                           se7750_defconfig
sh                         microdev_defconfig
arc                            hsdk_defconfig
parisc                           allyesconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                  iss476-smp_defconfig
powerpc                     mpc83xx_defconfig
powerpc                     stx_gp3_defconfig
powerpc                      ep88xc_defconfig
arm                         lubbock_defconfig
mips                          rb532_defconfig
powerpc                      ppc40x_defconfig
sh                   rts7751r2dplus_defconfig
nds32                               defconfig
arm                            qcom_defconfig
powerpc                     pq2fads_defconfig
m68k                            q40_defconfig
sh                              ul2_defconfig
mips                           gcw0_defconfig
powerpc                    klondike_defconfig
mips                      loongson3_defconfig
xtensa                  cadence_csp_defconfig
m68k                          multi_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                ecovec24-romimage_defconfig
m68k                       m5249evb_defconfig
arm                             rpc_defconfig
arm                             pxa_defconfig
sh                             espt_defconfig
mips                           ip32_defconfig
microblaze                      mmu_defconfig
xtensa                           allyesconfig
powerpc                     rainier_defconfig
mips                    maltaup_xpa_defconfig
openrisc                 simple_smp_defconfig
nios2                         10m50_defconfig
ia64                         bigsur_defconfig
um                                  defconfig
arm                         nhk8815_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
arm                  randconfig-c002-20220202
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc                 mpc832x_rdb_defconfig
powerpc                          allyesconfig
powerpc               mpc834x_itxgp_defconfig
arm                  colibri_pxa270_defconfig
powerpc                        icon_defconfig
mips                        bcm63xx_defconfig
x86_64                           allyesconfig
arm                         shannon_defconfig
powerpc                     tqm5200_defconfig
arm                           sama7_defconfig
arm                       spear13xx_defconfig
mips                        omega2p_defconfig
arm                   milbeaut_m10v_defconfig
arm                         orion5x_defconfig
mips                          ath79_defconfig
powerpc                     ppa8548_defconfig
arm                         socfpga_defconfig
powerpc                 mpc832x_mds_defconfig
arm                          pcm027_defconfig
arm                           spitz_defconfig
arm                     davinci_all_defconfig
powerpc                   microwatt_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
i386                 randconfig-a011-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r041-20220130

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
