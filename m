Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 930072D5001
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Dec 2020 02:02:36 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Crwcn2h9XzDqRw
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Dec 2020 12:02:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Crwch1YkBzDq8t
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Dec 2020 12:02:27 +1100 (AEDT)
IronPort-SDR: LyecPqif8f7Z/IvdF09pWqkiqI/qDXFK5dXBrzNp0Z0BvGhH5FB7fi+zvqffJLZKWDJU0QCMqM
 I25kmyYsVkOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="238280960"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; d="scan'208";a="238280960"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2020 17:02:25 -0800
IronPort-SDR: iLxTXV+anUKJ1rXzTAXxeluQm4Cd59ccEGLCs+WmD4ihsrBsjWDmCoQdmab9tiIC+FNAGdYfjt
 IYAXfmpFoaHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; d="scan'208";a="318967943"
Received: from lkp-server01.sh.intel.com (HELO 2bbb63443648) ([10.239.97.150])
 by fmsmga007.fm.intel.com with ESMTP; 09 Dec 2020 17:02:23 -0800
Received: from kbuild by 2bbb63443648 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1knALe-0000YT-RN; Thu, 10 Dec 2020 01:02:22 +0000
Date: Thu, 10 Dec 2020 09:02:11 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 1825c8d7ce93c4725cb04ad09627fc2829de32ca
Message-ID: <5fd17393.V/4kca/yGWYzTitm%lkp@intel.com>
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
branch HEAD: 1825c8d7ce93c4725cb04ad09627fc2829de32ca  erofs: force inplace I/O under low memory scenario

elapsed time: 724m

configs tested: 124
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                        mvme16x_defconfig
mips                        omega2p_defconfig
ia64                        generic_defconfig
um                             i386_defconfig
mips                           gcw0_defconfig
sh                          kfr2r09_defconfig
sh                           se7724_defconfig
arm                    vt8500_v6_v7_defconfig
sh                        edosk7760_defconfig
arm                       imx_v6_v7_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                         tb0219_defconfig
mips                  maltasmvp_eva_defconfig
mips                     cu1000-neo_defconfig
powerpc                     rainier_defconfig
arm                           viper_defconfig
m68k                         apollo_defconfig
arm                          pcm027_defconfig
mips                          ath25_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        oxnas_v6_defconfig
s390                                defconfig
sh                                  defconfig
arc                 nsimosci_hs_smp_defconfig
arm                            mmp2_defconfig
alpha                            allyesconfig
mips                      pistachio_defconfig
sh                           se7751_defconfig
powerpc                       holly_defconfig
arm                           h5000_defconfig
sh                            migor_defconfig
mips                        bcm63xx_defconfig
powerpc                     tqm8541_defconfig
m68k                             alldefconfig
arm                          ep93xx_defconfig
arm                        cerfcube_defconfig
arm                       multi_v4t_defconfig
mips                         bigsur_defconfig
arm                        vexpress_defconfig
arm                          pxa168_defconfig
riscv                    nommu_k210_defconfig
powerpc                 mpc8540_ads_defconfig
arm                           tegra_defconfig
sh                             shx3_defconfig
powerpc                      pmac32_defconfig
mips                          ath79_defconfig
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
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
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
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
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
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209
x86_64               randconfig-a003-20201210
x86_64               randconfig-a006-20201210
x86_64               randconfig-a002-20201210
x86_64               randconfig-a005-20201210
x86_64               randconfig-a004-20201210
x86_64               randconfig-a001-20201210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
