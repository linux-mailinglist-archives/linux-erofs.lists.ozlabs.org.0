Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B056AA5A3
	for <lists+linux-erofs@lfdr.de>; Sat,  4 Mar 2023 00:31:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PT43Q6lXNz3chr
	for <lists+linux-erofs@lfdr.de>; Sat,  4 Mar 2023 10:30:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TFtbWNUK;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TFtbWNUK;
	dkim-atps=neutral
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PT43G0Gsbz3cJg
	for <linux-erofs@lists.ozlabs.org>; Sat,  4 Mar 2023 10:30:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677886250; x=1709422250;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LSvikSS5s8wjw8zelv6/oncP2Jr8RYmbkFVhE3kYAZk=;
  b=TFtbWNUKeGA7qW1RcPBeOUBUa5XnV+6vslP9dfhNkjFu9S3sgCyfq7+J
   xUIz3r7z/SlrykYtkYwGMvJRCwkEZRO9pBMoLM7OWeK+q31Tespl7yl7n
   ul2GrVzGWVTSHpPXHGHi5wUZkFeWaUhb8kVjVQwgUoIOSLr4GE2ojH7PB
   e9FqJ9Ztw0T/yM8czaj/YPphPJt0mHwOpzc52z0EKECt8847+zQGWJS8t
   sXlQjDF9MsQ4XFmUHaeR8Y9WGnQE+mSh0Qa44/GYqCm07i3805nDEgOF/
   DmAlcFo8iXSGqAoRkTvugi85SmWV+EdjPrRFmt8V6IRU3lrvZeheyAyVI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="333907069"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="333907069"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 15:30:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="785467602"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="785467602"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 Mar 2023 15:30:30 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pYEr6-0001j0-0h;
	Fri, 03 Mar 2023 23:30:28 +0000
Date: Sat, 04 Mar 2023 07:29:47 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 d09cfab889aed9df42719221b4093baa949e41d5
Message-ID: <640282eb.MMLe2+ITRIk0ZKvv%lkp@intel.com>
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
branch HEAD: d09cfab889aed9df42719221b4093baa949e41d5  erofs: mark z_erofs_lzma_init/erofs_pcpubuf_init w/ __init

elapsed time: 732m

configs tested: 137
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230302   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230302   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230302   gcc  
arc                  randconfig-r043-20230302   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230302   clang
arm                  randconfig-r032-20230302   clang
arm                  randconfig-r046-20230302   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230302   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230302   clang
csky                                defconfig   gcc  
csky                 randconfig-r002-20230302   gcc  
csky                 randconfig-r005-20230303   gcc  
csky                 randconfig-r025-20230302   gcc  
csky                 randconfig-r035-20230302   gcc  
hexagon      buildonly-randconfig-r002-20230302   clang
hexagon      buildonly-randconfig-r005-20230302   clang
hexagon              randconfig-r001-20230303   clang
hexagon              randconfig-r026-20230302   clang
hexagon              randconfig-r032-20230302   clang
hexagon              randconfig-r041-20230302   clang
hexagon              randconfig-r045-20230302   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230302   gcc  
ia64                 randconfig-r005-20230302   gcc  
ia64                 randconfig-r014-20230302   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230302   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r015-20230302   gcc  
loongarch            randconfig-r016-20230302   gcc  
loongarch            randconfig-r033-20230302   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r021-20230302   gcc  
microblaze           randconfig-r002-20230302   gcc  
microblaze           randconfig-r036-20230302   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r004-20230302   clang
mips                 randconfig-r022-20230302   gcc  
mips                 randconfig-r031-20230302   clang
nios2        buildonly-randconfig-r001-20230302   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r016-20230302   gcc  
nios2                randconfig-r031-20230302   gcc  
openrisc             randconfig-r003-20230302   gcc  
openrisc             randconfig-r024-20230302   gcc  
parisc       buildonly-randconfig-r003-20230302   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r015-20230302   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230302   clang
powerpc              randconfig-r003-20230303   clang
powerpc              randconfig-r023-20230302   clang
powerpc              randconfig-r024-20230302   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230302   clang
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230303   clang
riscv                randconfig-r004-20230303   clang
riscv                randconfig-r006-20230303   clang
riscv                randconfig-r012-20230302   clang
riscv                randconfig-r021-20230302   clang
riscv                randconfig-r034-20230302   gcc  
riscv                randconfig-r035-20230302   gcc  
riscv                randconfig-r042-20230302   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230302   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r033-20230302   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230302   gcc  
sparc                randconfig-r023-20230302   gcc  
sparc                randconfig-r026-20230302   gcc  
sparc                randconfig-r034-20230302   gcc  
sparc64              randconfig-r011-20230302   gcc  
sparc64              randconfig-r013-20230302   gcc  
sparc64              randconfig-r025-20230302   gcc  
sparc64              randconfig-r036-20230302   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r006-20230302   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
