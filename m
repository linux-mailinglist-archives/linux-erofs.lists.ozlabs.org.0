Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA6D644AF1
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 19:15:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NRT9V0D94z3bY2
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Dec 2022 05:15:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Glhn4S7k;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Glhn4S7k;
	dkim-atps=neutral
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NRT9M33yXz2xCd
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Dec 2022 05:15:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670350519; x=1701886519;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Txv57RsjxJeqkbVA46tc8o60kKL9+hc7RhF/XsdWLE4=;
  b=Glhn4S7kW4tFco7DRI2xBw5BVOlKh/2TE5sMQ5RkVaGrKu3Mr1XZckwG
   iEfBzD0B33qj5Gkei1Q+pjwAZEJfOQYKUPJ3jiY2BNS4i8Q+l5FGc3FnI
   H2yMaWbgeMhy6fCTf5j0GOP/zVG1nqmeGPuXpunynq+wqUcV9nJHb29e6
   PJ1sApD2AyUS5XT+ymvQ74SDP9+jDnPVpfXU9wNdnZuoxUGStlRoTC9Qr
   v2Y2Pw73AgbPW+f2s0jtUgUezRYIBu8L7j/x1s3YMnENbDsokeImyweY0
   o4do/rdp/Lf/cMLalTvP2G6HwhPLdyQZwOTy/nsySUTY3LZto/kERU0Yx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="378857675"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="378857675"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 10:15:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="646310177"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="646310177"
Received: from lkp-server01.sh.intel.com (HELO b3c45e08cbc1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Dec 2022 10:15:12 -0800
Received: from kbuild by b3c45e08cbc1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1p2cTI-000184-0U;
	Tue, 06 Dec 2022 18:15:12 +0000
Date: Wed, 07 Dec 2022 02:15:06 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 5ae69d4384a62a18b372b3b1c587d65b35c26801
Message-ID: <638f86aa.yM2gbOBxpwAqew43%lkp@intel.com>
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
branch HEAD: 5ae69d4384a62a18b372b3b1c587d65b35c26801  erofs: validate the extent length for uncompressed pclusters

elapsed time: 722m

configs tested: 104
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                               allnoconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
arc                                 defconfig
s390                             allmodconfig
m68k                             allyesconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                            allyesconfig
s390                                defconfig
arc                              allyesconfig
i386                                defconfig
sh                               allmodconfig
m68k                             allmodconfig
s390                             allyesconfig
x86_64               randconfig-a015-20221205
powerpc                          allmodconfig
mips                             allyesconfig
x86_64               randconfig-a016-20221205
powerpc                           allnoconfig
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a013-20221205
x86_64               randconfig-a011-20221205
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a014-20221205
x86_64                          rhel-8.3-func
x86_64               randconfig-a012-20221205
ia64                             allmodconfig
i386                 randconfig-a016-20221205
i386                 randconfig-a012-20221205
x86_64                           allyesconfig
i386                 randconfig-a011-20221205
i386                 randconfig-a014-20221205
i386                 randconfig-a013-20221205
i386                 randconfig-a015-20221205
i386                             allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
arc                  randconfig-r043-20221205
s390                 randconfig-r044-20221205
arm                  randconfig-r046-20221204
arc                  randconfig-r043-20221204
riscv                randconfig-r042-20221205
x86_64                          rhel-8.3-rust
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                            allnoconfig
sparc                               defconfig
mips                           ip32_defconfig
arm                            zeus_defconfig
xtensa                       common_defconfig
i386                          randconfig-c001
powerpc                   motionpro_defconfig
mips                         rt305x_defconfig
mips                          rb532_defconfig
arm                          lpd270_defconfig
arm                            qcom_defconfig
riscv                             allnoconfig
mips                           ci20_defconfig
m68k                          amiga_defconfig
sh                          sdk7780_defconfig
arc                  randconfig-r043-20221206
arm                  randconfig-r046-20221206

clang tested configs:
x86_64               randconfig-a001-20221205
x86_64               randconfig-a002-20221205
x86_64               randconfig-a004-20221205
x86_64               randconfig-a003-20221205
x86_64               randconfig-a006-20221205
x86_64               randconfig-a005-20221205
i386                 randconfig-a001-20221205
i386                 randconfig-a002-20221205
i386                 randconfig-a005-20221205
i386                 randconfig-a004-20221205
i386                 randconfig-a003-20221205
i386                 randconfig-a006-20221205
hexagon              randconfig-r041-20221205
hexagon              randconfig-r041-20221204
arm                  randconfig-r046-20221205
hexagon              randconfig-r045-20221205
hexagon              randconfig-r045-20221204
riscv                randconfig-r042-20221204
s390                 randconfig-r044-20221204
hexagon              randconfig-r041-20221206
riscv                randconfig-r042-20221206
hexagon              randconfig-r045-20221206
s390                 randconfig-r044-20221206
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
riscv                             allnoconfig
arm                         orion5x_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
