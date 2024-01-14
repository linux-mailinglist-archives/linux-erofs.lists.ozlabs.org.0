Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BCB82D193
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Jan 2024 18:12:23 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TxitaN/f;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TChf15L6gz3bdm
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jan 2024 04:12:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TxitaN/f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.93; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 66 seconds by postgrey-1.37 at boromir; Mon, 15 Jan 2024 04:12:01 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TChds0D8rz2ytl
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jan 2024 04:11:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705252321; x=1736788321;
  h=date:from:to:cc:subject:message-id;
  bh=x9Yb/1ykYkbYxyHYjttkDxfqSjxPjR45v7LN7oP8wk8=;
  b=TxitaN/fMYfNyVB14rJVAfeZnwZAHP7Vcv8LDIW2stxxz793KAp7OEcZ
   va08ODbOlq2cQof/kCuPjJ1SThJgYo+AEopczcc1baGabA+abbdhf1EHM
   B+2r3iFxBj2X3AqxVR4D5m2H65vNHY+4VTovRgTsi2wPPSSDQqWIxCwlC
   aiNVuwbLfzaEjGjjvTBcMYa0KRqcdnFMFA0MohfhaH3M6EVihcB1KSUBi
   dI5Luz8bJIZ/GIBCOgKrpoCOZfzBZYO6N6TcgkoE8K5wKlRdtmujIC2i6
   ZZUxhSQmWCax8dobiUBp902qBUzxQYh1FND1vCBjQtTDE9nrb/1RqaLgw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="396621495"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="396621495"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 09:10:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="817600890"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="817600890"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Jan 2024 09:10:47 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rP40T-000Bgy-0Y;
	Sun, 14 Jan 2024 17:10:45 +0000
Date: Mon, 15 Jan 2024 01:10:31 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 118a8cf504d7dfa519562d000f423ee3ca75d2c4
Message-ID: <202401150129.hf5Bw4st-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 118a8cf504d7dfa519562d000f423ee3ca75d2c4  erofs: fix inconsistent per-file compression format

elapsed time: 1462m

configs tested: 138
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240114   gcc  
arc                   randconfig-002-20240114   gcc  
arm                               allnoconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240114   gcc  
csky                  randconfig-002-20240114   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                  randconfig-011-20240114   gcc  
i386                  randconfig-012-20240114   gcc  
i386                  randconfig-013-20240114   gcc  
i386                  randconfig-014-20240114   gcc  
i386                  randconfig-015-20240114   gcc  
i386                  randconfig-016-20240114   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240114   gcc  
loongarch             randconfig-002-20240114   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                          rb532_defconfig   gcc  
mips                          rm200_defconfig   gcc  
mips                   sb1250_swarm_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240114   gcc  
nios2                 randconfig-002-20240114   gcc  
openrisc                         alldefconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240114   gcc  
parisc                randconfig-002-20240114   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240114   gcc  
s390                  randconfig-002-20240114   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240114   gcc  
sh                    randconfig-002-20240114   gcc  
sh                          rsk7203_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240114   gcc  
sparc64               randconfig-002-20240114   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240114   clang
x86_64       buildonly-randconfig-002-20240114   clang
x86_64       buildonly-randconfig-003-20240114   clang
x86_64       buildonly-randconfig-004-20240114   clang
x86_64       buildonly-randconfig-005-20240114   clang
x86_64       buildonly-randconfig-006-20240114   clang
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240114   clang
x86_64                randconfig-012-20240114   clang
x86_64                randconfig-013-20240114   clang
x86_64                randconfig-014-20240114   clang
x86_64                randconfig-015-20240114   clang
x86_64                randconfig-016-20240114   clang
x86_64                randconfig-071-20240114   clang
x86_64                randconfig-072-20240114   clang
x86_64                randconfig-073-20240114   clang
x86_64                randconfig-074-20240114   clang
x86_64                randconfig-075-20240114   clang
x86_64                randconfig-076-20240114   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240114   gcc  
xtensa                randconfig-002-20240114   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
