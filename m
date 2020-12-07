Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EDF2D1720
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Dec 2020 18:09:34 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CqVCv4DZvzDqTg
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 04:09:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CqVCn6F92zDqSF
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 04:09:21 +1100 (AEDT)
IronPort-SDR: j2rptMnbSwpvCKkcgIUcH5IriPT1D27BnpHg7tmYphvwk3S0K6a/bzUnDdll8FZuYz33f6J2V6
 cBdpD2EYLWrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="170226814"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; d="scan'208";a="170226814"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2020 09:09:18 -0800
IronPort-SDR: tqh3T7HT9Wu/3NjJa6/6akwHXnsT/CeNKh28uWcIsQZR0qwNgOPzlQyZODl14qwuO93kT08qad
 DzjPe+uLALHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; d="scan'208";a="541564206"
Received: from lkp-server01.sh.intel.com (HELO f1d34cfde454) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 07 Dec 2020 09:09:16 -0800
Received: from kbuild by f1d34cfde454 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kmK0h-00008R-QU; Mon, 07 Dec 2020 17:09:15 +0000
Date: Tue, 08 Dec 2020 01:08:58 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 789409aeab9842d3fbc05c4351297863346d0082
Message-ID: <5fce61aa.aFHO7tBW8MveZIJX%lkp@intel.com>
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
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git  dev-test
branch HEAD: 789409aeab9842d3fbc05c4351297863346d0082  erofs: simplify try_to_claim_pcluster()

elapsed time: 724m

configs tested: 113
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         shannon_defconfig
arc                         haps_hs_defconfig
sh                               j2_defconfig
mips                         cobalt_defconfig
s390                       zfcpdump_defconfig
arm                          prima2_defconfig
sh                   secureedge5410_defconfig
arm                       netwinder_defconfig
powerpc                        warp_defconfig
um                            kunit_defconfig
arc                      axs103_smp_defconfig
powerpc                      walnut_defconfig
sh                             sh03_defconfig
powerpc                     asp8347_defconfig
arm                         s3c6400_defconfig
powerpc                     tqm8555_defconfig
arm                          ixp4xx_defconfig
sh                           se7780_defconfig
powerpc                     powernv_defconfig
sh                          r7780mp_defconfig
powerpc                      ppc64e_defconfig
arm                          iop32x_defconfig
mips                         tb0226_defconfig
powerpc                     stx_gp3_defconfig
mips                         rt305x_defconfig
nios2                         3c120_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                    klondike_defconfig
sparc64                          alldefconfig
arm                         mv78xx0_defconfig
powerpc                         ps3_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                 mpc832x_rdb_defconfig
csky                                defconfig
powerpc                 mpc837x_rdb_defconfig
sh                          landisk_defconfig
arm64                            alldefconfig
arm                            u300_defconfig
microblaze                      mmu_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201207
i386                 randconfig-a004-20201207
i386                 randconfig-a001-20201207
i386                 randconfig-a002-20201207
i386                 randconfig-a006-20201207
i386                 randconfig-a003-20201207
x86_64               randconfig-a016-20201207
x86_64               randconfig-a012-20201207
x86_64               randconfig-a014-20201207
x86_64               randconfig-a013-20201207
x86_64               randconfig-a015-20201207
x86_64               randconfig-a011-20201207
i386                 randconfig-a014-20201207
i386                 randconfig-a013-20201207
i386                 randconfig-a011-20201207
i386                 randconfig-a015-20201207
i386                 randconfig-a012-20201207
i386                 randconfig-a016-20201207
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201207
x86_64               randconfig-a006-20201207
x86_64               randconfig-a002-20201207
x86_64               randconfig-a001-20201207
x86_64               randconfig-a005-20201207
x86_64               randconfig-a003-20201207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
