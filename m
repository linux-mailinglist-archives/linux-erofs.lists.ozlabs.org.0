Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645A938D5E9
	for <lists+linux-erofs@lfdr.de>; Sat, 22 May 2021 15:09:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FnP2D67N7z2yxX
	for <lists+linux-erofs@lfdr.de>; Sat, 22 May 2021 23:09:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FnP276S7Xz2yYJ
 for <linux-erofs@lists.ozlabs.org>; Sat, 22 May 2021 23:09:12 +1000 (AEST)
IronPort-SDR: xL4+YDTlmnQUZhtOdw0AhBwfX/EvMxtjccxQtLPuqyOBFxQgclC5nnzpM+YqGRCB6sHGXTeJq3
 HDkChToIgIvw==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="181960037"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; d="scan'208";a="181960037"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2021 06:09:08 -0700
IronPort-SDR: LGs2WjlRoHquOgFWr+356OKZ4yViGosVZh6nbYA4Wy4d+UnQH7J7YDPJU3L5Rwpu0Nf6FlNKuS
 aWWzTYHbLIkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; d="scan'208";a="412952123"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
 by orsmga002.jf.intel.com with ESMTP; 22 May 2021 06:09:07 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lkRNL-0000DI-0k; Sat, 22 May 2021 13:09:07 +0000
Date: Sat, 22 May 2021 21:08:40 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <xiang@kernel.org>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 c439c3306fea10eead49d0c628823c1ac95a39c2
Message-ID: <60a90258.u91VdAKW4ANBoND0%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: c439c3306fea10eead49d0c628823c1ac95a39c2  erofs: remove the occupied parameter from z_erofs_pagevec_enqueue()

elapsed time: 2044m

configs tested: 98
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            mmp2_defconfig
powerpc                        warp_defconfig
powerpc                     skiroot_defconfig
arm                            mps2_defconfig
powerpc                 mpc836x_mds_defconfig
sh                           se7705_defconfig
powerpc                     tqm5200_defconfig
arm                             mxs_defconfig
arm                        mvebu_v5_defconfig
parisc                           allyesconfig
arm                        spear6xx_defconfig
mips                      pic32mzda_defconfig
arm                           stm32_defconfig
m68k                          sun3x_defconfig
sparc                       sparc64_defconfig
powerpc                       maple_defconfig
arc                        vdk_hs38_defconfig
parisc                generic-64bit_defconfig
arm                           viper_defconfig
s390                                defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210521
i386                 randconfig-a005-20210521
i386                 randconfig-a002-20210521
i386                 randconfig-a006-20210521
i386                 randconfig-a003-20210521
i386                 randconfig-a004-20210521
x86_64               randconfig-a013-20210521
x86_64               randconfig-a014-20210521
x86_64               randconfig-a012-20210521
x86_64               randconfig-a016-20210521
x86_64               randconfig-a015-20210521
x86_64               randconfig-a011-20210521
i386                 randconfig-a016-20210521
i386                 randconfig-a011-20210521
i386                 randconfig-a015-20210521
i386                 randconfig-a012-20210521
i386                 randconfig-a014-20210521
i386                 randconfig-a013-20210521
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210521
x86_64               randconfig-a006-20210521
x86_64               randconfig-a001-20210521
x86_64               randconfig-a005-20210521
x86_64               randconfig-a003-20210521
x86_64               randconfig-a004-20210521
x86_64               randconfig-a002-20210521

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
