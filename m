Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C42733539
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jun 2023 17:55:59 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NgWRM+UO;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QjNzx4T88z3bjX
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Jun 2023 01:55:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NgWRM+UO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QjNzp4jfkz3bd6
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 Jun 2023 01:55:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686930950; x=1718466950;
  h=date:from:to:cc:subject:message-id;
  bh=p4E24pl2phHmdpqj1GflxtQg7ZhIhW+kClc/AdG2HWU=;
  b=NgWRM+UO2sK3SbQSJkzSH/NcwgtzFWmpjOYbe8MCIH3ewee50QixZC0Y
   FyfDpl4CaqnHxu08pRUAmvqQUWLj0QSoYtNdcjT/LlCwGnvoa9yF3KlJm
   wC7bth3aYQE+JWELjI3d/ihLug2Og/pJDuyqpzLgknc/m7NTdSTK8T3iS
   vKgfKmJYIeoPOeSKgn5eQhED1etHQVgTRXnGGk10NyouavKCyQaz82Ro0
   Arkm6dEXYhfdUKYzhqk5guc+BOQ8i36ybAZr3KmXOsdovZIf0FWQRl/RX
   NVLfFA/EYTeSst9WRwmO+a9wfxU13LyIf8HZhIj4qClIBl3sEdRh7BuII
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356737428"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="356737428"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 08:55:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="778198577"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="778198577"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jun 2023 08:55:40 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qABnX-0001VM-0x;
	Fri, 16 Jun 2023 15:55:39 +0000
Date: Fri, 16 Jun 2023 23:55:04 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 cd353fcfeb4798170ed31e32e499ac58cd36b5d2
Message-ID: <202306162302.dmGgwrzC-lkp@intel.com>
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
branch HEAD: cd353fcfeb4798170ed31e32e499ac58cd36b5d2  erofs: clean up zmap.c

elapsed time: 720m

