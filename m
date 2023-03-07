Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CDC6AF18B
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Mar 2023 19:45:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PWPXC11nsz3cfj
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Mar 2023 05:45:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ThOhA4e9;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ThOhA4e9;
	dkim-atps=neutral
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PWPX61jldz3cMN
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 Mar 2023 05:45:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678214726; x=1709750726;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ciZ8x5KNRKzEY+1ptXOUBPEmrm6CEK3KXuCXGQeJUfY=;
  b=ThOhA4e9yeuUAUbJuSDKQsMbpgw8T+cW6TcMEuXvTSPJVQMJvuBOeMAv
   sQ5xpfOcMqYY8t+EGHr1RmZDsggiIcZOrh2ctDzsmcfeYEVI7G/MBR+kO
   KqKrpFv+2biGpFVXt8WK4OucpPCJ2I4ldIazZacKJYTXOcyE9MUldqcZD
   U4VIsBfwBKC74f/QVB1wcospMv8+KTtuAo0L0TYNS5TWTD65+8A73LSao
   smZFBLNejKB3QAeT1h0JzOcubd07PwY3YjvXnriFczwAfG015oBAvdVo9
   C3wiJ3OjEy5aUS5VNGlvJXQujQJ8JPIASz9CLwFwvvYLPEQED8DgkXwVo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="334653053"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="334653053"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 10:45:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="819863643"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="819863643"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2023 10:45:16 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pZcJH-0001Wq-27;
	Tue, 07 Mar 2023 18:45:15 +0000
Date: Wed, 08 Mar 2023 02:44:21 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 cbae96d053b29235b8debcba74855a66cd7d9248
Message-ID: <64078605.9JmQeCQTOzHKtCwE%lkp@intel.com>
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
branch HEAD: cbae96d053b29235b8debcba74855a66cd7d9248  erofs: set block size to the on-disk block size

elapsed time: 732m

configs tested: 172
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230305   gcc  
alpha                randconfig-r003-20230306   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230305   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r016-20230306   gcc  
arc                  randconfig-r043-20230305   gcc  
arc                  randconfig-r043-20230306   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r005-20230306   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230306   clang
arm                  randconfig-r021-20230306   gcc  
arm                  randconfig-r046-20230305   clang
arm                  randconfig-r046-20230306   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230306   gcc  
arm64        buildonly-randconfig-r004-20230306   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r024-20230305   gcc  
arm64                randconfig-r026-20230306   clang
arm64                randconfig-r036-20230305   clang
csky         buildonly-randconfig-r001-20230305   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230305   gcc  
csky                 randconfig-r013-20230306   gcc  
csky                 randconfig-r015-20230306   gcc  
csky                 randconfig-r025-20230306   gcc  
hexagon              randconfig-r013-20230305   clang
hexagon              randconfig-r015-20230305   clang
hexagon              randconfig-r022-20230306   clang
hexagon              randconfig-r023-20230306   clang
hexagon              randconfig-r032-20230305   clang
hexagon              randconfig-r033-20230306   clang
hexagon              randconfig-r041-20230305   clang
hexagon              randconfig-r041-20230306   clang
hexagon              randconfig-r045-20230305   clang
hexagon              randconfig-r045-20230306   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r001-20230306   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230306   gcc  
i386                 randconfig-a002-20230306   gcc  
i386                 randconfig-a003-20230306   gcc  
i386                 randconfig-a004-20230306   gcc  
i386                 randconfig-a005-20230306   gcc  
i386                 randconfig-a006-20230306   gcc  
i386                 randconfig-a011-20230306   clang
i386                 randconfig-a012-20230306   clang
i386                 randconfig-a013-20230306   clang
i386                 randconfig-a014-20230306   clang
i386                 randconfig-a015-20230306   clang
i386                 randconfig-a016-20230306   clang
i386                 randconfig-r001-20230306   gcc  
i386                 randconfig-r002-20230306   gcc  
i386                 randconfig-r012-20230306   clang
i386                 randconfig-r032-20230306   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r011-20230305   gcc  
ia64                 randconfig-r024-20230305   gcc  
ia64                 randconfig-r031-20230305   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230306   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230305   gcc  
loongarch            randconfig-r004-20230306   gcc  
loongarch            randconfig-r021-20230305   gcc  
loongarch            randconfig-r031-20230307   gcc  
loongarch            randconfig-r034-20230307   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230306   gcc  
m68k                 randconfig-r011-20230306   gcc  
m68k                 randconfig-r022-20230306   gcc  
microblaze   buildonly-randconfig-r001-20230306   gcc  
microblaze           randconfig-r022-20230305   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r025-20230305   clang
mips                 randconfig-r036-20230306   clang
nios2                               defconfig   gcc  
nios2                randconfig-r013-20230305   gcc  
openrisc     buildonly-randconfig-r002-20230306   gcc  
openrisc             randconfig-r005-20230306   gcc  
openrisc             randconfig-r011-20230305   gcc  
openrisc             randconfig-r014-20230305   gcc  
openrisc             randconfig-r033-20230305   gcc  
openrisc             randconfig-r036-20230307   gcc  
parisc       buildonly-randconfig-r002-20230305   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r016-20230305   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r015-20230306   clang
powerpc              randconfig-r023-20230305   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230305   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230306   gcc  
riscv                randconfig-r024-20230306   clang
riscv                randconfig-r025-20230306   clang
riscv                randconfig-r042-20230305   gcc  
riscv                randconfig-r042-20230306   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230306   clang
s390         buildonly-randconfig-r006-20230305   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r014-20230305   gcc  
s390                 randconfig-r023-20230305   gcc  
s390                 randconfig-r044-20230305   gcc  
s390                 randconfig-r044-20230306   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230305   gcc  
sh                   randconfig-r026-20230305   gcc  
sparc        buildonly-randconfig-r006-20230305   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230305   gcc  
sparc                randconfig-r004-20230306   gcc  
sparc                randconfig-r005-20230306   gcc  
sparc                randconfig-r013-20230306   gcc  
sparc                randconfig-r016-20230306   gcc  
sparc                randconfig-r031-20230306   gcc  
sparc                randconfig-r032-20230307   gcc  
sparc64      buildonly-randconfig-r003-20230305   gcc  
sparc64              randconfig-r006-20230306   gcc  
sparc64              randconfig-r021-20230305   gcc  
sparc64              randconfig-r022-20230305   gcc  
sparc64              randconfig-r026-20230305   gcc  
sparc64              randconfig-r034-20230305   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r006-20230306   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230306   gcc  
x86_64               randconfig-a002-20230306   gcc  
x86_64               randconfig-a003-20230306   gcc  
x86_64               randconfig-a004-20230306   gcc  
x86_64               randconfig-a005-20230306   gcc  
x86_64               randconfig-a006-20230306   gcc  
x86_64               randconfig-a011-20230306   clang
x86_64               randconfig-a012-20230306   clang
x86_64               randconfig-a013-20230306   clang
x86_64               randconfig-a014-20230306   clang
x86_64               randconfig-a015-20230306   clang
x86_64               randconfig-a016-20230306   clang
x86_64               randconfig-r035-20230306   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230305   gcc  
xtensa       buildonly-randconfig-r005-20230305   gcc  
xtensa               randconfig-r012-20230305   gcc  
xtensa               randconfig-r014-20230306   gcc  
xtensa               randconfig-r015-20230305   gcc  
xtensa               randconfig-r023-20230306   gcc  
xtensa               randconfig-r024-20230306   gcc  
xtensa               randconfig-r035-20230307   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
