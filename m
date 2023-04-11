Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 073306DD370
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Apr 2023 08:52:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pwc336NBGz3cNJ
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Apr 2023 16:52:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dgjz+0Du;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dgjz+0Du;
	dkim-atps=neutral
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pwc2x00P8z3cBk
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Apr 2023 16:52:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195929; x=1712731929;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4iHllXiqJU6cO/xf9+McRcUgC9Pc1uu9RqSkOqHNiAg=;
  b=dgjz+0DuuTR9EFXyXZNJf4XqcTmuuDjZ0lQD5YlNMYdMZRbY3+N9gAFP
   Nvu9I9WNjbs315SLm9tIkNp47E1WTrukEAGx/D3d8UecQ3pZyCArshAgP
   kNr8g3MyrtdYxjowMhWOcJSYzTzAU2QnTeoEZ3rbc6vDEMRglRJvoFsbJ
   O8Hr7LAjwpJYl69sCvpfCSUuQ5d2inGVx2CSW9mb0mylc2IiH8is0FyHm
   U7EcxB+8urlU00+XuWQ6KajaC1ZlZd/ZWq/CrmVDM8N0n4NuNyiN7dsiz
   xHvMDtlsNePCgtOsrdPjc/nUfub/VG9OwQTebPlm8ZrMBefSD4vcD8m0m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="342305414"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="342305414"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:51:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="638707219"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="638707219"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 Apr 2023 23:51:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pm7rB-000W3W-1L;
	Tue, 11 Apr 2023 06:51:57 +0000
Date: Tue, 11 Apr 2023 14:51:42 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 349ea8a32b55212884161ba771dfba1c2e8886f9
Message-ID: <6435037e.m6jjSVqYHZRzfG48%lkp@intel.com>
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
branch HEAD: 349ea8a32b55212884161ba771dfba1c2e8886f9  erofs: enable long extended attribute name prefixes

elapsed time: 721m

configs tested: 137
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230409   gcc  
alpha                randconfig-r013-20230410   gcc  
alpha                randconfig-r016-20230409   gcc  
alpha                randconfig-r034-20230410   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r005-20230409   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230409   gcc  
arc                  randconfig-r043-20230410   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r001-20230409   gcc  
arm                  randconfig-r046-20230409   clang
arm                  randconfig-r046-20230410   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230410   clang
arm64                randconfig-r031-20230409   clang
csky         buildonly-randconfig-r006-20230409   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r015-20230409   gcc  
hexagon              randconfig-r025-20230409   clang
hexagon              randconfig-r041-20230409   clang
hexagon              randconfig-r041-20230410   clang
hexagon              randconfig-r045-20230409   clang
hexagon              randconfig-r045-20230410   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r002-20230410   clang
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
i386                 randconfig-r006-20230410   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230410   gcc  
loongarch            randconfig-r011-20230410   gcc  
loongarch            randconfig-r012-20230409   gcc  
loongarch            randconfig-r015-20230410   gcc  
loongarch            randconfig-r024-20230409   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230409   gcc  
m68k                 randconfig-r016-20230410   gcc  
m68k                 randconfig-r032-20230409   gcc  
microblaze           randconfig-r032-20230410   gcc  
microblaze           randconfig-r033-20230410   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r005-20230410   gcc  
nios2        buildonly-randconfig-r004-20230409   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r024-20230410   gcc  
nios2                randconfig-r036-20230409   gcc  
openrisc             randconfig-r006-20230409   gcc  
openrisc             randconfig-r023-20230409   gcc  
openrisc             randconfig-r031-20230410   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230410   gcc  
parisc               randconfig-r034-20230409   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r001-20230410   clang
powerpc              randconfig-r025-20230410   gcc  
powerpc              randconfig-r033-20230409   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230410   gcc  
riscv                randconfig-r042-20230409   gcc  
riscv                randconfig-r042-20230410   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230410   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r014-20230410   gcc  
s390                 randconfig-r022-20230409   gcc  
s390                 randconfig-r044-20230409   gcc  
s390                 randconfig-r044-20230410   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230409   gcc  
sh                   randconfig-r004-20230409   gcc  
sh                   randconfig-r013-20230409   gcc  
sh                   randconfig-r026-20230409   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r021-20230409   gcc  
sparc                randconfig-r026-20230410   gcc  
sparc                randconfig-r035-20230409   gcc  
sparc64      buildonly-randconfig-r001-20230410   gcc  
sparc64              randconfig-r005-20230410   gcc  
sparc64              randconfig-r011-20230409   gcc  
sparc64              randconfig-r021-20230410   gcc  
sparc64              randconfig-r036-20230410   gcc  
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
x86_64               randconfig-r022-20230410   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230409   gcc  
xtensa               randconfig-r035-20230410   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
