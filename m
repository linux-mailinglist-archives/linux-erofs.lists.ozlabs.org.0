Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B18715DE3
	for <lists+linux-erofs@lfdr.de>; Tue, 30 May 2023 13:52:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QVrNf5GBTz3cXf
	for <lists+linux-erofs@lfdr.de>; Tue, 30 May 2023 21:52:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UdY6eqDd;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UdY6eqDd;
	dkim-atps=neutral
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QVrNY4MQjz3bck
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 May 2023 21:52:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685447533; x=1716983533;
  h=date:from:to:cc:subject:message-id;
  bh=fznfj7aniWdXVQg/E6IRJEojmb8mkr3lUnyKqAyxcLA=;
  b=UdY6eqDdUF4iqx9dcga3y8KMnUJTts9ucMs3M9TY8X6gt62BU5USXQk6
   T0pAnW33rhuwvtaqx1GbVdg4hAM30SFJgsq6AUVjNp8+hLVbwrTqbdzy8
   yP4JEBjbu9iwhQB1pcIDzrg6jxTLrYLWDKVqf3+gO0Y8GYHwyvKjomo++
   d1qY54nEw7TuamW6zMBT8YzeVYmRgT1urs2zch1lsjTJZT0D1MDG6XhmN
   83zQ115QuGaiwW/6BJmKWDKUTeDD46tCBw/oe8tt27vJcRqyeWEX+GlHq
   6PVKLDZj6cFbb7QADafliyubzry6IYV8EoemyeSEkxIt0e8SxaU898oRB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="357265795"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="357265795"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 04:52:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="683932766"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="683932766"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 May 2023 04:52:00 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1q3xtP-0000HS-39;
	Tue, 30 May 2023 11:51:59 +0000
Date: Tue, 30 May 2023 19:51:36 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 bb9883487a39755f9ea631c6e4c84b3cca313570
Message-ID: <20230530115136.VdOUk%lkp@intel.com>
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
branch HEAD: bb9883487a39755f9ea631c6e4c84b3cca313570  erofs: use poison pointer to replace the hard-coded address

elapsed time: 1194m

