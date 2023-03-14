Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176EB6BA064
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Mar 2023 21:06:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pbkzs68kMz3cdR
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Mar 2023 07:06:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V1cJS1RT;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V1cJS1RT;
	dkim-atps=neutral
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pbkzm41c6z3cBL
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Mar 2023 07:05:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678824356; x=1710360356;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=iV7BDPLsadbsxx1usbCfAK/SPkbxoAUKcanodgCuPKg=;
  b=V1cJS1RTT74/6lVttVSCQUv90is1fL9lVcB7aZyJsD+iae5rBb8EOQso
   CPsq9xUbUchlUiyanBDDYTUFAYn6IvwS//uW7ZAZp5MfuiSygjqImvQ4E
   yZw9BGnZgZpwgS3jZMB/PYrqaKKYkjYv95Ud8qB7VHqFP7BO3oXGW1M2J
   hRdGavLnF4lCz98LnVnnPybiiu0DjuN+mmi7gZDr//+DH1ruTGIGMRJ6C
   xmAoQAsrFntWv+h27RgOOItzhn7lKoLn/5Q04YKbWqoJFGKP1LHk9ILsU
   FDIBy0QNVbrWt067CA2j/Q26gfcqfwpt5U5uGCOncFstLhwM1as5jW0qv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317183502"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317183502"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 13:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768234162"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768234162"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Mar 2023 13:05:50 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pcAu6-0007AC-0L;
	Tue, 14 Mar 2023 20:05:50 +0000
Date: Wed, 15 Mar 2023 04:05:12 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 4f24ebae35ff9739e963eb4a164fe97d00069dad
Message-ID: <6410d378.c+WwiyMS/6fHikMf%lkp@intel.com>
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
branch HEAD: 4f24ebae35ff9739e963eb4a164fe97d00069dad  erofs: support flattened block device for multi-blob images

elapsed time: 720m

