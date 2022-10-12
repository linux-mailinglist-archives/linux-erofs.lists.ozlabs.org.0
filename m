Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4315FCBA0
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Oct 2022 21:36:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MnjYr73vXz3c2L
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Oct 2022 06:36:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZNCAYi6b;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZNCAYi6b;
	dkim-atps=neutral
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MnjYm2ZNZz3bm9
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Oct 2022 06:35:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665603356; x=1697139356;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=iHG+5hQFP4mUfjUm8AXhijtxoMbwB2WX1ypmqEwXN8E=;
  b=ZNCAYi6b6Es7ZBH9kWepSrbDQekjbihgYCf/fakz7gBXqBlbUykFiCqL
   y7iLtdWu6R36xfS0HhE1HNd+vv+7dbzqIOX3D7Oie0lKBKGSJd0neMUhP
   8fOOvh0Td3z3zs1EnPbLtDcVz3cBor80HzLs52RH8awlomQYVUJYcgnP0
   wHUZAlOIv/6tthyZ0O74/UUAIJFeuKIfuk97hE9kX+jzDs1uuKxbP+SDN
   lSJ9Vl6lvU0fDm45NOJ+47q+N5viKJSBGPS88Y0zyHxIw8pK/43PPH/PR
   Iz92mi1N8+MXf9QZ0baI4tgd+A5hakBXzEhnA8Os5UQnlAefuNcBVrbnz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="292216732"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="292216732"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 12:35:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="695598785"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="695598785"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 12 Oct 2022 12:35:43 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oihW2-00047D-2e;
	Wed, 12 Oct 2022 19:35:42 +0000
Date: Thu, 13 Oct 2022 03:34:48 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 4d9849343ecae16cf236547f1493113fd52dc076
Message-ID: <634716d8.StD+tiBZC9ofMHCT%lkp@intel.com>
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
branch HEAD: 4d9849343ecae16cf236547f1493113fd52dc076  erofs: shouldn't churn the mapping page for duplicated copies

elapsed time: 720m

configs tested: 96
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
s390                 randconfig-r044-20221012
i386                          randconfig-a012
x86_64                              defconfig
i386                          randconfig-a014
i386                             allyesconfig
arc                                 defconfig
powerpc                           allnoconfig
x86_64                               rhel-8.3
s390                             allmodconfig
i386                          randconfig-a016
i386                          randconfig-a001
m68k                             allmodconfig
powerpc                          allmodconfig
x86_64                        randconfig-a015
sh                               allmodconfig
arm                                 defconfig
arc                              allyesconfig
alpha                               defconfig
i386                          randconfig-a003
x86_64                        randconfig-a002
i386                          randconfig-a005
x86_64                        randconfig-a006
s390                             allyesconfig
s390                                defconfig
mips                             allyesconfig
x86_64                           allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a004
m68k                             allyesconfig
arc                              alldefconfig
sh                            shmin_defconfig
sh                         apsh4a3a_defconfig
openrisc                            defconfig
arm                        keystone_defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc834x_mds_defconfig
mips                       bmips_be_defconfig
arc                  randconfig-r043-20221012
riscv                randconfig-r042-20221012
arc                               allnoconfig
arm64                            allyesconfig
arm                              allyesconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
xtensa                           allyesconfig
sh                           se7750_defconfig
powerpc                     rainier_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
powerpc                    amigaone_defconfig
mips                           ci20_defconfig
m68k                                defconfig
riscv                    nommu_k210_defconfig
i386                          randconfig-c001
ia64                             allmodconfig
sparc                               defconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
x86_64                        randconfig-a016
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a006
x86_64                        randconfig-a003
riscv                             allnoconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
powerpc                 mpc8560_ads_defconfig
mips                      maltaaprp_defconfig
x86_64                        randconfig-k001
powerpc                      obs600_defconfig
mips                           mtx1_defconfig
powerpc                      katmai_defconfig
mips                     cu1830-neo_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
