Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F3C4D31D9
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Mar 2022 16:34:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KDGTL6Bpbz3bT1
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Mar 2022 02:34:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oB8FP2EW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=oB8FP2EW; dkim-atps=neutral
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KDGTG1Xmtz2yK2
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Mar 2022 02:34:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646840067; x=1678376067;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=7r4hrrQemWqTQ3g0Cn4V82/E1k51jFIRDymWzm+ZIGo=;
 b=oB8FP2EWJS1SU1rgFXQtEO9lIiErpHTOBC9mJyfEil+yaSD83vHciHJQ
 0MXbLZC2kpIt7W8tZTS+rUmnKm2kyhldRUaCejhw/uUXlqzWegxqDknIB
 24M1Ty5ZEV9rraAyWC7DSN84oN66Xrev/ZDNBHMULImsEAEpi2maLzpZo
 +poZNXVhVTL9IdnLSRobbG+519PWn7zyT+yf5xnib1YTfy3Yr+DL70G3V
 FtHyKKVZYc2F5MVo5XhLYTRExS1xYej5VClxOpr0IxohtTalLH7qXMGM1
 2mNra3atLBP0wovjVotebeNlPF5osR+dLMomAroA+dKMV8hkAh4zM8Fh5 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="318224935"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; d="scan'208";a="318224935"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2022 07:33:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; d="scan'208";a="554156659"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by orsmga008.jf.intel.com with ESMTP; 09 Mar 2022 07:33:14 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nRyJN-0003RU-Fj; Wed, 09 Mar 2022 15:33:13 +0000
Date: Wed, 09 Mar 2022 23:32:24 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 d189849b443286a0d4369068fb03b412cffb32e5
Message-ID: <6228c888.pBCgWlvlpoYkJT69%lkp@intel.com>
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
branch HEAD: d189849b443286a0d4369068fb03b412cffb32e5  Documentation/filesystem/dax: update DAX description on erofs

elapsed time: 720m

configs tested: 126
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
powerpc                    klondike_defconfig
sh                   secureedge5410_defconfig
openrisc                 simple_smp_defconfig
m68k                          multi_defconfig
nios2                            alldefconfig
arm                        keystone_defconfig
microblaze                      mmu_defconfig
arm                           stm32_defconfig
ia64                         bigsur_defconfig
powerpc                 mpc834x_mds_defconfig
arm                          lpd270_defconfig
arc                          axs103_defconfig
sh                           se7722_defconfig
m68k                             alldefconfig
arm                         s3c6400_defconfig
h8300                     edosk2674_defconfig
xtensa                generic_kc705_defconfig
powerpc                     ep8248e_defconfig
sh                        apsh4ad0a_defconfig
sparc                       sparc32_defconfig
sh                   sh7724_generic_defconfig
arm                        mini2440_defconfig
sh                           se7206_defconfig
xtensa                          iss_defconfig
arc                      axs103_smp_defconfig
powerpc                      arches_defconfig
microblaze                          defconfig
arm                  randconfig-c002-20220309
arm                  randconfig-c002-20220308
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                  randconfig-r043-20220309
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
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
riscv                randconfig-c006-20220309
powerpc              randconfig-c003-20220309
i386                          randconfig-c001
arm                  randconfig-c002-20220309
powerpc                 mpc836x_rdk_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                       ebony_defconfig
mips                           ip22_defconfig
mips                         tb0219_defconfig
arm                           spitz_defconfig
arm                       cns3420vb_defconfig
powerpc                     pseries_defconfig
arm                         s3c2410_defconfig
hexagon                             defconfig
powerpc                      ppc44x_defconfig
arm                  colibri_pxa300_defconfig
powerpc                 mpc8272_ads_defconfig
mips                          ath25_defconfig
mips                            e55_defconfig
powerpc                     skiroot_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                       netwinder_defconfig
powerpc                      katmai_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220309
hexagon              randconfig-r041-20220309
riscv                randconfig-r042-20220309
hexagon              randconfig-r045-20220308
hexagon              randconfig-r041-20220308

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
