Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C0973F034
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jun 2023 03:15:00 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XVhuwhGG;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QqmwK69G2z30K1
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jun 2023 11:14:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XVhuwhGG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QqmwB5bc0z2xgq
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jun 2023 11:14:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687828490; x=1719364490;
  h=date:from:to:cc:subject:message-id;
  bh=dHLeITxL7/BXXX0zwV2QpuOixnBFeuziqNuToBW6yOg=;
  b=XVhuwhGGk7bNlvtnQvH8hyD+ftZeNKwQpmb515wcBjKedVY9u/X1iPps
   BqPKrCg3WCVATbSfts+LoZN9/cyn2mqO89bgD1VA4+5Yhh8Tz2n/wVHwe
   AUDYHXHzKWgC8jr+ENQbO2rPKJ/wBlOive4a+MwvYO3mmp2qY7Pe1sU1g
   X3ZaAPHmg0wTTdWmNsDNlbA+3OX5Pa44d4F4t0MvvPCvddCRAMkwHbiK5
   oiqj/aG/PfClhfZmmuvrjsTXOikz/qhI3xUpI3gzWQSOGcWLxgsgGoCVf
   YtjQ/56eYFXasZuZLXhySjy8G+C/9w0ApwGCZlUFqmiYCSubarXFWA+Qy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="341022294"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="341022294"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 18:14:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="962968242"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="962968242"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jun 2023 18:14:36 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qDxHv-000BEr-3C;
	Tue, 27 Jun 2023 01:14:35 +0000
Date: Tue, 27 Jun 2023 09:13:46 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 8241fdd3cdfe88e31a3de09a72b5bff661e4534a
Message-ID: <202306270944.4xuvFud4-lkp@intel.com>
User-Agent: s-nail v14.9.24
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 8241fdd3cdfe88e31a3de09a72b5bff661e4534a  erofs: clean up zmap.c

elapsed time: 6458m

