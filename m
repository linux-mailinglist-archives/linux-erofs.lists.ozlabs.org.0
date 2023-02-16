Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649D069893C
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Feb 2023 01:24:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PHG0Y6f2zz3cdm
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Feb 2023 11:24:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T3JzgBjX;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T3JzgBjX;
	dkim-atps=neutral
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PHG0P64yyz3cGH
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Feb 2023 11:24:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676507062; x=1708043062;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=N0skyHVNT6ajhyw1EN4CjMpK5diq47OSomxpMvjl2Nk=;
  b=T3JzgBjX67irPjCa3Q8eY1YmYjs+LoeJrGIpHGUYhml4x0PFADZf+W1x
   D5jzMBYO9rVg1EXntmyyn1OoStTtB6Lan6uQU34tQtdIbdiLzxSVL3cyA
   UiGS3zCCo2zF5smhLhbJu/t7M/4MSCCTu3p1bfVzhqJtD83GXKuQJlXCy
   1Ihy0HP/09lKSDAFMagSCrbo6QaG121O74UV+krxY16GVz9B05sLWPUNJ
   E17v57+N5z3wnJujOk6SBb0Z8JJ0a217/LcZB98oHnnFpWCtSK2JnRxuV
   bqywftdF/bOQsO72dZDsFFaA+Lc13h/W4gCwwlkF8vxa6QNiVvHKkrdx6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="396218281"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="396218281"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 16:24:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="793825041"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="793825041"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2023 16:24:11 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pSS4I-0009th-1o;
	Thu, 16 Feb 2023 00:24:10 +0000
Date: Thu, 16 Feb 2023 08:23:45 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 61fef98945d0b2fea522ef958f57a783e2a072a9
Message-ID: <63ed7791.ke8UvqZzAjBpzHpR%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 61fef98945d0b2fea522ef958f57a783e2a072a9  erofs: unify anonymous inodes for blob

elapsed time: 1444m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                             allnoconfig
alpha                            allyesconfig
alpha                               defconfig
arc                               allnoconfig
arc                              allyesconfig
arc                                 defconfig
arc                        nsim_700_defconfig
arc                        nsimosci_defconfig
arc                  randconfig-r043-20230212
arc                  randconfig-r043-20230213
arc                  randconfig-r043-20230214
arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm                                 defconfig
arm                          lpd270_defconfig
arm                  randconfig-c002-20230212
arm                  randconfig-r046-20230212
arm                  randconfig-r046-20230214
arm                           tegra_defconfig
arm                           u8500_defconfig
arm                            zeus_defconfig
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                              debian-10.3
i386                         debian-10.3-func
i386                   debian-10.3-kselftests
i386                        debian-10.3-kunit
i386                          debian-10.3-kvm
i386                                defconfig
i386                 randconfig-a011-20230213
i386                 randconfig-a012-20230213
i386                 randconfig-a013-20230213
i386                 randconfig-a014-20230213
i386                 randconfig-a015-20230213
i386                 randconfig-a016-20230213
i386                          randconfig-c001
ia64                             allmodconfig
ia64                                defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                          sun3x_defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                        bcm47xx_defconfig
mips                           xway_defconfig
nios2                               defconfig
openrisc                         alldefconfig
parisc                              defconfig
parisc                generic-32bit_defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                      mgcoge_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                randconfig-r042-20230213
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
s390                 randconfig-r044-20230213
sh                               allmodconfig
sh                        dreamcast_defconfig
sh                            migor_defconfig
sparc                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64               randconfig-a011-20230213
x86_64               randconfig-a012-20230213
x86_64               randconfig-a013-20230213
x86_64               randconfig-a014-20230213
x86_64               randconfig-a015-20230213
x86_64               randconfig-a016-20230213
x86_64                        randconfig-c001
x86_64                               rhel-8.3
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
xtensa                    smp_lx200_defconfig

clang tested configs:
arm                     am200epdkit_defconfig
arm                  randconfig-r046-20230213
hexagon              randconfig-r041-20230212
hexagon              randconfig-r041-20230213
hexagon              randconfig-r041-20230214
hexagon              randconfig-r045-20230212
hexagon              randconfig-r045-20230213
hexagon              randconfig-r045-20230214
i386                 randconfig-a001-20230213
i386                 randconfig-a002-20230213
i386                 randconfig-a003-20230213
i386                 randconfig-a004-20230213
i386                 randconfig-a005-20230213
i386                 randconfig-a006-20230213
mips                     cu1830-neo_defconfig
powerpc                       ebony_defconfig
powerpc                 mpc8272_ads_defconfig
riscv                randconfig-r042-20230212
riscv                randconfig-r042-20230214
s390                 randconfig-r044-20230212
s390                 randconfig-r044-20230214
x86_64               randconfig-a001-20230213
x86_64               randconfig-a002-20230213
x86_64               randconfig-a003-20230213
x86_64               randconfig-a004-20230213
x86_64               randconfig-a005-20230213
x86_64               randconfig-a006-20230213
x86_64                        randconfig-k001
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
