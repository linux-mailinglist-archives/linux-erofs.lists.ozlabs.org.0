Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733DB779576
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Aug 2023 19:00:14 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bfdoRRCA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RMqmD2468z3c2f
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Aug 2023 03:00:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bfdoRRCA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.151; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RMqm56cljz2yD7
	for <linux-erofs@lists.ozlabs.org>; Sat, 12 Aug 2023 03:00:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691773206; x=1723309206;
  h=date:from:to:cc:subject:message-id;
  bh=XDxwAkefPyK8G718ZEbp4rkpBhfU6cxgZTT/4uCo8YY=;
  b=bfdoRRCAFKq/e1IrRFopuOeCzm9m0Yf0ykmpv/qzycS+OALSU/R9L+qW
   IKebLE4HrNob1jW5SP9u7/kO5569UiRb1Go7aOcRCqgpQctmqY7ZmXu4s
   rEab8YimRtsRTfuwjpJm7W3GfYZ06dDlC3lVuVPH3BKAor1BAirOHNNF9
   NAPtEWXMzdqwnyDQbYSbLl3I3HsUqm/r8kahqNeJiuB09jwJyQeKTamQ8
   ellUTDt/2i90J3PwTKHiDpFUms0e8bJkVyqG4WxO6nthvLyQLRhgsm+w5
   VhvqraWXUuvD3F8jswDU+iPsRZrXw/chSsbJQ/VvvyVA0AuyT8l2g5RpD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="352045087"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="352045087"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 09:59:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="856353327"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="856353327"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 Aug 2023 09:59:46 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qUVUH-0007ta-1H;
	Fri, 11 Aug 2023 16:59:45 +0000
Date: Sat, 12 Aug 2023 00:59:15 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 c23df8256b55297179aa7c0d874e8a82e1e443fd
Message-ID: <202308120013.YkjVPcHJ-lkp@intel.com>
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
branch HEAD: c23df8256b55297179aa7c0d874e8a82e1e443fd  erofs: refine warning messages for zdata I/Os

elapsed time: 720m

configs tested: 118
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230811   gcc  
alpha                randconfig-r006-20230811   gcc  
alpha                randconfig-r011-20230811   gcc  
alpha                randconfig-r015-20230811   gcc  
alpha                randconfig-r025-20230811   gcc  
alpha                randconfig-r034-20230811   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r033-20230811   gcc  
arc                  randconfig-r043-20230811   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r026-20230811   clang
arm                  randconfig-r036-20230811   gcc  
arm                  randconfig-r046-20230811   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r031-20230811   clang
csky                                defconfig   gcc  
hexagon              randconfig-r013-20230811   clang
hexagon              randconfig-r041-20230811   clang
hexagon              randconfig-r045-20230811   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230811   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i002-20230811   clang
i386                 randconfig-i003-20230811   clang
i386                 randconfig-i004-20230811   clang
i386                 randconfig-i005-20230811   clang
i386                 randconfig-i006-20230811   clang
i386                 randconfig-i011-20230811   gcc  
i386                 randconfig-i012-20230811   gcc  
i386                 randconfig-i013-20230811   gcc  
i386                 randconfig-i014-20230811   gcc  
i386                 randconfig-i016-20230811   gcc  
i386                 randconfig-r031-20230811   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230811   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r024-20230811   gcc  
m68k                 randconfig-r032-20230811   gcc  
microblaze           randconfig-r021-20230811   gcc  
microblaze           randconfig-r026-20230811   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r001-20230811   gcc  
mips                 randconfig-r005-20230811   gcc  
mips                 randconfig-r006-20230811   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r023-20230811   gcc  
nios2                randconfig-r031-20230811   gcc  
nios2                randconfig-r032-20230811   gcc  
openrisc             randconfig-r006-20230811   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230811   gcc  
parisc               randconfig-r022-20230811   gcc  
parisc               randconfig-r035-20230811   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r005-20230811   clang
powerpc              randconfig-r022-20230811   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230811   gcc  
riscv                randconfig-r015-20230811   gcc  
riscv                randconfig-r042-20230811   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230811   clang
s390                 randconfig-r004-20230811   clang
s390                 randconfig-r014-20230811   gcc  
s390                 randconfig-r016-20230811   gcc  
s390                 randconfig-r034-20230811   clang
s390                 randconfig-r035-20230811   clang
s390                 randconfig-r036-20230811   clang
s390                 randconfig-r044-20230811   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230811   gcc  
sh                   randconfig-r021-20230811   gcc  
sh                   randconfig-r033-20230811   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r002-20230811   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r002-20230811   clang
x86_64               randconfig-r004-20230811   clang
x86_64               randconfig-r012-20230811   gcc  
x86_64               randconfig-x001-20230811   gcc  
x86_64               randconfig-x003-20230811   gcc  
x86_64               randconfig-x006-20230811   gcc  
x86_64               randconfig-x012-20230811   clang
x86_64               randconfig-x013-20230811   clang
x86_64               randconfig-x014-20230811   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r035-20230811   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
