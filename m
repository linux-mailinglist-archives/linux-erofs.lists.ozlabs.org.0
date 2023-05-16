Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C4770430E
	for <lists+linux-erofs@lfdr.de>; Tue, 16 May 2023 03:44:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QKzYJ6wW5z3f6R
	for <lists+linux-erofs@lfdr.de>; Tue, 16 May 2023 11:44:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZOw4ENDA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZOw4ENDA;
	dkim-atps=neutral
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QKzYC5LNBz3f5s
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 May 2023 11:43:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684201439; x=1715737439;
  h=date:from:to:cc:subject:message-id;
  bh=Q2+OtDnTn3aXDN2Ed1OjlurjGXj14XPlQq6UVcyPKxQ=;
  b=ZOw4ENDA0enK4zkOk3iSOX9GjRHHfpdYk6KUGIcDeB+vAO8iW7CtONBt
   cERrlL9f8jKEU8g8z4w9nTJiDcf0P2MelwjjKoW2tZ/xyblCl1or8DB/q
   L+zljJ+XTjNCMDMsQsGw36uKfcKrz7KvPPlwe4z8Hot2J1xC7W2j/zS89
   gdnsbXWOgiDDWuRpjRb/eeBkcRJV0hy8OMVRihcE6gO/s0fRuEGIWVVAU
   I5Kpeu966V34tfn3Rrq/PXlRpthk5ksmABsxgF5yoagJzjTUYlrwSD4XA
   wglvJ2hDKiakKTwp5cDJrrA1Qu/bJGwCqs03YknlFqeCr7s0Mko0pJknt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="340715327"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="340715327"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 18:43:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="875428094"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="875428094"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 May 2023 18:43:48 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pyjj9-0006pk-2j;
	Tue, 16 May 2023 01:43:47 +0000
Date: Tue, 16 May 2023 09:43:25 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 88d712c1871295c3bc9803d10cda8895920b21b3
Message-ID: <20230516014325.7k3zv%lkp@intel.com>
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
branch HEAD: 88d712c1871295c3bc9803d10cda8895920b21b3  erofs: avoid pcpubuf.c inclusion if CONFIG_EROFS_FS_ZIP is off

elapsed time: 866m

