Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F40EF6E2CB3
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Apr 2023 01:09:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pysb21hHBz3ch2
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Apr 2023 09:09:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fjXgXzMA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fjXgXzMA;
	dkim-atps=neutral
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PysZr3R6rz3cCc
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Apr 2023 09:09:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681513748; x=1713049748;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=btk1LqdZL3QAOxfyTzQ5HF8QoY8t0m7jb0B7J5avPaU=;
  b=fjXgXzMABbbCb8Xdu5EnXksxIQx0UqQF1iZlD7eRs+BKtp8JF1VI4RuX
   cWkrez8cc6De44BpSiJzS/kf2m8wBBLWmUQlVX9Q0kivap5+oFdqNUvNQ
   ExyDh4mMvuf2C/M89He5PjFk3R7KVNWNkaPzrP2mABEKE/JBLblmwOA81
   NAUPIFFGbOjP6yWaRG6P+A97Ue60w1Pi4nNNkuN/g7TyyP8bTA3zkY01J
   s3cFk/rZl+2aPWC46f4zbpyX+H77QzpKpU0MRDjbeGQp8awB8McQjrMIb
   CrLV3fIF1bFmGU32V5AJVhaj5J3UTfOn9xoxuJxZqHg03S+lPtwd0B/7d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="346432139"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="346432139"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 16:08:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="689983021"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="689983021"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Apr 2023 16:08:56 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pnSXH-000a65-2K;
	Fri, 14 Apr 2023 23:08:55 +0000
Date: Sat, 15 Apr 2023 07:08:32 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 e284794b5b92fbaf26efbc2138b1d72bfd90e8be
Message-ID: <6439dcf0.wCOqnIMi+eOsSbwU%lkp@intel.com>
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
branch HEAD: e284794b5b92fbaf26efbc2138b1d72bfd90e8be  erofs: cleanup i_format-related stuffs

elapsed time: 840m

configs tested: 159
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230414   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230410   gcc  
alpha                randconfig-r006-20230410   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r005-20230414   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230410   gcc  
arc                  randconfig-r004-20230409   gcc  
arc                  randconfig-r012-20230414   gcc  
arc                  randconfig-r031-20230413   gcc  
arc                  randconfig-r033-20230413   gcc  
arc                  randconfig-r043-20230409   gcc  
arc                  randconfig-r043-20230410   gcc  
arc                  randconfig-r043-20230413   gcc  
arc                  randconfig-r043-20230414   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230409   clang
arm          buildonly-randconfig-r005-20230410   clang
arm                                 defconfig   gcc  
arm                  randconfig-r033-20230412   gcc  
arm                  randconfig-r046-20230409   clang
arm                  randconfig-r046-20230410   clang
arm                  randconfig-r046-20230413   gcc  
arm                  randconfig-r046-20230414   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230409   clang
arm64                randconfig-r035-20230413   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230409   gcc  
csky                 randconfig-r036-20230413   gcc  
hexagon      buildonly-randconfig-r003-20230409   clang
hexagon              randconfig-r002-20230414   clang
hexagon              randconfig-r041-20230409   clang
hexagon              randconfig-r041-20230410   clang
hexagon              randconfig-r041-20230413   clang
hexagon              randconfig-r041-20230414   clang
hexagon              randconfig-r045-20230409   clang
hexagon              randconfig-r045-20230410   clang
hexagon              randconfig-r045-20230413   clang
hexagon              randconfig-r045-20230414   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r003-20230410   clang
i386         buildonly-randconfig-r004-20230410   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
i386                 randconfig-a011-20230410   gcc  
i386                 randconfig-a012-20230410   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
i386                 randconfig-r002-20230410   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230409   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230414   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r006-20230413   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230414   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r034-20230412   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r015-20230414   clang
mips                 randconfig-r016-20230409   clang
mips                 randconfig-r032-20230412   gcc  
nios2        buildonly-randconfig-r003-20230414   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230409   gcc  
nios2                randconfig-r011-20230410   gcc  
nios2                randconfig-r013-20230410   gcc  
nios2                randconfig-r013-20230414   gcc  
nios2                randconfig-r032-20230413   gcc  
openrisc     buildonly-randconfig-r002-20230413   gcc  
openrisc     buildonly-randconfig-r004-20230409   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230410   gcc  
powerpc      buildonly-randconfig-r004-20230413   clang
powerpc      buildonly-randconfig-r006-20230409   gcc  
powerpc              randconfig-r011-20230414   gcc  
powerpc              randconfig-r036-20230412   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230413   clang
riscv        buildonly-randconfig-r004-20230414   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r031-20230412   clang
riscv                randconfig-r035-20230412   clang
riscv                randconfig-r042-20230409   gcc  
riscv                randconfig-r042-20230410   gcc  
riscv                randconfig-r042-20230413   clang
riscv                randconfig-r042-20230414   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230409   gcc  
s390         buildonly-randconfig-r005-20230413   clang
s390                                defconfig   gcc  
s390                 randconfig-r001-20230409   clang
s390                 randconfig-r003-20230410   clang
s390                 randconfig-r044-20230409   gcc  
s390                 randconfig-r044-20230410   gcc  
s390                 randconfig-r044-20230413   clang
s390                 randconfig-r044-20230414   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230414   gcc  
sh                   randconfig-r005-20230409   gcc  
sh                   randconfig-r006-20230414   gcc  
sh                   randconfig-r011-20230409   gcc  
sh                   randconfig-r016-20230410   gcc  
sh                   randconfig-r034-20230413   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230410   gcc  
sparc                randconfig-r014-20230409   gcc  
sparc                randconfig-r014-20230414   gcc  
sparc64              randconfig-r003-20230409   gcc  
sparc64              randconfig-r012-20230410   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230410   clang
x86_64               randconfig-a002-20230410   clang
x86_64               randconfig-a003-20230410   clang
x86_64               randconfig-a004-20230410   clang
x86_64               randconfig-a005-20230410   clang
x86_64               randconfig-a006-20230410   clang
x86_64               randconfig-a011-20230410   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64               randconfig-r014-20230410   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230413   gcc  
xtensa               randconfig-r015-20230410   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
