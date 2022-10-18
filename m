Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BB9603455
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Oct 2022 22:51:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MsQyL5cDkz3f7D
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Oct 2022 07:51:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g9jWvQjS;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g9jWvQjS;
	dkim-atps=neutral
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MsQs93zD2z3dvt
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Oct 2022 07:47:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666126029; x=1697662029;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tivDA8ePDjRbf1j+XL8dyI+UQX0ID0CUv4N//2wFvEA=;
  b=g9jWvQjS/S9ENyRrcrJmwAZ1qsbaAHTuhjRyP0Vb/pO5GwYgo/ALmmW6
   47b2VM6Hv0p7gRKFpmbXT63YsISyurAoOkX8hO4WfxWjeT/YPn14tU8zH
   R71CcE4sID2DyOg9SCllNz4MopuyozyJJ1pvFra1ZVZAG75aREEzjYNnD
   ZT7cFR0x52pqBb96NL/bXd7E2SxTxWw4K6gp/CUd+fwSZ8wUZVHbdIjoy
   o7Sw+GcCNI53/0hd9MbY30zjSlc8HbhOjyh95bm9ZiW3U+dwCnx4wSJrb
   ZI2S4brJ5UTJ/JJM/TdI3foaPBx2EosAlKikPi4NRnMAmvcSOfEP0dRpg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="307341014"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="307341014"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 13:46:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="628910259"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="628910259"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Oct 2022 13:46:57 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oktUH-000213-00;
	Tue, 18 Oct 2022 20:46:57 +0000
Date: Wed, 19 Oct 2022 04:46:39 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 ce4b815686573bef82d5ee53bf6f509bf20904dc
Message-ID: <634f10af.ymBrJz4EfXqDBN5n%lkp@intel.com>
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: ce4b815686573bef82d5ee53bf6f509bf20904dc  erofs: protect s_inodes with s_inode_list_lock for fscache

elapsed time: 2199m

