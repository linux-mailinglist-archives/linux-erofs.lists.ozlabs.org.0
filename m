Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB324D66EF
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 17:58:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFXFg4cZpz30CP
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Mar 2022 03:58:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AGi/m/V/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=AGi/m/V/; dkim-atps=neutral
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFXFZ5Ck5z2ypn
 for <linux-erofs@lists.ozlabs.org>; Sat, 12 Mar 2022 03:58:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647017922; x=1678553922;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=GNHeZhyngmoH5Yq6fZTqJELTc2rjhL4QPoGD5q2RmLw=;
 b=AGi/m/V/XwBX4Yk0aHPi3kIo0p0MkHOD+qzxta5c/XZAPk1rCuva6y0D
 Ir402eu8KvlQtNbDArur52lAZiAXAEV/Ggk5w1oIw9VVhvBzQRnGowMkk
 Xtnmz2kZVErXduSlS3yIebRj/IEZa9NhwGOu5hVHqc+cMx6/ytCCc9dUY
 eqF/+CV+Hl4/MDJbAhlaqXya2ll1/pN2d2y3mE8ZUXqVc96z3fwbNrqCO
 KKorWRYsqOZI90TN0oDWBu6oFjtKfguxQHiw+DXvIDuahB5NwgPcZiSLB
 hMAD7mPj+v73nstE26uCTRJ4tl1J0gUmeJY7lTXQOyjHpBHVPgOYkJ73t A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="318829772"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; d="scan'208";a="318829772"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2022 08:57:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; d="scan'208";a="712900147"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by orsmga005.jf.intel.com with ESMTP; 11 Mar 2022 08:57:37 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nSia8-0006n4-BC; Fri, 11 Mar 2022 16:57:36 +0000
Date: Sat, 12 Mar 2022 00:57:29 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 ab6bfa6e1e2222ad3de93035614b48d5a41509c6
Message-ID: <622b7f79.xEbhNbIejBcbeQb+%lkp@intel.com>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: ab6bfa6e1e2222ad3de93035614b48d5a41509c6  erofs: refine managed inode stuffs

elapsed time: 1309m

configs tested: 142
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
nios2                         3c120_defconfig
sparc                            allyesconfig
arm                            lart_defconfig
sh                            titan_defconfig
sh                            shmin_defconfig
m68k                          multi_defconfig
xtensa                         virt_defconfig
sh                          rsk7203_defconfig
m68k                       m5208evb_defconfig
nds32                            alldefconfig
arc                          axs101_defconfig
mips                       bmips_be_defconfig
powerpc                           allnoconfig
arm                          badge4_defconfig
sh                           se7721_defconfig
arm                      jornada720_defconfig
openrisc                  or1klitex_defconfig
arm                             rpc_defconfig
sh                          sdk7780_defconfig
h8300                     edosk2674_defconfig
sparc                       sparc64_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7722_defconfig
nds32                             allnoconfig
arm                        realview_defconfig
sh                           se7206_defconfig
sh                               allmodconfig
arc                          axs103_defconfig
mips                       capcella_defconfig
arm                         vf610m4_defconfig
arm                          lpd270_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                         db1xxx_defconfig
arm                          pxa3xx_defconfig
openrisc                         alldefconfig
powerpc                       holly_defconfig
powerpc                 mpc837x_mds_defconfig
arm                         s3c6400_defconfig
ia64                                defconfig
arm                        keystone_defconfig
h8300                    h8300h-sim_defconfig
powerpc                     tqm8548_defconfig
arm                  randconfig-c002-20220310
arm                  randconfig-c002-20220311
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                              debian-10.3
i386                             allyesconfig
i386                   debian-10.3-kselftests
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a005
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a013
i386                          randconfig-a016
i386                          randconfig-a014
i386                          randconfig-a012
arc                  randconfig-r043-20220310
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                  randconfig-c002-20220310
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220310
riscv                randconfig-c006-20220310
mips                 randconfig-c004-20220310
i386                          randconfig-c001
powerpc                     tqm8540_defconfig
mips                       lemote2f_defconfig
mips                     loongson2k_defconfig
powerpc                      acadia_defconfig
arm                       spear13xx_defconfig
x86_64                           allyesconfig
powerpc                      pmac32_defconfig
mips                           rs90_defconfig
powerpc                     mpc512x_defconfig
arm                    vt8500_v6_v7_defconfig
hexagon                          alldefconfig
arm                         orion5x_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc8313_rdb_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a005
hexagon              randconfig-r041-20220310
hexagon              randconfig-r045-20220310
s390                 randconfig-r044-20220310
riscv                randconfig-r042-20220310

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
