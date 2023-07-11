Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D0674E271
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 02:06:54 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VNDL1Vb4;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R0LlH6fDFz3bZ3
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 10:06:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VNDL1Vb4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R0Ll83rhdz2yLV
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Jul 2023 10:06:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689034004; x=1720570004;
  h=date:from:to:cc:subject:message-id;
  bh=AhW+4LQGTUwIS5qiZk2edSbPgh6H21y+yx+uZjcKCqs=;
  b=VNDL1Vb4buw0toX7kwM++ySc1Myo2BS5q19Gy7alQ6kRe7B5rin0OTUA
   3d0DR59MJpi+x1hUuEgA2QvGYWpxlfnwhVnd2q5n4cU/i8l3AwsN7lvQl
   SjyA4UhJJ9qSbRTs4tBuseAgDP4QfV98qmeAxqDz/p5bZBUPWkNLK5gvl
   Px5hnJz961n+tOBBAozVzndnEUSybxtp6KF1fYoJ1SvC1+ghpV5ggD4Sb
   zQ/edZMAcJtUT9jLZuBsXIr5KJaFVjYyS41o/rxffuepjAhYxU8V2LT2C
   ogAo2uBs+H7FaQKBLY04g5//mGNRcUwMzQO/SJ5aS8pOaQIOx24m2Immv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="367066563"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="367066563"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 17:06:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="894971940"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="894971940"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Jul 2023 17:06:33 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qJ0tk-00047m-1X;
	Tue, 11 Jul 2023 00:06:32 +0000
Date: Tue, 11 Jul 2023 08:06:10 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 770c413f54a4a69e1f398228aa12147b7cdaa4b4
Message-ID: <202307110809.OhAsg3B7-lkp@intel.com>
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
branch HEAD: 770c413f54a4a69e1f398228aa12147b7cdaa4b4  erofs: avoid infinite loop in z_erofs_do_read_page() when reading beyond EOF

elapsed time: 725m

configs tested: 120
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230710   gcc  
alpha                randconfig-r014-20230710   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                  randconfig-r001-20230710   gcc  
arc                  randconfig-r043-20230710   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                          collie_defconfig   clang
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                   milbeaut_m10v_defconfig   clang
arm                        neponset_defconfig   clang
arm                            qcom_defconfig   gcc  
arm                  randconfig-r025-20230710   gcc  
arm                  randconfig-r046-20230710   gcc  
arm                         s5pv210_defconfig   clang
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230710   clang
hexagon              randconfig-r045-20230710   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230710   gcc  
i386         buildonly-randconfig-r005-20230710   gcc  
i386         buildonly-randconfig-r006-20230710   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230710   gcc  
i386                 randconfig-i002-20230710   gcc  
i386                 randconfig-i003-20230710   gcc  
i386                 randconfig-i004-20230710   gcc  
i386                 randconfig-i005-20230710   gcc  
i386                 randconfig-i006-20230710   gcc  
i386                 randconfig-i011-20230710   clang
i386                 randconfig-i012-20230710   clang
i386                 randconfig-i013-20230710   clang
i386                 randconfig-i014-20230710   clang
i386                 randconfig-i015-20230710   clang
i386                 randconfig-i016-20230710   clang
i386                 randconfig-r024-20230710   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r034-20230710   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230710   gcc  
m68k                 randconfig-r016-20230710   gcc  
microblaze           randconfig-r003-20230710   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230710   gcc  
nios2                randconfig-r013-20230710   gcc  
nios2                randconfig-r032-20230710   gcc  
openrisc             randconfig-r033-20230710   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc                 mpc832x_rdb_defconfig   clang
powerpc                     sequoia_defconfig   gcc  
powerpc                     tqm8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r026-20230710   clang
riscv                randconfig-r042-20230710   clang
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230710   clang
sh                               allmodconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r031-20230710   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230710   gcc  
x86_64       buildonly-randconfig-r002-20230710   gcc  
x86_64       buildonly-randconfig-r003-20230710   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230710   clang
x86_64               randconfig-x002-20230710   clang
x86_64               randconfig-x003-20230710   clang
x86_64               randconfig-x004-20230710   clang
x86_64               randconfig-x005-20230710   clang
x86_64               randconfig-x006-20230710   clang
x86_64               randconfig-x011-20230710   gcc  
x86_64               randconfig-x012-20230710   gcc  
x86_64               randconfig-x013-20230710   gcc  
x86_64               randconfig-x014-20230710   gcc  
x86_64               randconfig-x015-20230710   gcc  
x86_64               randconfig-x016-20230710   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa               randconfig-r004-20230710   gcc  
xtensa               randconfig-r035-20230710   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
