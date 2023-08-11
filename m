Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476F7778682
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Aug 2023 06:31:50 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gYm/bxmy;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RMW8h0VRJz2ysB
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Aug 2023 14:31:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gYm/bxmy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RMW8X1NGgz2yDb
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Aug 2023 14:31:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691728300; x=1723264300;
  h=date:from:to:cc:subject:message-id;
  bh=xr90hg2YK4Km/SvfwqojxyAZWTyyCRz5/eBqjS74wGk=;
  b=gYm/bxmyoPjDgohG38jNzkMDB0NX2ddQb+LdmueLZe5tQGCOCvpX2kLp
   9fwoa72qsujD/Eh0Xoq/Jgh23HIxNU6j+/ydBHKcD7rvqOaxvglR1RBIV
   RjXZTkdRdkKTDqPQnMSNAnoYSIiNG4I9ukBvqmzPS03qmcpdAfHRDTiUN
   qlV7g04CJTAQCUV3O5x94MDnQeEkaA8aZTBgY8nkr3sEN/iJwt/h8LOzM
   Yb5mtUieAupS1DRkME0vVTnZVgQ1ZeNKB7Sa5776A6rAh4qr753o85BXE
   XNSb/Z6lDs1cLVw+7jvrUKnRIcbHlNju3ijDCbz2qynYeQou0QaqkmVTQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="374357929"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="374357929"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 21:31:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="906303327"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="906303327"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2023 21:31:30 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qUJo9-0007VZ-2Q;
	Fri, 11 Aug 2023 04:31:29 +0000
Date: Fri, 11 Aug 2023 12:31:04 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 6dbdd19b46c7948b97e2c0f49b3504fe6c1a4e1b
Message-ID: <202308111202.cnCDG8DH-lkp@intel.com>
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
branch HEAD: 6dbdd19b46c7948b97e2c0f49b3504fe6c1a4e1b  erofs: refine warning messages for zdata I/Os

elapsed time: 723m

configs tested: 110
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230811   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r022-20230811   clang
arm                  randconfig-r046-20230811   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230811   clang
arm64                randconfig-r002-20230811   clang
arm64                randconfig-r031-20230811   clang
arm64                randconfig-r033-20230811   clang
csky                                defconfig   gcc  
csky                 randconfig-r006-20230811   gcc  
csky                 randconfig-r025-20230811   gcc  
hexagon              randconfig-r041-20230811   clang
hexagon              randconfig-r045-20230811   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230811   clang
i386         buildonly-randconfig-r005-20230811   clang
i386         buildonly-randconfig-r006-20230811   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230811   clang
i386                 randconfig-i002-20230811   clang
i386                 randconfig-i003-20230811   clang
i386                 randconfig-i004-20230811   clang
i386                 randconfig-i005-20230811   clang
i386                 randconfig-i006-20230811   clang
i386                 randconfig-r012-20230811   gcc  
i386                 randconfig-r013-20230811   gcc  
i386                 randconfig-r014-20230811   gcc  
i386                 randconfig-r015-20230811   gcc  
i386                 randconfig-r021-20230811   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r023-20230811   gcc  
loongarch            randconfig-r026-20230811   gcc  
loongarch            randconfig-r032-20230811   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230811   gcc  
m68k                 randconfig-r023-20230811   gcc  
m68k                 randconfig-r033-20230811   gcc  
m68k                 randconfig-r035-20230811   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r013-20230811   clang
mips                 randconfig-r031-20230811   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230811   gcc  
nios2                randconfig-r014-20230811   gcc  
nios2                randconfig-r024-20230811   gcc  
nios2                randconfig-r035-20230811   gcc  
openrisc             randconfig-r024-20230811   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r036-20230811   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230811   gcc  
riscv                randconfig-r042-20230811   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r016-20230811   gcc  
s390                 randconfig-r025-20230811   gcc  
s390                 randconfig-r026-20230811   gcc  
s390                 randconfig-r034-20230811   clang
s390                 randconfig-r044-20230811   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230811   gcc  
sh                   randconfig-r034-20230811   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r006-20230811   gcc  
sparc64              randconfig-r001-20230811   gcc  
sparc64              randconfig-r002-20230811   gcc  
sparc64              randconfig-r011-20230811   gcc  
sparc64              randconfig-r032-20230811   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r011-20230811   clang
um                   randconfig-r021-20230811   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230811   clang
x86_64       buildonly-randconfig-r002-20230811   clang
x86_64       buildonly-randconfig-r003-20230811   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r003-20230811   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r005-20230811   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
