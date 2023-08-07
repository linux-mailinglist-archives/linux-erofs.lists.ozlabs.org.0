Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE67772543
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Aug 2023 15:17:50 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cBwD5oZ7;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RKH1S1pmbz2yjj
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Aug 2023 23:17:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cBwD5oZ7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.88; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RKH1J3gq2z2yDd
	for <linux-erofs@lists.ozlabs.org>; Mon,  7 Aug 2023 23:17:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691414260; x=1722950260;
  h=date:from:to:cc:subject:message-id;
  bh=uiO2hwWy1Vj2kvOPDCNQ4xwN0F7aI6gAO7tf+rCN1+8=;
  b=cBwD5oZ7WfWvEsil9xBMAw83TKFb19TuCm0TjBlIT8HSkQggDnWsUbyq
   x53t6y8MoxO+mksyWszvitntxWkuU23nsD0iR56xoz82Y4CPP1U+IU9ZQ
   N/QTM3RWvS5hB9ukegc0NG5j5/6Qfxc106La//t4hyvj8/c599cLISoMJ
   j0/wynBI0PxnP8Tb8BSCPzNgg4q1rK8f6KHdJleqar37/pXo7CYzNd/Xn
   kc+JxmJSbTdH/GAMbeWus4WMQEP0rK8l6X3kRjgWApbqU2ixzYKSEz23R
   JBDbVmDgN5l9X//02aidMd+YCCeRI1hpzISfUZWyTcTeYUrmXCMTOiCTs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="401512565"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="401512565"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 06:09:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="766001639"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="766001639"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Aug 2023 06:09:54 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qSzzd-0004gL-0y;
	Mon, 07 Aug 2023 13:09:53 +0000
Date: Mon, 07 Aug 2023 21:08:59 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 8803c7fbb7f1907eb999d3100559687a853eeee3
Message-ID: <202308072157.bZxoKjfs-lkp@intel.com>
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
branch HEAD: 8803c7fbb7f1907eb999d3100559687a853eeee3  erofs: boost negative xattr lookup with bloom filter

elapsed time: 724m

configs tested: 134
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230807   gcc  
alpha                randconfig-r006-20230807   gcc  
alpha                randconfig-r016-20230807   gcc  
alpha                randconfig-r025-20230807   gcc  
alpha                randconfig-r026-20230807   gcc  
alpha                randconfig-r031-20230807   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230807   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r013-20230807   gcc  
arm                  randconfig-r024-20230807   gcc  
arm                  randconfig-r046-20230807   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230807   gcc  
arm64                randconfig-r004-20230807   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r013-20230807   gcc  
csky                 randconfig-r014-20230807   gcc  
csky                 randconfig-r025-20230807   gcc  
csky                 randconfig-r033-20230807   gcc  
hexagon              randconfig-r011-20230807   clang
hexagon              randconfig-r012-20230807   clang
hexagon              randconfig-r041-20230807   clang
hexagon              randconfig-r045-20230807   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230807   gcc  
i386         buildonly-randconfig-r005-20230807   gcc  
i386         buildonly-randconfig-r006-20230807   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230807   gcc  
i386                 randconfig-i002-20230807   gcc  
i386                 randconfig-i003-20230807   gcc  
i386                 randconfig-i004-20230807   gcc  
i386                 randconfig-i005-20230807   gcc  
i386                 randconfig-i006-20230807   gcc  
i386                 randconfig-i011-20230807   clang
i386                 randconfig-i012-20230807   clang
i386                 randconfig-i013-20230807   clang
i386                 randconfig-i014-20230807   clang
i386                 randconfig-i015-20230807   clang
i386                 randconfig-i016-20230807   clang
i386                 randconfig-r002-20230807   gcc  
i386                 randconfig-r025-20230807   clang
i386                 randconfig-r036-20230807   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230807   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230807   gcc  
m68k                 randconfig-r015-20230807   gcc  
m68k                 randconfig-r024-20230807   gcc  
microblaze           randconfig-r026-20230807   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r016-20230807   gcc  
mips                 randconfig-r033-20230807   clang
mips                 randconfig-r036-20230807   clang
nios2                               defconfig   gcc  
nios2                randconfig-r022-20230807   gcc  
nios2                randconfig-r023-20230807   gcc  
nios2                randconfig-r035-20230807   gcc  
openrisc             randconfig-r032-20230807   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r022-20230807   gcc  
parisc               randconfig-r032-20230807   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r012-20230807   clang
powerpc              randconfig-r035-20230807   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230807   gcc  
riscv                randconfig-r034-20230807   gcc  
riscv                randconfig-r042-20230807   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r011-20230807   clang
s390                 randconfig-r044-20230807   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230807   gcc  
sh                   randconfig-r002-20230807   gcc  
sh                   randconfig-r026-20230807   gcc  
sh                   randconfig-r031-20230807   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230807   gcc  
sparc                randconfig-r034-20230807   gcc  
sparc64              randconfig-r021-20230807   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r003-20230807   clang
um                   randconfig-r014-20230807   gcc  
um                   randconfig-r015-20230807   gcc  
um                   randconfig-r023-20230807   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230807   gcc  
x86_64       buildonly-randconfig-r002-20230807   gcc  
x86_64       buildonly-randconfig-r003-20230807   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230807   clang
x86_64               randconfig-x002-20230807   clang
x86_64               randconfig-x003-20230807   clang
x86_64               randconfig-x004-20230807   clang
x86_64               randconfig-x005-20230807   clang
x86_64               randconfig-x006-20230807   clang
x86_64               randconfig-x011-20230807   gcc  
x86_64               randconfig-x012-20230807   gcc  
x86_64               randconfig-x013-20230807   gcc  
x86_64               randconfig-x014-20230807   gcc  
x86_64               randconfig-x015-20230807   gcc  
x86_64               randconfig-x016-20230807   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