configs tested: 195
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230313   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230313   gcc  
alpha                randconfig-r004-20230312   gcc  
alpha                randconfig-r016-20230312   gcc  
alpha                randconfig-r021-20230312   gcc  
alpha                randconfig-r034-20230313   gcc  
alpha                randconfig-r035-20230313   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230312   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r012-20230312   gcc  
arc                  randconfig-r013-20230313   gcc  
arc                  randconfig-r031-20230313   gcc  
arc                  randconfig-r043-20230312   gcc  
arc                  randconfig-r043-20230313   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r003-20230313   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r001-20230312   gcc  
arm                  randconfig-r002-20230313   clang
arm                  randconfig-r025-20230313   gcc  
arm                  randconfig-r026-20230313   gcc  
arm                  randconfig-r036-20230312   gcc  
arm                  randconfig-r046-20230312   clang
arm                  randconfig-r046-20230313   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230313   gcc  
arm64                randconfig-r011-20230312   gcc  
arm64                randconfig-r015-20230313   clang
arm64                randconfig-r023-20230313   clang
csky                                defconfig   gcc  
csky                 randconfig-r003-20230313   gcc  
hexagon      buildonly-randconfig-r004-20230312   clang
hexagon      buildonly-randconfig-r005-20230313   clang
hexagon              randconfig-r004-20230313   clang
hexagon              randconfig-r015-20230312   clang
hexagon              randconfig-r022-20230313   clang
hexagon              randconfig-r041-20230312   clang
hexagon              randconfig-r041-20230313   clang
hexagon              randconfig-r045-20230312   clang
hexagon              randconfig-r045-20230313   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r002-20230313   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230313   gcc  
i386                          randconfig-a001   gcc  
i386                 randconfig-a002-20230313   gcc  
i386                          randconfig-a002   clang
i386                 randconfig-a003-20230313   gcc  
i386                          randconfig-a003   gcc  
i386                 randconfig-a004-20230313   gcc  
i386                          randconfig-a004   clang
i386                 randconfig-a005-20230313   gcc  
i386                          randconfig-a005   gcc  
i386                 randconfig-a006-20230313   gcc  
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230313   clang
i386                 randconfig-a012-20230313   clang
i386                 randconfig-a013-20230313   clang
i386                 randconfig-a014-20230313   clang
i386                 randconfig-a015-20230313   clang
i386                 randconfig-a016-20230313   clang
i386                 randconfig-r021-20230313   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230312   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r003-20230313   gcc  
ia64                 randconfig-r005-20230313   gcc  
ia64                 randconfig-r012-20230312   gcc  
ia64                 randconfig-r022-20230313   gcc  
ia64                 randconfig-r032-20230313   gcc  
ia64                 randconfig-r036-20230313   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r021-20230312   gcc  
loongarch            randconfig-r031-20230313   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230312   gcc  
m68k                 randconfig-r003-20230312   gcc  
m68k                 randconfig-r016-20230313   gcc  
m68k                 randconfig-r032-20230312   gcc  
m68k                 randconfig-r033-20230313   gcc  
m68k                 randconfig-r034-20230313   gcc  
microblaze   buildonly-randconfig-r002-20230313   gcc  
microblaze   buildonly-randconfig-r003-20230312   gcc  
microblaze           randconfig-r001-20230312   gcc  
microblaze           randconfig-r011-20230312   gcc  
microblaze           randconfig-r012-20230313   gcc  
microblaze           randconfig-r015-20230313   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230312   gcc  
mips                 randconfig-r002-20230312   gcc  
mips                 randconfig-r013-20230312   clang
nios2        buildonly-randconfig-r003-20230312   gcc  
nios2        buildonly-randconfig-r005-20230313   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230312   gcc  
nios2                randconfig-r012-20230313   gcc  
nios2                randconfig-r014-20230312   gcc  
nios2                randconfig-r021-20230313   gcc  
nios2                randconfig-r026-20230312   gcc  
nios2                randconfig-r032-20230312   gcc  
openrisc     buildonly-randconfig-r001-20230312   gcc  
openrisc     buildonly-randconfig-r006-20230312   gcc  
openrisc             randconfig-r035-20230313   gcc  
parisc       buildonly-randconfig-r006-20230313   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230313   gcc  
parisc               randconfig-r026-20230313   gcc  
parisc               randconfig-r033-20230312   gcc  
parisc               randconfig-r034-20230312   gcc  
parisc               randconfig-r035-20230312   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230313   clang
powerpc      buildonly-randconfig-r004-20230313   clang
powerpc              randconfig-r004-20230312   clang
powerpc              randconfig-r005-20230312   clang
powerpc              randconfig-r026-20230312   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230313   clang
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230312   gcc  
riscv                randconfig-r042-20230312   gcc  
riscv                randconfig-r042-20230313   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230313   gcc  
s390                 randconfig-r006-20230313   gcc  
s390                 randconfig-r011-20230313   clang
s390                 randconfig-r023-20230312   gcc  
s390                 randconfig-r031-20230312   clang
s390                 randconfig-r044-20230312   gcc  
s390                 randconfig-r044-20230313   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230312   gcc  
sh                   randconfig-r024-20230312   gcc  
sh                   randconfig-r035-20230312   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230312   gcc  
sparc                randconfig-r032-20230313   gcc  
sparc                randconfig-r036-20230313   gcc  
sparc64              randconfig-r006-20230312   gcc  
sparc64              randconfig-r022-20230312   gcc  
sparc64              randconfig-r024-20230312   gcc  
sparc64              randconfig-r024-20230313   gcc  
sparc64              randconfig-r034-20230312   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230313   gcc  
x86_64               randconfig-a002-20230313   gcc  
x86_64               randconfig-a003-20230313   gcc  
x86_64               randconfig-a004-20230313   gcc  
x86_64               randconfig-a005-20230313   gcc  
x86_64               randconfig-a006-20230313   gcc  
x86_64               randconfig-a011-20230313   clang
x86_64               randconfig-a012-20230313   clang
x86_64               randconfig-a013-20230313   clang
x86_64               randconfig-a014-20230313   clang
x86_64               randconfig-a015-20230313   clang
x86_64               randconfig-a016-20230313   clang
x86_64               randconfig-r002-20230313   gcc  
x86_64               randconfig-r014-20230313   clang
x86_64               randconfig-r016-20230313   clang
x86_64               randconfig-r023-20230313   clang
x86_64               randconfig-r024-20230313   clang
x86_64               randconfig-r025-20230313   clang
x86_64               randconfig-r033-20230313   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230312   gcc  
xtensa               randconfig-r006-20230313   gcc  
xtensa               randconfig-r013-20230313   gcc  
xtensa               randconfig-r014-20230313   gcc  
xtensa               randconfig-r015-20230312   gcc  
xtensa               randconfig-r016-20230312   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
