Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A3668AE31
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Feb 2023 05:06:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P8bRj3HYVz3f40
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Feb 2023 15:06:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dM/0oqHb;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dM/0oqHb;
	dkim-atps=neutral
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P8bRc53Pzz3cKB
	for <linux-erofs@lists.ozlabs.org>; Sun,  5 Feb 2023 15:06:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675569980; x=1707105980;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=CYvnUzU9pikLzMRKKidvyRRQwde5i56wcdLf3YKye+M=;
  b=dM/0oqHbmuYOjmTZt9rZQRAW1EI0PZBFjCiRkEoyXM1cr1iDpJ8+YHMU
   BbLeO97LNh8TqTf4+ikvKh4GRTVG4JDV8JtTLR/t9ADHY/nG2Soyp3X0Q
   i4JKP7SZzFlsd4RyLU5PZX0EA0ZqkRNEvhQQwtbqLJVeNxjFI7JyQ+K1/
   USCOnzGOb86E17OyPiAWEqlPiEwKu86EeX7JSGaOX+BQihMf/iosvNrk5
   CA/+J8Iz+d8k4W+1Rd58eYfbceebYTWwSAUntV/X8jnw1rvgWBfQxC2cT
   jBbMIz8wExTL26WTJoLSoY64I6O+HYX8cPnS0cufECdSrqI9UtTgj0bEM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="331149358"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="331149358"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 20:06:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="840018352"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="840018352"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 Feb 2023 20:06:08 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pOWI3-0001jC-0w;
	Sun, 05 Feb 2023 04:06:07 +0000
Date: Sun, 05 Feb 2023 12:05:38 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 55262d32779907c171eb0e590e5558626f842011
Message-ID: <63df2b12.FnBPje0hMc5nPPnO%lkp@intel.com>
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
branch HEAD: 55262d32779907c171eb0e590e5558626f842011  erofs: tidy up internal.h

elapsed time: 1073m

configs tested: 77
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
um                             i386_defconfig
x86_64                              defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
x86_64                           rhel-8.3-bpf
x86_64                               rhel-8.3
alpha                               defconfig
i386                              allnoconfig
x86_64                           rhel-8.3-syz
arm                               allnoconfig
s390                                defconfig
x86_64                         rhel-8.3-kunit
arc                               allnoconfig
s390                             allyesconfig
alpha                             allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                        randconfig-a004
arc                              allyesconfig
x86_64                        randconfig-a002
alpha                            allyesconfig
x86_64                        randconfig-a006
ia64                             allmodconfig
s390                 randconfig-r044-20230204
riscv                randconfig-r042-20230204
arc                  randconfig-r043-20230204
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                        cell_defconfig
powerpc                      pasemi_defconfig
sh                                  defconfig
sh                            migor_defconfig
sh                           se7619_defconfig

clang tested configs:
x86_64                        randconfig-a001
hexagon              randconfig-r041-20230204
x86_64                        randconfig-a003
x86_64                        randconfig-a005
arm                  randconfig-r046-20230204
hexagon              randconfig-r045-20230204
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                          rhel-8.3-rust
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
riscv                randconfig-r042-20230205
s390                 randconfig-r044-20230205
hexagon              randconfig-r045-20230205
hexagon              randconfig-r041-20230205
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
