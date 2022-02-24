Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7864C27A6
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Feb 2022 10:10:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K46ZC4JjCz3fst
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Feb 2022 20:10:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Khmysu4D;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Khmysu4D; dkim-atps=neutral
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K46NB5DJhz3dfX
 for <linux-erofs@lists.ozlabs.org>; Thu, 24 Feb 2022 20:01:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645693307; x=1677229307;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=erBXP8dBP1eHG8FjSSRbJE/26UW6UiYBb3VGlNH/MgI=;
 b=Khmysu4DfpJBg0E5bio/sq/211AUFeYC7IOQwpmt0ckep9nTpyFYeGwt
 n0FIt/jwx+8+PPTjeHZTVQZHWGbEd6prgJ3kPnl+5oaT1OZ23DFraRUqT
 NWD8qTSObmAMNTnTHEods5YQF/n7S2thNkrfFfyE+QFuaB81Pw7cYU6Eo
 oXc19ff8lC26H3PA4xgVJooJHofJeHuSimDfSurx0ZDOdtqJ1nd5kWgDj
 Rl7vMyQdXFgppvWlFD2fU3rS3jnfkYnKeCssZBEE67k4plgsR8SqH9Kq1
 zp0Wbx6+IU8wbcRbzLC8cFYMdGykY6w4UxXcz2LpFxIVNSAvBmABETGKf w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="235651446"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; d="scan'208";a="235651446"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2022 19:47:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; d="scan'208";a="684138823"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
 by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2022 19:47:01 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nN55o-0002Dk-Tm; Thu, 24 Feb 2022 03:47:00 +0000
Date: Thu, 24 Feb 2022 11:46:07 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 c678fc27e5aec2eb9e56749e4671fdda9dd9559d
Message-ID: <6216ff7f.iCSfxWzGGlosdtTA%lkp@intel.com>
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
branch HEAD: c678fc27e5aec2eb9e56749e4671fdda9dd9559d  erofs: fix ztailpacking on > 4GiB filesystems

elapsed time: 724m

configs tested: 139
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
i386                          randconfig-c001
powerpc                 mpc8540_ads_defconfig
arm                          lpd270_defconfig
mips                            gpr_defconfig
h8300                    h8300h-sim_defconfig
s390                          debug_defconfig
m68k                       bvme6000_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                          polaris_defconfig
openrisc                    or1ksim_defconfig
powerpc                    klondike_defconfig
arm                             ezx_defconfig
arc                        nsimosci_defconfig
arc                        nsim_700_defconfig
powerpc                     pq2fads_defconfig
sh                          rsk7269_defconfig
mips                           jazz_defconfig
arm                            qcom_defconfig
arm                           stm32_defconfig
sh                                  defconfig
mips                           gcw0_defconfig
arm                         s3c6400_defconfig
sh                           sh2007_defconfig
nios2                         10m50_defconfig
sh                            titan_defconfig
powerpc                     redwood_defconfig
sh                     magicpanelr2_defconfig
powerpc                      pasemi_defconfig
arm                        clps711x_defconfig
sh                           se7751_defconfig
arm                           tegra_defconfig
ia64                             alldefconfig
nds32                               defconfig
powerpc                 linkstation_defconfig
sh                   sh7770_generic_defconfig
arm                  randconfig-c002-20220223
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
i386                              debian-10.3
i386                             allyesconfig
i386                   debian-10.3-kselftests
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a016
i386                          randconfig-a012
i386                          randconfig-a014
arc                  randconfig-r043-20220223
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func

clang tested configs:
powerpc              randconfig-c003-20220223
x86_64                        randconfig-c007
arm                  randconfig-c002-20220223
mips                 randconfig-c004-20220223
i386                          randconfig-c001
riscv                randconfig-c006-20220223
arm                           omap1_defconfig
powerpc                      walnut_defconfig
powerpc                     pseries_defconfig
mips                        workpad_defconfig
powerpc                      obs600_defconfig
powerpc                     ppa8548_defconfig
arm                          imote2_defconfig
arm                           spitz_defconfig
arm                         bcm2835_defconfig
powerpc                      ppc44x_defconfig
mips                           ip28_defconfig
mips                           mtx1_defconfig
arm                    vt8500_v6_v7_defconfig
arm                        magician_defconfig
powerpc                      ppc64e_defconfig
mips                        maltaup_defconfig
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r045-20220223
hexagon              randconfig-r041-20220223
riscv                randconfig-r042-20220223
s390                 randconfig-r044-20220223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