configs tested: 204
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r034-20230529   gcc  
arc                  randconfig-r043-20230529   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230529   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230529   clang
arm64                               defconfig   gcc  
arm64                randconfig-r024-20230529   gcc  
arm64                randconfig-r026-20230529   gcc  
csky         buildonly-randconfig-r001-20230529   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230529   gcc  
hexagon      buildonly-randconfig-r005-20230529   clang
hexagon      buildonly-randconfig-r006-20230530   clang
hexagon              randconfig-r041-20230529   clang
hexagon              randconfig-r045-20230529   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230529   clang
i386                 randconfig-i002-20230529   clang
i386                 randconfig-i003-20230529   clang
i386                 randconfig-i004-20230529   clang
i386                 randconfig-i005-20230529   clang
i386                 randconfig-i006-20230529   clang
i386                 randconfig-i011-20230529   gcc  
i386                 randconfig-i011-20230530   gcc  
i386                 randconfig-i012-20230529   gcc  
i386                 randconfig-i012-20230530   gcc  
i386                 randconfig-i013-20230529   gcc  
i386                 randconfig-i013-20230530   gcc  
i386                 randconfig-i014-20230529   gcc  
i386                 randconfig-i014-20230530   gcc  
i386                 randconfig-i015-20230529   gcc  
i386                 randconfig-i015-20230530   gcc  
i386                 randconfig-i016-20230529   gcc  
i386                 randconfig-i016-20230530   gcc  
i386                 randconfig-i051-20230529   clang
i386                 randconfig-i051-20230530   clang
i386                 randconfig-i052-20230529   clang
i386                 randconfig-i052-20230530   clang
i386                 randconfig-i053-20230529   clang
i386                 randconfig-i053-20230530   clang
i386                 randconfig-i054-20230529   clang
i386                 randconfig-i054-20230530   clang
i386                 randconfig-i055-20230529   clang
i386                 randconfig-i055-20230530   clang
i386                 randconfig-i056-20230529   clang
i386                 randconfig-i056-20230530   clang
i386                 randconfig-i061-20230529   clang
i386                 randconfig-i061-20230530   clang
i386                 randconfig-i062-20230529   clang
i386                 randconfig-i062-20230530   clang
i386                 randconfig-i063-20230529   clang
i386                 randconfig-i063-20230530   clang
i386                 randconfig-i064-20230529   clang
i386                 randconfig-i064-20230530   clang
i386                 randconfig-i065-20230529   clang
i386                 randconfig-i065-20230530   clang
i386                 randconfig-i066-20230529   clang
i386                 randconfig-i066-20230530   clang
i386                 randconfig-i071-20230529   gcc  
i386                 randconfig-i072-20230529   gcc  
i386                 randconfig-i073-20230529   gcc  
i386                 randconfig-i074-20230529   gcc  
i386                 randconfig-i075-20230529   gcc  
i386                 randconfig-i076-20230529   gcc  
i386                 randconfig-i081-20230529   gcc  
i386                 randconfig-i082-20230529   gcc  
i386                 randconfig-i083-20230529   gcc  
i386                 randconfig-i084-20230529   gcc  
i386                 randconfig-i085-20230529   gcc  
i386                 randconfig-i086-20230529   gcc  
i386                 randconfig-i091-20230529   clang
i386                 randconfig-i091-20230530   clang
i386                 randconfig-i092-20230529   clang
i386                 randconfig-i092-20230530   clang
i386                 randconfig-i093-20230529   clang
i386                 randconfig-i093-20230530   clang
i386                 randconfig-i094-20230529   clang
i386                 randconfig-i094-20230530   clang
i386                 randconfig-i095-20230529   clang
i386                 randconfig-i095-20230530   clang
i386                 randconfig-i096-20230529   clang
i386                 randconfig-i096-20230530   clang
i386                 randconfig-r004-20230529   clang
i386                 randconfig-r021-20230529   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r014-20230529   gcc  
loongarch            randconfig-r035-20230529   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230529   gcc  
microblaze           randconfig-r012-20230530   gcc  
microblaze           randconfig-r033-20230530   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r015-20230529   clang
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230529   gcc  
nios2                randconfig-r011-20230530   gcc  
nios2                randconfig-r036-20230529   gcc  
openrisc     buildonly-randconfig-r002-20230529   gcc  
openrisc     buildonly-randconfig-r003-20230529   gcc  
openrisc             randconfig-r036-20230530   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230529   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230529   clang
riscv                randconfig-r042-20230529   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r013-20230530   gcc  
s390                 randconfig-r014-20230530   gcc  
s390                 randconfig-r044-20230529   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230529   gcc  
sh                   randconfig-r025-20230529   gcc  
sh                   randconfig-r035-20230530   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230530   gcc  
sparc                randconfig-r032-20230529   gcc  
sparc64              randconfig-r032-20230530   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230530   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230530   clang
x86_64               randconfig-a002-20230530   clang
x86_64               randconfig-a003-20230530   clang
x86_64               randconfig-a004-20230530   clang
x86_64               randconfig-a005-20230530   clang
x86_64               randconfig-a006-20230530   clang
x86_64               randconfig-a011-20230529   gcc  
x86_64               randconfig-a011-20230530   gcc  
x86_64               randconfig-a012-20230529   gcc  
x86_64               randconfig-a012-20230530   gcc  
x86_64               randconfig-a013-20230529   gcc  
x86_64               randconfig-a013-20230530   gcc  
x86_64               randconfig-a014-20230529   gcc  
x86_64               randconfig-a014-20230530   gcc  
x86_64               randconfig-a015-20230529   gcc  
x86_64               randconfig-a015-20230530   gcc  
x86_64               randconfig-a016-20230529   gcc  
x86_64               randconfig-a016-20230530   gcc  
x86_64               randconfig-x051-20230529   gcc  
x86_64               randconfig-x052-20230529   gcc  
x86_64               randconfig-x053-20230529   gcc  
x86_64               randconfig-x054-20230529   gcc  
x86_64               randconfig-x055-20230529   gcc  
x86_64               randconfig-x056-20230529   gcc  
x86_64               randconfig-x061-20230529   gcc  
x86_64               randconfig-x061-20230530   gcc  
x86_64               randconfig-x062-20230529   gcc  
x86_64               randconfig-x062-20230530   gcc  
x86_64               randconfig-x063-20230529   gcc  
x86_64               randconfig-x063-20230530   gcc  
x86_64               randconfig-x064-20230529   gcc  
x86_64               randconfig-x064-20230530   gcc  
x86_64               randconfig-x065-20230529   gcc  
x86_64               randconfig-x065-20230530   gcc  
x86_64               randconfig-x066-20230529   gcc  
x86_64               randconfig-x066-20230530   gcc  
x86_64               randconfig-x071-20230529   clang
x86_64               randconfig-x072-20230529   clang
x86_64               randconfig-x073-20230529   clang
x86_64               randconfig-x074-20230529   clang
x86_64               randconfig-x075-20230529   clang
x86_64               randconfig-x076-20230529   clang
x86_64               randconfig-x081-20230529   clang
x86_64               randconfig-x082-20230529   clang
x86_64               randconfig-x083-20230529   clang
x86_64               randconfig-x084-20230529   clang
x86_64               randconfig-x085-20230529   clang
x86_64               randconfig-x086-20230529   clang
x86_64               randconfig-x091-20230529   gcc  
x86_64               randconfig-x092-20230529   gcc  
x86_64               randconfig-x093-20230529   gcc  
x86_64               randconfig-x094-20230529   gcc  
x86_64               randconfig-x095-20230529   gcc  
x86_64               randconfig-x096-20230529   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r011-20230529   gcc  
xtensa               randconfig-r013-20230529   gcc  
xtensa               randconfig-r022-20230529   gcc  
xtensa               randconfig-r033-20230529   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
