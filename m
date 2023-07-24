Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA8775EA1D
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jul 2023 05:39:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eLwV6GkJ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R8Qrm64V3z2yVq
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jul 2023 13:39:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eLwV6GkJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R8Qrh3hmdz2yVq
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jul 2023 13:39:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690169972; x=1721705972;
  h=date:from:to:cc:subject:message-id;
  bh=Pjn/o3RGR0r+ZzCsMD5mm1Uf+QbJOMpjG9+aUFRJROg=;
  b=eLwV6GkJaOCJ/Lc0DROYCdDPLmhgF1CE/8P1t3SkvswFbYYGlqn4u/5T
   mRjVy/McyYMKR7kLHiPD7UwldOc3l26FVy8wz2xxpukXJnVUsyihmyKpd
   LhCQZmO5QOUNO5mvwJFV1tkMsAcjr0CrUtp06h49M9VIkKWc+feJeP+5p
   g1E6ILBqVANSRo/P2yn8w0QOk+DD33yiZNgeXEAf6140hwm+59/4ZXNrV
   t/8xfc8IBkVpEjCV/OnFdhzL6g9KeJLzrXTnjf4ZBHH4SxGNlvP3Gx1OE
   ftbLr8GeXz+T4IB4htlxjSwCDwayvKF4z0tU/kBdlNFfqe4i4OSSGdSQD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="364797491"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="364797491"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 20:39:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="795625772"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="795625772"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2023 20:39:21 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qNmPo-0009SU-1r;
	Mon, 24 Jul 2023 03:39:20 +0000
Date: Mon, 24 Jul 2023 11:38:40 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 1f9beb807470ae60210f4d4e96dac3a7733dd117
Message-ID: <202307241138.mgT54DA0-lkp@intel.com>
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
branch HEAD: 1f9beb807470ae60210f4d4e96dac3a7733dd117  erofs: boost negative xattr lookup with bloom filter

elapsed time: 726m

configs tested: 105
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r033-20230723   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230723   gcc  
arc                  randconfig-r026-20230723   gcc  
arc                  randconfig-r043-20230723   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230723   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230723   gcc  
hexagon              randconfig-r021-20230723   clang
hexagon              randconfig-r041-20230723   clang
hexagon              randconfig-r045-20230723   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230723   clang
i386         buildonly-randconfig-r005-20230723   clang
i386         buildonly-randconfig-r006-20230723   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230723   clang
i386                 randconfig-i002-20230723   clang
i386                 randconfig-i003-20230723   clang
i386                 randconfig-i004-20230723   clang
i386                 randconfig-i005-20230723   clang
i386                 randconfig-i006-20230723   clang
i386                 randconfig-i011-20230723   gcc  
i386                 randconfig-i012-20230723   gcc  
i386                 randconfig-i013-20230723   gcc  
i386                 randconfig-i014-20230723   gcc  
i386                 randconfig-i015-20230723   gcc  
i386                 randconfig-i016-20230723   gcc  
i386                 randconfig-r032-20230723   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230723   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r024-20230723   clang
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230723   gcc  
nios2                randconfig-r006-20230723   gcc  
nios2                randconfig-r031-20230723   gcc  
openrisc             randconfig-r016-20230723   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r015-20230723   gcc  
parisc               randconfig-r035-20230723   gcc  
parisc               randconfig-r036-20230723   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r003-20230723   clang
powerpc              randconfig-r014-20230723   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230723   gcc  
riscv                randconfig-r042-20230723   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230723   gcc  
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230723   clang
x86_64       buildonly-randconfig-r002-20230723   clang
x86_64       buildonly-randconfig-r003-20230723   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r022-20230723   gcc  
x86_64               randconfig-x001-20230723   gcc  
x86_64               randconfig-x002-20230723   gcc  
x86_64               randconfig-x003-20230723   gcc  
x86_64               randconfig-x004-20230723   gcc  
x86_64               randconfig-x005-20230723   gcc  
x86_64               randconfig-x006-20230723   gcc  
x86_64               randconfig-x011-20230723   clang
x86_64               randconfig-x012-20230723   clang
x86_64               randconfig-x013-20230723   clang
x86_64               randconfig-x014-20230723   clang
x86_64               randconfig-x015-20230723   clang
x86_64               randconfig-x016-20230723   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r013-20230723   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