configs tested: 343
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230626   gcc  
alpha                randconfig-r022-20230622   gcc  
alpha                randconfig-r026-20230622   gcc  
alpha                randconfig-r031-20230626   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r006-20230622   gcc  
arc                  randconfig-r024-20230622   gcc  
arc                  randconfig-r036-20230622   gcc  
arc                  randconfig-r043-20230621   gcc  
arc                  randconfig-r043-20230622   gcc  
arc                  randconfig-r043-20230626   gcc  
arc                           tb10x_defconfig   gcc  
arm                              alldefconfig   clang
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                        clps711x_defconfig   gcc  
arm                          collie_defconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                          ep93xx_defconfig   clang
arm                          gemini_defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                      integrator_defconfig   gcc  
arm                          ixp4xx_defconfig   clang
arm                        keystone_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                             mxs_defconfig   clang
arm                        neponset_defconfig   clang
arm                       netwinder_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                  randconfig-r046-20230621   gcc  
arm                  randconfig-r046-20230622   clang
arm                         s5pv210_defconfig   clang
arm                        shmobile_defconfig   gcc  
arm                       spear13xx_defconfig   clang
arm                        spear3xx_defconfig   clang
arm                        spear6xx_defconfig   gcc  
arm                           spitz_defconfig   clang
arm                           stm32_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                        vexpress_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230626   gcc  
arm64                randconfig-r021-20230622   gcc  
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230626   gcc  
csky                 randconfig-r013-20230626   gcc  
csky                 randconfig-r014-20230626   gcc  
csky                 randconfig-r016-20230626   gcc  
csky                 randconfig-r025-20230622   gcc  
csky                 randconfig-r025-20230626   gcc  
csky                 randconfig-r026-20230626   gcc  
csky                 randconfig-r032-20230622   gcc  
hexagon              randconfig-r003-20230622   clang
hexagon              randconfig-r011-20230622   clang
hexagon              randconfig-r041-20230621   clang
hexagon              randconfig-r041-20230622   clang
hexagon              randconfig-r045-20230621   clang
hexagon              randconfig-r045-20230622   clang
i386                             alldefconfig   gcc  
i386                             allyesconfig   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230621   gcc  
i386         buildonly-randconfig-r004-20230622   clang
i386         buildonly-randconfig-r004-20230626   clang
i386         buildonly-randconfig-r005-20230621   gcc  
i386         buildonly-randconfig-r005-20230622   clang
i386         buildonly-randconfig-r005-20230626   clang
i386         buildonly-randconfig-r006-20230621   gcc  
i386         buildonly-randconfig-r006-20230622   clang
i386         buildonly-randconfig-r006-20230626   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230622   clang
i386                 randconfig-i001-20230626   clang
i386                 randconfig-i002-20230622   clang
i386                 randconfig-i002-20230626   clang
i386                 randconfig-i003-20230622   clang
i386                 randconfig-i003-20230626   clang
i386                 randconfig-i004-20230622   clang
i386                 randconfig-i004-20230626   clang
i386                 randconfig-i005-20230622   clang
i386                 randconfig-i005-20230626   clang
i386                 randconfig-i006-20230622   clang
i386                 randconfig-i006-20230626   clang
i386                 randconfig-i011-20230622   gcc  
i386                 randconfig-i011-20230623   clang
i386                 randconfig-i011-20230624   gcc  
i386                 randconfig-i011-20230626   gcc  
i386                 randconfig-i012-20230622   gcc  
i386                 randconfig-i012-20230623   clang
i386                 randconfig-i012-20230624   gcc  
i386                 randconfig-i012-20230626   gcc  
i386                 randconfig-i013-20230622   gcc  
i386                 randconfig-i013-20230623   clang
i386                 randconfig-i013-20230624   gcc  
i386                 randconfig-i013-20230626   gcc  
i386                 randconfig-i014-20230622   gcc  
i386                 randconfig-i014-20230623   clang
i386                 randconfig-i014-20230624   gcc  
i386                 randconfig-i014-20230626   gcc  
i386                 randconfig-i015-20230622   gcc  
i386                 randconfig-i015-20230623   clang
i386                 randconfig-i015-20230624   gcc  
i386                 randconfig-i015-20230626   gcc  
i386                 randconfig-i016-20230622   gcc  
i386                 randconfig-i016-20230623   clang
i386                 randconfig-i016-20230624   gcc  
i386                 randconfig-i016-20230626   gcc  
i386                 randconfig-r012-20230622   gcc  
i386                 randconfig-r023-20230626   gcc  
i386                 randconfig-r024-20230626   gcc  
i386                 randconfig-r026-20230622   gcc  
i386                 randconfig-r032-20230626   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r021-20230622   gcc  
loongarch            randconfig-r024-20230622   gcc  
loongarch            randconfig-r035-20230622   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r002-20230622   gcc  
m68k                 randconfig-r005-20230622   gcc  
m68k                 randconfig-r013-20230622   gcc  
m68k                 randconfig-r015-20230622   gcc  
m68k                 randconfig-r016-20230622   gcc  
m68k                 randconfig-r023-20230626   gcc  
m68k                 randconfig-r032-20230622   gcc  
m68k                 randconfig-r033-20230626   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r016-20230622   gcc  
microblaze           randconfig-r023-20230622   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips                        bcm47xx_defconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                         bigsur_defconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                     loongson1b_defconfig   gcc  
mips                     loongson2k_defconfig   clang
mips                      malta_kvm_defconfig   clang
mips                malta_qemu_32r6_defconfig   clang
mips                      maltaaprp_defconfig   clang
mips                           mtx1_defconfig   clang
mips                      pic32mzda_defconfig   clang
mips                 randconfig-r006-20230622   gcc  
mips                 randconfig-r024-20230622   clang
mips                           xway_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230622   gcc  
nios2                randconfig-r015-20230626   gcc  
nios2                randconfig-r022-20230626   gcc  
nios2                randconfig-r025-20230621   gcc  
openrisc             randconfig-r003-20230626   gcc  
openrisc             randconfig-r005-20230626   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r011-20230626   gcc  
parisc               randconfig-r021-20230621   gcc  
parisc               randconfig-r023-20230622   gcc  
parisc               randconfig-r026-20230621   gcc  
parisc               randconfig-r035-20230626   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    amigaone_defconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                    ge_imp3a_defconfig   clang
powerpc                       holly_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      obs600_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc              randconfig-r012-20230626   gcc  
powerpc              randconfig-r022-20230621   clang
powerpc              randconfig-r034-20230622   clang
powerpc                     redwood_defconfig   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                     tqm5200_defconfig   clang
powerpc                     tqm8541_defconfig   gcc  
powerpc                      tqm8xx_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                randconfig-r004-20230622   clang
riscv                randconfig-r013-20230622   gcc  
riscv                randconfig-r014-20230622   gcc  
riscv                randconfig-r024-20230626   gcc  
riscv                randconfig-r042-20230621   clang
riscv                randconfig-r042-20230622   gcc  
riscv                randconfig-r042-20230626   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230622   clang
s390                 randconfig-r003-20230622   clang
s390                 randconfig-r011-20230622   gcc  
s390                 randconfig-r014-20230626   gcc  
s390                 randconfig-r023-20230621   clang
s390                 randconfig-r025-20230622   gcc  
s390                 randconfig-r026-20230622   gcc  
s390                 randconfig-r035-20230626   clang
s390                 randconfig-r036-20230622   clang
s390                 randconfig-r044-20230621   clang
s390                 randconfig-r044-20230622   gcc  
s390                 randconfig-r044-20230626   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r002-20230626   gcc  
sh                   randconfig-r015-20230622   gcc  
sh                   randconfig-r016-20230626   gcc  
sh                   randconfig-r031-20230622   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                            titan_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230622   gcc  
sparc                randconfig-r012-20230622   gcc  
sparc                randconfig-r032-20230626   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r004-20230622   gcc  
sparc64              randconfig-r021-20230626   gcc  
sparc64              randconfig-r025-20230626   gcc  
sparc64              randconfig-r036-20230626   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r003-20230622   gcc  
um                   randconfig-r012-20230622   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230621   gcc  
x86_64       buildonly-randconfig-r001-20230622   clang
x86_64       buildonly-randconfig-r001-20230626   clang
x86_64       buildonly-randconfig-r002-20230621   gcc  
x86_64       buildonly-randconfig-r002-20230622   clang
x86_64       buildonly-randconfig-r002-20230626   clang
x86_64       buildonly-randconfig-r003-20230621   gcc  
x86_64       buildonly-randconfig-r003-20230622   clang
x86_64       buildonly-randconfig-r003-20230626   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r012-20230626   gcc  
x86_64               randconfig-r022-20230622   gcc  
x86_64               randconfig-r025-20230622   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r002-20230622   gcc  
xtensa               randconfig-r005-20230622   gcc  
xtensa               randconfig-r011-20230622   gcc  
xtensa               randconfig-r026-20230626   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