configs tested: 270
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
csky                              allnoconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
i386                             allyesconfig
i386                                defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arm                        spear6xx_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20221017
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                 randconfig-a005-20221017
i386                 randconfig-a003-20221017
i386                 randconfig-a004-20221017
i386                 randconfig-a001-20221017
i386                 randconfig-a006-20221017
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                        m5407c3_defconfig
powerpc                  iss476-smp_defconfig
sh                   rts7751r2dplus_defconfig
m68k                        mvme16x_defconfig
sh                   secureedge5410_defconfig
arc                        nsimosci_defconfig
m68k                          multi_defconfig
csky                             alldefconfig
x86_64               randconfig-a004-20221017
x86_64               randconfig-a001-20221017
x86_64               randconfig-a002-20221017
x86_64               randconfig-a006-20221017
x86_64               randconfig-a005-20221017
sh                        edosk7760_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 canyonlands_defconfig
i386                 randconfig-c001-20221017
arc                        nsim_700_defconfig
riscv                               defconfig
powerpc                 mpc837x_mds_defconfig
sh                           se7721_defconfig
arc                          axs103_defconfig
powerpc                     asp8347_defconfig
sh                ecovec24-romimage_defconfig
arm                      footbridge_defconfig
m68k                             alldefconfig
arm                         assabet_defconfig
mips                  maltasmvp_eva_defconfig
sh                   sh7724_generic_defconfig
sh                          rsk7264_defconfig
mips                 decstation_r4k_defconfig
loongarch                         allnoconfig
microblaze                          defconfig
arm                          gemini_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                 mpc8540_ads_defconfig
sh                          kfr2r09_defconfig
powerpc                 linkstation_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                    adder875_defconfig
sh                           se7751_defconfig
parisc                           alldefconfig
nios2                               defconfig
mips                        vocore2_defconfig
arm                        keystone_defconfig
powerpc                        cell_defconfig
parisc                generic-32bit_defconfig
riscv             nommu_k210_sdcard_defconfig
m68k                         amcore_defconfig
mips                           ci20_defconfig
powerpc                      makalu_defconfig
loongarch                           defconfig
sh                             sh03_defconfig
ia64                            zx1_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      arches_defconfig
arm                          iop32x_defconfig
openrisc                  or1klitex_defconfig
powerpc                        warp_defconfig
sh                          polaris_defconfig
m68k                          hp300_defconfig
sh                          rsk7203_defconfig
arm                             ezx_defconfig
powerpc                     mpc83xx_defconfig
sh                              ul2_defconfig
powerpc                  storcenter_defconfig
arm                            lart_defconfig
sh                             shx3_defconfig
parisc                generic-64bit_defconfig
arm                        cerfcube_defconfig
sh                          r7785rp_defconfig
m68k                            q40_defconfig
arc                           tb10x_defconfig
i386                 randconfig-a002-20221017
loongarch                        allmodconfig
x86_64               randconfig-a003-20221017
powerpc                         wii_defconfig
arm                        realview_defconfig
arc                        vdk_hs38_defconfig
powerpc                      chrp32_defconfig
m68k                       m5208evb_defconfig
mips                     decstation_defconfig
mips                        bcm47xx_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7705_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                           h3600_defconfig
x86_64               randconfig-c001-20221017
arm                  randconfig-c002-20221017
powerpc                     taishan_defconfig
m68k                       bvme6000_defconfig
mips                             allmodconfig
sparc                       sparc32_defconfig
sparc                       sparc64_defconfig
arm                       aspeed_g5_defconfig
arm64                            alldefconfig
sh                           se7724_defconfig
powerpc                      ppc6xx_defconfig
nios2                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sh                            hp6xx_defconfig
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
arm                       imx_v6_v7_defconfig
m68k                          amiga_defconfig
m68k                        m5307c3_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arm                         lpc18xx_defconfig
powerpc                 mpc85xx_cds_defconfig
ia64                                defconfig
powerpc                          allyesconfig
ia64                          tiger_defconfig
alpha                            alldefconfig
mips                     loongson1b_defconfig
i386                          randconfig-c001
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
powerpc                      pcm030_defconfig
arm                        shmobile_defconfig
arc                            hsdk_defconfig
xtensa                    xip_kc705_defconfig
m68k                           sun3_defconfig
mips                           gcw0_defconfig
mips                      fuloong2e_defconfig
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a001
xtensa                  audio_kc705_defconfig
m68k                          atari_defconfig
openrisc                       virt_defconfig
sh                         ap325rxa_defconfig
m68k                                defconfig
powerpc                      ppc40x_defconfig
sh                   sh7770_generic_defconfig
arc                    vdk_hs38_smp_defconfig
sparc64                             defconfig
sh                        sh7757lcr_defconfig
microblaze                      mmu_defconfig
sh                           se7343_defconfig
arm                         at91_dt_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                           jazz_defconfig
powerpc                     pq2fads_defconfig
arm                         cm_x300_defconfig
m68k                       m5275evb_defconfig
openrisc                 simple_smp_defconfig
mips                            gpr_defconfig
sparc                             allnoconfig
powerpc                     tqm8541_defconfig
powerpc                     stx_gp3_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        trizeps4_defconfig
arm                        mvebu_v7_defconfig
openrisc                         alldefconfig
arm                      jornada720_defconfig
ia64                             allmodconfig

clang tested configs:
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
x86_64               randconfig-a014-20221017
x86_64               randconfig-a015-20221017
x86_64               randconfig-a012-20221017
x86_64               randconfig-a011-20221017
x86_64               randconfig-a013-20221017
x86_64               randconfig-a016-20221017
s390                 randconfig-r044-20221017
hexagon              randconfig-r045-20221017
riscv                randconfig-r042-20221017
hexagon              randconfig-r041-20221017
mips                 randconfig-c004-20221017
i386                 randconfig-c001-20221017
s390                 randconfig-c005-20221017
arm                  randconfig-c002-20221017
riscv                randconfig-c006-20221017
x86_64               randconfig-c007-20221017
powerpc              randconfig-c003-20221017
x86_64               randconfig-k001-20221017
arm                          collie_defconfig
x86_64                        randconfig-c007
mips                 randconfig-c004-20221018
i386                          randconfig-c001
s390                 randconfig-c005-20221018
arm                  randconfig-c002-20221018
riscv                randconfig-c006-20221018
powerpc              randconfig-c003-20221018
arm                        mvebu_v5_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
mips                        maltaup_defconfig
arm                         s3c2410_defconfig
powerpc                 mpc832x_mds_defconfig
mips                           rs90_defconfig
mips                          rm200_defconfig
powerpc                      ppc44x_defconfig
riscv                             allnoconfig
powerpc                  mpc866_ads_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                         socfpga_defconfig
arm                       mainstone_defconfig
arm                          sp7021_defconfig
powerpc                    mvme5100_defconfig
x86_64                        randconfig-k001
arm                      pxa255-idp_defconfig
mips                       lemote2f_defconfig
arm                      tct_hammer_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