configs tested: 189
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230616   gcc  
alpha                randconfig-r005-20230616   gcc  
alpha                randconfig-r011-20230614   gcc  
alpha                randconfig-r013-20230614   gcc  
alpha                randconfig-r025-20230615   gcc  
alpha                randconfig-r026-20230615   gcc  
alpha                randconfig-r033-20230616   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r006-20230616   gcc  
arc                  randconfig-r036-20230615   gcc  
arc                  randconfig-r043-20230615   gcc  
arc                  randconfig-r043-20230616   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230615   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                  randconfig-r001-20230616   gcc  
arm                  randconfig-r016-20230616   clang
arm                  randconfig-r031-20230615   clang
arm                  randconfig-r046-20230615   gcc  
arm                        spear6xx_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230614   gcc  
arm64                randconfig-r013-20230614   gcc  
csky         buildonly-randconfig-r003-20230614   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r034-20230615   gcc  
hexagon              randconfig-r001-20230616   clang
hexagon              randconfig-r011-20230616   clang
hexagon              randconfig-r015-20230614   clang
hexagon              randconfig-r024-20230615   clang
hexagon              randconfig-r024-20230616   clang
hexagon              randconfig-r025-20230615   clang
hexagon              randconfig-r041-20230615   clang
hexagon              randconfig-r045-20230615   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230616   clang
i386         buildonly-randconfig-r005-20230615   gcc  
i386         buildonly-randconfig-r005-20230616   clang
i386         buildonly-randconfig-r006-20230616   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230614   clang
i386                 randconfig-i001-20230615   gcc  
i386                 randconfig-i001-20230616   clang
i386                 randconfig-i002-20230614   clang
i386                 randconfig-i002-20230615   gcc  
i386                 randconfig-i002-20230616   clang
i386                 randconfig-i003-20230614   clang
i386                 randconfig-i003-20230615   gcc  
i386                 randconfig-i003-20230616   clang
i386                 randconfig-i004-20230614   clang
i386                 randconfig-i004-20230615   gcc  
i386                 randconfig-i004-20230616   clang
i386                 randconfig-i005-20230614   clang
i386                 randconfig-i005-20230615   gcc  
i386                 randconfig-i005-20230616   clang
i386                 randconfig-i006-20230614   clang
i386                 randconfig-i006-20230615   gcc  
i386                 randconfig-i006-20230616   clang
i386                 randconfig-i011-20230614   gcc  
i386                 randconfig-i011-20230615   clang
i386                 randconfig-i011-20230616   gcc  
i386                 randconfig-i012-20230614   gcc  
i386                 randconfig-i012-20230615   clang
i386                 randconfig-i012-20230616   gcc  
i386                 randconfig-i013-20230614   gcc  
i386                 randconfig-i013-20230615   clang
i386                 randconfig-i013-20230616   gcc  
i386                 randconfig-i014-20230614   gcc  
i386                 randconfig-i014-20230615   clang
i386                 randconfig-i014-20230616   gcc  
i386                 randconfig-i015-20230614   gcc  
i386                 randconfig-i015-20230615   clang
i386                 randconfig-i015-20230616   gcc  
i386                 randconfig-i016-20230614   gcc  
i386                 randconfig-i016-20230615   clang
i386                 randconfig-i016-20230616   gcc  
i386                 randconfig-r014-20230614   gcc  
i386                 randconfig-r023-20230615   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230614   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r034-20230615   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze   buildonly-randconfig-r002-20230614   gcc  
microblaze           randconfig-r004-20230616   gcc  
microblaze           randconfig-r033-20230615   gcc  
microblaze           randconfig-r035-20230615   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        omega2p_defconfig   clang
mips                 randconfig-r003-20230616   gcc  
mips                 randconfig-r006-20230616   gcc  
mips                 randconfig-r015-20230614   clang
mips                 randconfig-r022-20230615   gcc  
mips                 randconfig-r023-20230615   gcc  
mips                 randconfig-r024-20230615   gcc  
nios2        buildonly-randconfig-r006-20230615   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r016-20230614   gcc  
nios2                randconfig-r032-20230616   gcc  
nios2                randconfig-r034-20230616   gcc  
nios2                randconfig-r036-20230615   gcc  
openrisc     buildonly-randconfig-r001-20230614   gcc  
openrisc     buildonly-randconfig-r006-20230614   gcc  
openrisc             randconfig-r035-20230615   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r021-20230615   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     kilauea_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc              randconfig-r032-20230615   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r033-20230615   gcc  
riscv                randconfig-r042-20230615   clang
riscv                randconfig-r042-20230616   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230616   clang
s390                 randconfig-r003-20230616   clang
s390                 randconfig-r011-20230614   gcc  
s390                 randconfig-r026-20230615   clang
s390                 randconfig-r044-20230615   clang
s390                 randconfig-r044-20230616   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230615   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                   randconfig-r005-20230616   gcc  
sh                   randconfig-r016-20230614   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64      buildonly-randconfig-r001-20230615   gcc  
sparc64              randconfig-r021-20230615   gcc  
sparc64              randconfig-r022-20230615   gcc  
um                               alldefconfig   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r036-20230616   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230616   clang
x86_64       buildonly-randconfig-r002-20230616   clang
x86_64       buildonly-randconfig-r003-20230616   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230616   clang
x86_64               randconfig-a002-20230616   clang
x86_64               randconfig-a003-20230616   clang
x86_64               randconfig-a004-20230616   clang
x86_64               randconfig-a005-20230616   clang
x86_64               randconfig-a006-20230616   clang
x86_64               randconfig-a011-20230615   clang
x86_64               randconfig-a011-20230616   gcc  
x86_64               randconfig-a012-20230615   clang
x86_64               randconfig-a012-20230616   gcc  
x86_64               randconfig-a013-20230615   clang
x86_64               randconfig-a013-20230616   gcc  
x86_64               randconfig-a014-20230616   gcc  
x86_64               randconfig-a015-20230616   gcc  
x86_64               randconfig-a016-20230616   gcc  
x86_64               randconfig-r032-20230615   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230614   gcc  
xtensa       buildonly-randconfig-r004-20230615   gcc  
xtensa               randconfig-r002-20230616   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
