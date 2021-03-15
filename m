Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBBF33C6E4
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Mar 2021 20:35:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dzmpg4trFz300r
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Mar 2021 06:35:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dzmpc6DCzz2yxb
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Mar 2021 06:34:57 +1100 (AEDT)
IronPort-SDR: 9DoQBrhRESdizY5VS6ULnokKOgzuXyuEwO/cWfUgRykOk0I5+IVrlPrTJ7fCFT0aEUd5ZvKrs6
 ib6T4Aex/azw==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="274187319"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; d="scan'208";a="274187319"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2021 12:34:49 -0700
IronPort-SDR: DoA4l6ejX7Nmsk7GoXGVI5Mtmdns6YaDb8d4mktF8W277TKtXAGYjSkr1DipY9vN4FpFnDXEZi
 NWPN6Y6aqw9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; d="scan'208";a="410759231"
Received: from lkp-server02.sh.intel.com (HELO 1dc5e1a854f4) ([10.239.97.151])
 by orsmga007.jf.intel.com with ESMTP; 15 Mar 2021 12:34:47 -0700
Received: from kbuild by 1dc5e1a854f4 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lLszH-0000cH-2b; Mon, 15 Mar 2021 19:34:47 +0000
Date: Tue, 16 Mar 2021 03:33:49 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 7041fecd3512b53e628dc4d1ca1fc7734e9b95dc
Message-ID: <604fb69d.AeYbuPmqiNtpBRAz%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 7041fecd3512b53e628dc4d1ca1fc7734e9b95dc  erofs: decompress in endio if possible

elapsed time: 720m

configs tested: 122
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
sh                           se7750_defconfig
powerpc                      chrp32_defconfig
arc                         haps_hs_defconfig
mips                     loongson1c_defconfig
xtensa                    smp_lx200_defconfig
ia64                         bigsur_defconfig
sh                                  defconfig
sh                               alldefconfig
mips                           jazz_defconfig
powerpc                     taishan_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                      loongson3_defconfig
arc                      axs103_smp_defconfig
m68k                       m5208evb_defconfig
arm                           h3600_defconfig
arc                 nsimosci_hs_smp_defconfig
sparc                       sparc32_defconfig
mips                   sb1250_swarm_defconfig
arm                       mainstone_defconfig
nios2                            allyesconfig
arm                           omap1_defconfig
arm                           spitz_defconfig
powerpc                     tqm8541_defconfig
sh                          polaris_defconfig
sh                             espt_defconfig
arm                           stm32_defconfig
arm                         s5pv210_defconfig
arm                       aspeed_g4_defconfig
mips                        workpad_defconfig
powerpc                    amigaone_defconfig
mips                          rm200_defconfig
ia64                             allyesconfig
powerpc                      ppc44x_defconfig
sh                          rsk7269_defconfig
powerpc                      walnut_defconfig
powerpc                      cm5200_defconfig
m68k                            mac_defconfig
mips                           xway_defconfig
arc                    vdk_hs38_smp_defconfig
sparc64                          alldefconfig
alpha                               defconfig
sh                           se7780_defconfig
alpha                            alldefconfig
sh                        apsh4ad0a_defconfig
arm                         vf610m4_defconfig
sh                            hp6xx_defconfig
arm                       omap2plus_defconfig
sh                           se7724_defconfig
arm                          ep93xx_defconfig
powerpc                 mpc837x_rdb_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
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
x86_64               randconfig-a006-20210315
x86_64               randconfig-a001-20210315
x86_64               randconfig-a005-20210315
x86_64               randconfig-a004-20210315
x86_64               randconfig-a002-20210315
x86_64               randconfig-a003-20210315
i386                 randconfig-a001-20210315
i386                 randconfig-a005-20210315
i386                 randconfig-a003-20210315
i386                 randconfig-a002-20210315
i386                 randconfig-a004-20210315
i386                 randconfig-a006-20210315
i386                 randconfig-a013-20210315
i386                 randconfig-a016-20210315
i386                 randconfig-a011-20210315
i386                 randconfig-a012-20210315
i386                 randconfig-a014-20210315
i386                 randconfig-a015-20210315
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210315
x86_64               randconfig-a016-20210315
x86_64               randconfig-a013-20210315
x86_64               randconfig-a015-20210315
x86_64               randconfig-a014-20210315
x86_64               randconfig-a012-20210315

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
