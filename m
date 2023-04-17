Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E64C6E3FF7
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 08:42:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q0HXN5XfNz3cM3
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Apr 2023 16:41:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PRa/O94d;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PRa/O94d;
	dkim-atps=neutral
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q0HXG0WvHz2xjw
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Apr 2023 16:41:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681713710; x=1713249710;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dPC3GUp7m7oC68XKFOPYhmmAwpV9QDdUHGPKVTKL8Vk=;
  b=PRa/O94dWlYs9tIEEx8oVMBT50bX4IZdGu3aNeAmBVo3OJ/9aloSmKsZ
   xkPEZYXBLYftl4amnih3c9hEcX1ItK54j/VZ+Hd//lgiaRvo0bKltDldv
   a+OJCsWewI09vMpRnAG5tk0C/W0/89oadZQkRvYpfrkzoJ6HBTTBwWeMW
   oLDN0sLMfSV8UZPNIRi0jXIBjYjbpfzWXtpXMyLZUme+niAKrroBLwAh3
   IcpJjtfr+SY0fhCL2ZCqyy4KEALAO15csxepwQQYKwQSfk7GUcdIqQ0kT
   3ZaDIvhCsfAn2IsubMI+4e4rrNif0h5NCpV3s7mA83W4FWDPCkeryicv+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="344816749"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="344816749"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 23:41:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="723143594"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="723143594"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 16 Apr 2023 23:41:38 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1poIYT-000cDH-10;
	Mon, 17 Apr 2023 06:41:37 +0000
Date: Mon, 17 Apr 2023 14:41:31 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 745ed7d77834048879bf24088c94e5a6462b613f
Message-ID: <643cea1b.fbx/QENIgV0XuCRo%lkp@intel.com>
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
branch HEAD: 745ed7d77834048879bf24088c94e5a6462b613f  erofs: cleanup i_format-related stuffs

elapsed time: 785m

configs tested: 186
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230417   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230416   gcc  
alpha                randconfig-r033-20230416   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230416   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r016-20230416   gcc  
arc                  randconfig-r031-20230417   gcc  
arc                  randconfig-r043-20230416   gcc  
arc                  randconfig-r043-20230417   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r005-20230416   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                        oxnas_v6_defconfig   gcc  
arm                  randconfig-r002-20230416   gcc  
arm                  randconfig-r011-20230416   clang
arm                  randconfig-r015-20230416   clang
arm                  randconfig-r022-20230416   clang
arm                  randconfig-r024-20230416   clang
arm                  randconfig-r032-20230417   clang
arm                  randconfig-r034-20230417   clang
arm                  randconfig-r046-20230416   clang
arm                  randconfig-r046-20230417   gcc  
arm                           spitz_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230416   gcc  
arm64                randconfig-r023-20230417   clang
arm64                randconfig-r025-20230417   clang
arm64                randconfig-r026-20230417   clang
arm64                randconfig-r036-20230416   clang
csky                                defconfig   gcc  
csky                 randconfig-r016-20230417   gcc  
csky                 randconfig-r025-20230416   gcc  
csky                 randconfig-r026-20230416   gcc  
csky                 randconfig-r035-20230416   gcc  
csky                 randconfig-r035-20230417   gcc  
hexagon      buildonly-randconfig-r003-20230417   clang
hexagon              randconfig-r002-20230416   clang
hexagon              randconfig-r005-20230416   clang
hexagon              randconfig-r033-20230417   clang
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r041-20230417   clang
hexagon              randconfig-r045-20230416   clang
hexagon              randconfig-r045-20230417   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230417   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                 randconfig-a005-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
i386                 randconfig-r013-20230417   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230417   gcc  
ia64         buildonly-randconfig-r002-20230417   gcc  
ia64         buildonly-randconfig-r005-20230416   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230416   gcc  
ia64                 randconfig-r024-20230417   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r022-20230417   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r006-20230416   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230416   gcc  
m68k                 randconfig-r022-20230417   gcc  
m68k                 randconfig-r031-20230417   gcc  
m68k                 randconfig-r035-20230416   gcc  
m68k                 randconfig-r036-20230417   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     loongson1c_defconfig   clang
mips                 randconfig-r015-20230416   clang
mips                 randconfig-r026-20230417   gcc  
mips                 randconfig-r035-20230417   clang
nios2        buildonly-randconfig-r001-20230416   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230416   gcc  
nios2                randconfig-r006-20230416   gcc  
nios2                randconfig-r023-20230416   gcc  
openrisc     buildonly-randconfig-r006-20230417   gcc  
openrisc             randconfig-r021-20230416   gcc  
openrisc             randconfig-r034-20230416   gcc  
openrisc             randconfig-r036-20230417   gcc  
parisc       buildonly-randconfig-r003-20230416   gcc  
parisc       buildonly-randconfig-r004-20230416   gcc  
parisc       buildonly-randconfig-r004-20230417   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230416   gcc  
parisc               randconfig-r014-20230416   gcc  
parisc               randconfig-r026-20230416   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230417   clang
powerpc      buildonly-randconfig-r003-20230417   clang
powerpc      buildonly-randconfig-r004-20230417   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc              randconfig-r025-20230416   gcc  
powerpc              randconfig-r032-20230416   clang
powerpc                     taishan_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230416   clang
riscv                randconfig-r033-20230417   gcc  
riscv                randconfig-r034-20230416   clang
riscv                randconfig-r042-20230416   gcc  
riscv                randconfig-r042-20230417   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r004-20230416   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r024-20230416   gcc  
s390                 randconfig-r024-20230417   clang
s390                 randconfig-r031-20230416   clang
s390                 randconfig-r044-20230416   gcc  
s390                 randconfig-r044-20230417   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230416   gcc  
sh           buildonly-randconfig-r003-20230416   gcc  
sh           buildonly-randconfig-r005-20230417   gcc  
sh                   randconfig-r011-20230416   gcc  
sh                   randconfig-r012-20230416   gcc  
sh                   randconfig-r031-20230416   gcc  
sh                   randconfig-r034-20230417   gcc  
sh                   randconfig-r036-20230416   gcc  
sh                           se7750_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc        buildonly-randconfig-r001-20230416   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230416   gcc  
sparc                randconfig-r012-20230417   gcc  
sparc                randconfig-r032-20230416   gcc  
sparc                randconfig-r032-20230417   gcc  
sparc64      buildonly-randconfig-r002-20230416   gcc  
sparc64      buildonly-randconfig-r002-20230417   gcc  
sparc64              randconfig-r003-20230416   gcc  
sparc64              randconfig-r014-20230417   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230417   gcc  
x86_64               randconfig-a002-20230417   gcc  
x86_64               randconfig-a003-20230417   gcc  
x86_64               randconfig-a004-20230417   gcc  
x86_64               randconfig-a005-20230417   gcc  
x86_64               randconfig-a006-20230417   gcc  
x86_64               randconfig-a011-20230417   clang
x86_64               randconfig-a012-20230417   clang
x86_64               randconfig-a013-20230417   clang
x86_64               randconfig-a014-20230417   clang
x86_64               randconfig-a015-20230417   clang
x86_64               randconfig-a016-20230417   clang
x86_64               randconfig-r011-20230417   clang
x86_64               randconfig-r021-20230417   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r012-20230416   gcc  
xtensa               randconfig-r021-20230416   gcc  
xtensa               randconfig-r021-20230417   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
