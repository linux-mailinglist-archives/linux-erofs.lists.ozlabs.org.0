Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C0E47F464
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Dec 2021 21:24:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JLwPg0fQlz2yqC
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Dec 2021 07:24:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OBBA5LZF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OBBA5LZF; dkim-atps=neutral
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JLwPW2fDhz2xCx
 for <linux-erofs@lists.ozlabs.org>; Sun, 26 Dec 2021 07:23:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640463839; x=1671999839;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=wwj6qZTRJaxtYR6pHVHb2purb3Bo/NMfu1YwHX/03pc=;
 b=OBBA5LZFhdfH892lDFmCi1XJEzQPhklzC4nZdRaIDoOHriIAlo2gKUu4
 mIVE+hCqfzopIw8K2qIyR9XCKNxyjljdauOgxQCGp2G9V9amlxokxLVac
 DJZmig+U9c08ki1uEwJWdRsYpazOpxyZyoTYCM2mWjnARLqS+BcPuUldx
 b09xigxicKnM9stKc1A0nRP0Uqng18SfTviTSh63kqb/DW2y4conx/F4H
 d6MLouVPLvzNZqm+kQYI1pVYRS/JHYRHySX1EzE4rctql/tFYCDV6XOqc
 e6qD+D5tmcOJYQm4tFNQ+Gw8UVl+bD8+shMTqvsoEYD/qxyfRtQ6Hhhez g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="227906051"
X-IronPort-AV: E=Sophos;i="5.88,235,1635231600"; d="scan'208";a="227906051"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2021 12:22:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,235,1635231600"; d="scan'208";a="509434762"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 25 Dec 2021 12:22:47 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1n1DZ1-0004en-1z; Sat, 25 Dec 2021 20:22:47 +0000
Date: Sun, 26 Dec 2021 04:22:04 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 9204beaeb1c1bf4eeac42df048c5bd829deedfff
Message-ID: <61c77d6c.cHSSo7FEya5mje3s%lkp@intel.com>
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
branch HEAD: 9204beaeb1c1bf4eeac42df048c5bd829deedfff  erofs: add on-disk compressed tail-packing inline support

elapsed time: 720m

configs tested: 130
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211225
mips                         rt305x_defconfig
powerpc                    ge_imp3a_defconfig
xtensa                generic_kc705_defconfig
mips                             allyesconfig
sh                         microdev_defconfig
sparc                       sparc32_defconfig
arc                          axs101_defconfig
mips                         tb0226_defconfig
arc                     nsimosci_hs_defconfig
arm                       cns3420vb_defconfig
powerpc                      ppc64e_defconfig
arm                             ezx_defconfig
sh                              ul2_defconfig
sh                        sh7757lcr_defconfig
ia64                          tiger_defconfig
powerpc                       ppc64_defconfig
sh                           se7619_defconfig
riscv                            allmodconfig
openrisc                         alldefconfig
h8300                    h8300h-sim_defconfig
powerpc                        cell_defconfig
arm                            mps2_defconfig
sh                          lboxre2_defconfig
powerpc                         ps3_defconfig
h8300                       h8s-sim_defconfig
sh                          landisk_defconfig
sh                          sdk7786_defconfig
arm                         nhk8815_defconfig
arm                          pxa3xx_defconfig
arm                            mmp2_defconfig
sh                        sh7785lcr_defconfig
m68k                             allyesconfig
mips                     cu1830-neo_defconfig
sh                          urquell_defconfig
arm                           sama5_defconfig
powerpc                   lite5200b_defconfig
powerpc                   bluestone_defconfig
arm                           stm32_defconfig
arm                           tegra_defconfig
arm                              alldefconfig
arm                         vf610m4_defconfig
arm                        magician_defconfig
nds32                               defconfig
powerpc                    adder875_defconfig
sh                        edosk7705_defconfig
arm                  randconfig-c002-20211225
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a013-20211225
x86_64               randconfig-a015-20211225
x86_64               randconfig-a011-20211225
x86_64               randconfig-a012-20211225
x86_64               randconfig-a014-20211225
x86_64               randconfig-a016-20211225
i386                 randconfig-a012-20211225
i386                 randconfig-a011-20211225
i386                 randconfig-a014-20211225
i386                 randconfig-a016-20211225
i386                 randconfig-a015-20211225
i386                 randconfig-a013-20211225
arc                  randconfig-r043-20211225
s390                 randconfig-r044-20211225
riscv                randconfig-r042-20211225
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig

clang tested configs:
riscv                randconfig-c006-20211226
powerpc              randconfig-c003-20211226
i386                 randconfig-c001-20211226
x86_64               randconfig-c007-20211226
i386                 randconfig-a002-20211225
i386                 randconfig-a005-20211225
i386                 randconfig-a001-20211225
i386                 randconfig-a004-20211225
i386                 randconfig-a003-20211225
i386                 randconfig-a006-20211225
x86_64               randconfig-a003-20211225
x86_64               randconfig-a001-20211225
x86_64               randconfig-a005-20211225
x86_64               randconfig-a004-20211225
x86_64               randconfig-a002-20211225
x86_64               randconfig-a006-20211225
hexagon              randconfig-r041-20211225
hexagon              randconfig-r045-20211225

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
