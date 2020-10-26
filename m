Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 396F52990F3
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Oct 2020 16:25:37 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CKdvL0thPzDqPC
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Oct 2020 02:25:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CKdvC469hzDqNt
 for <linux-erofs@lists.ozlabs.org>; Tue, 27 Oct 2020 02:25:21 +1100 (AEDT)
IronPort-SDR: cY0q95i2j/sNXs3P/REyBTM3PBfzP9OfFuztvpdfgfNUYbro8lGr6lPfvuVpYByQs+kWq1ANpy
 /0c5D1b56+dg==
X-IronPort-AV: E=McAfee;i="6000,8403,9785"; a="147224800"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; d="scan'208";a="147224800"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2020 08:25:17 -0700
IronPort-SDR: W2o421AhoZPS0lwB6tX8q9nLn7WxQyemX/HK4OPBBXhsNAtkPk7CgpszDiDFTa7QTR3CDGjCb+
 6vg/psH0V9wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; d="scan'208";a="535397365"
Received: from lkp-server01.sh.intel.com (HELO 394efc4116ff) ([10.239.97.150])
 by orsmga005.jf.intel.com with ESMTP; 26 Oct 2020 08:25:15 -0700
Received: from kbuild by 394efc4116ff with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kX4N1-0000Bv-9V; Mon, 26 Oct 2020 15:25:15 +0000
Date: Mon, 26 Oct 2020 23:24:41 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 6fec9eb0f0c15222b7a1fc4da238b7abf3b70208
Message-ID: <5f96ea39.hpuKrdNinT+70H8I%lkp@intel.com>
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
branch HEAD: 6fec9eb0f0c15222b7a1fc4da238b7abf3b70208  erofs: complete a missing case for inplace I/O

elapsed time: 722m

configs tested: 129
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7705_defconfig
arm                        spear6xx_defconfig
arm                              zx_defconfig
mips                          malta_defconfig
alpha                               defconfig
arm                         mv78xx0_defconfig
m68k                             alldefconfig
mips                         db1xxx_defconfig
arm                            mmp2_defconfig
powerpc                       ppc64_defconfig
powerpc                     ppa8548_defconfig
powerpc                  iss476-smp_defconfig
mips                         tb0287_defconfig
mips                        workpad_defconfig
ia64                                defconfig
m68k                         amcore_defconfig
arm                          badge4_defconfig
powerpc                     stx_gp3_defconfig
sh                           se7750_defconfig
powerpc                    mvme5100_defconfig
mips                         tb0226_defconfig
arm                  colibri_pxa270_defconfig
arm                       spear13xx_defconfig
c6x                        evmc6474_defconfig
arm                         axm55xx_defconfig
openrisc                         alldefconfig
powerpc               mpc834x_itxgp_defconfig
sh                ecovec24-romimage_defconfig
arm                            dove_defconfig
arm                         socfpga_defconfig
sh                        sh7763rdp_defconfig
arm                        mini2440_defconfig
arm                           spitz_defconfig
m68k                          multi_defconfig
arm                      jornada720_defconfig
powerpc                       maple_defconfig
openrisc                            defconfig
powerpc                      arches_defconfig
mips                        maltaup_defconfig
xtensa                           alldefconfig
powerpc                     kilauea_defconfig
arm                         cm_x300_defconfig
riscv                            alldefconfig
powerpc                     rainier_defconfig
powerpc                     pseries_defconfig
mips                       bmips_be_defconfig
powerpc                    sam440ep_defconfig
powerpc                  mpc866_ads_defconfig
sh                          kfr2r09_defconfig
s390                             alldefconfig
powerpc                        cell_defconfig
sh                        sh7785lcr_defconfig
powerpc                     sbc8548_defconfig
arm                         s3c2410_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          lpd270_defconfig
sh                   rts7751r2dplus_defconfig
ia64                             allmodconfig
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
csky                                defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20201026
i386                 randconfig-a003-20201026
i386                 randconfig-a005-20201026
i386                 randconfig-a001-20201026
i386                 randconfig-a006-20201026
i386                 randconfig-a004-20201026
x86_64               randconfig-a011-20201026
x86_64               randconfig-a013-20201026
x86_64               randconfig-a016-20201026
x86_64               randconfig-a015-20201026
x86_64               randconfig-a012-20201026
x86_64               randconfig-a014-20201026
i386                 randconfig-a016-20201026
i386                 randconfig-a015-20201026
i386                 randconfig-a014-20201026
i386                 randconfig-a012-20201026
i386                 randconfig-a013-20201026
i386                 randconfig-a011-20201026
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
x86_64               randconfig-a001-20201026
x86_64               randconfig-a003-20201026
x86_64               randconfig-a002-20201026
x86_64               randconfig-a006-20201026
x86_64               randconfig-a004-20201026
x86_64               randconfig-a005-20201026

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