configs tested: 188
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r003-20230515   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                  randconfig-r005-20230515   gcc  
arc                  randconfig-r015-20230515   gcc  
arc                  randconfig-r022-20230515   gcc  
arc                  randconfig-r043-20230515   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                  randconfig-r046-20230515   clang
arm                       versatile_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230515   gcc  
arm64                randconfig-r015-20230515   gcc  
arm64                randconfig-r022-20230515   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r006-20230515   clang
hexagon              randconfig-r031-20230515   clang
hexagon              randconfig-r041-20230515   clang
hexagon              randconfig-r045-20230515   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230515   clang
i386                 randconfig-a002-20230515   clang
i386                 randconfig-a003-20230515   clang
i386                 randconfig-a004-20230515   clang
i386                 randconfig-a005-20230515   clang
i386                 randconfig-a006-20230515   clang
i386                 randconfig-a011-20230515   gcc  
i386                 randconfig-a012-20230515   gcc  
i386                 randconfig-a013-20230515   gcc  
i386                 randconfig-a014-20230515   gcc  
i386                 randconfig-a015-20230515   gcc  
i386                 randconfig-a016-20230515   gcc  
i386                 randconfig-i051-20230515   clang
i386                 randconfig-i052-20230515   clang
i386                 randconfig-i053-20230515   clang
i386                 randconfig-i054-20230515   clang
i386                 randconfig-i055-20230515   clang
i386                 randconfig-i056-20230515   clang
i386                 randconfig-i061-20230515   clang
i386                 randconfig-i062-20230515   clang
i386                 randconfig-i063-20230515   clang
i386                 randconfig-i064-20230515   clang
i386                 randconfig-i065-20230515   clang
i386                 randconfig-i066-20230515   clang
i386                 randconfig-i071-20230515   gcc  
i386                          randconfig-i071   clang
i386                 randconfig-i072-20230515   gcc  
i386                 randconfig-i073-20230515   gcc  
i386                          randconfig-i073   clang
i386                 randconfig-i074-20230515   gcc  
i386                 randconfig-i075-20230515   gcc  
i386                          randconfig-i075   clang
i386                 randconfig-i076-20230515   gcc  
i386                 randconfig-i081-20230515   gcc  
i386                 randconfig-i082-20230515   gcc  
i386                 randconfig-i083-20230515   gcc  
i386                 randconfig-i084-20230515   gcc  
i386                 randconfig-i085-20230515   gcc  
i386                 randconfig-i086-20230515   gcc  
i386                 randconfig-i091-20230515   clang
i386                 randconfig-i092-20230515   clang
i386                 randconfig-i093-20230515   clang
i386                 randconfig-i094-20230515   clang
i386                 randconfig-i095-20230515   clang
i386                 randconfig-i096-20230515   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r011-20230515   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230515   gcc  
loongarch            randconfig-r024-20230515   gcc  
loongarch            randconfig-r033-20230515   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230515   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230515   gcc  
m68k                 randconfig-r014-20230515   gcc  
m68k                 randconfig-r023-20230515   gcc  
m68k                 randconfig-r034-20230515   gcc  
microblaze           randconfig-r014-20230515   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips         buildonly-randconfig-r005-20230515   gcc  
mips                 randconfig-r025-20230515   clang
mips                           rs90_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r026-20230515   gcc  
nios2                randconfig-r033-20230515   gcc  
nios2                randconfig-r034-20230515   gcc  
openrisc     buildonly-randconfig-r006-20230515   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r023-20230515   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        fsp2_defconfig   clang
powerpc                   microwatt_defconfig   clang
powerpc              randconfig-r002-20230515   clang
powerpc                     tqm8560_defconfig   clang
powerpc                      tqm8xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230515   gcc  
riscv        buildonly-randconfig-r006-20230515   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230515   clang
riscv                randconfig-r004-20230515   clang
riscv                randconfig-r013-20230515   gcc  
riscv                randconfig-r042-20230515   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230515   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230515   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230515   gcc  
sh                   randconfig-r032-20230515   gcc  
sparc        buildonly-randconfig-r004-20230515   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r025-20230515   gcc  
sparc64              randconfig-r024-20230515   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230515   clang
x86_64               randconfig-a002-20230515   clang
x86_64               randconfig-a003-20230515   clang
x86_64               randconfig-a004-20230515   clang
x86_64               randconfig-a005-20230515   clang
x86_64               randconfig-a006-20230515   clang
x86_64               randconfig-a011-20230515   gcc  
x86_64               randconfig-a012-20230515   gcc  
x86_64               randconfig-a013-20230515   gcc  
x86_64               randconfig-a014-20230515   gcc  
x86_64               randconfig-a015-20230515   gcc  
x86_64               randconfig-a016-20230515   gcc  
x86_64               randconfig-k001-20230515   gcc  
x86_64               randconfig-r026-20230515   gcc  
x86_64               randconfig-x051-20230515   gcc  
x86_64               randconfig-x052-20230515   gcc  
x86_64               randconfig-x053-20230515   gcc  
x86_64               randconfig-x054-20230515   gcc  
x86_64               randconfig-x055-20230515   gcc  
x86_64               randconfig-x056-20230515   gcc  
x86_64               randconfig-x061-20230515   gcc  
x86_64               randconfig-x062-20230515   gcc  
x86_64               randconfig-x063-20230515   gcc  
x86_64               randconfig-x064-20230515   gcc  
x86_64               randconfig-x065-20230515   gcc  
x86_64               randconfig-x066-20230515   gcc  
x86_64               randconfig-x071-20230515   clang
x86_64               randconfig-x072-20230515   clang
x86_64               randconfig-x073-20230515   clang
x86_64               randconfig-x074-20230515   clang
x86_64               randconfig-x075-20230515   clang
x86_64               randconfig-x076-20230515   clang
x86_64               randconfig-x081-20230515   clang
x86_64               randconfig-x082-20230515   clang
x86_64               randconfig-x083-20230515   clang
x86_64               randconfig-x084-20230515   clang
x86_64               randconfig-x085-20230515   clang
x86_64               randconfig-x086-20230515   clang
x86_64               randconfig-x091-20230515   gcc  
x86_64               randconfig-x092-20230515   gcc  
x86_64               randconfig-x093-20230515   gcc  
x86_64               randconfig-x094-20230515   gcc  
x86_64               randconfig-x095-20230515   gcc  
x86_64               randconfig-x096-20230515   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r036-20230515   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
