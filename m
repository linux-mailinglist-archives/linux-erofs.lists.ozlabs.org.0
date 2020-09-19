Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B428270FCC
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Sep 2020 19:29:57 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BtyPt6CldzDr0X
	for <lists+linux-erofs@lfdr.de>; Sun, 20 Sep 2020 03:29:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BtyN75SdBzDqty
 for <linux-erofs@lists.ozlabs.org>; Sun, 20 Sep 2020 03:28:21 +1000 (AEST)
IronPort-SDR: 6nnpJXLZHlz5bW+onxMnjVF+Q1wHOt9w6d6I7LJ6zUg+HTV0fRHAk3zS7wNSSVCTOOzajTAgRH
 Wez6mwaUImWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9749"; a="157541401"
X-IronPort-AV: E=Sophos;i="5.77,279,1596524400"; d="scan'208";a="157541401"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2020 10:28:19 -0700
IronPort-SDR: sArSPiIQJNocUVqLLvMlEKOg7TYmF1pCAsNvOOLyngX2HWk1/CR4Kqnv5I4shjVtpuK+jylsGS
 7fl20MylVHhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,279,1596524400"; d="scan'208";a="303807037"
Received: from lkp-server01.sh.intel.com (HELO a05db971c861) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 19 Sep 2020 10:28:17 -0700
Received: from kbuild by a05db971c861 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kJgen-00017I-1G; Sat, 19 Sep 2020 17:28:17 +0000
Date: Sun, 20 Sep 2020 01:27:59 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 e3f78d5e7e6b0825f4e646f74b0e469b023e5df4
Message-ID: <5f663f9f.rHYxa8KkkK61rBmM%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git  dev
branch HEAD: e3f78d5e7e6b0825f4e646f74b0e469b023e5df4  erofs: remove unneeded parameter

elapsed time: 725m

configs tested: 148
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                          amiga_defconfig
powerpc                 mpc832x_mds_defconfig
ia64                             alldefconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
arm                       imx_v6_v7_defconfig
arm                             rpc_defconfig
c6x                              allyesconfig
arm                            u300_defconfig
arm                           efm32_defconfig
arm                          prima2_defconfig
sparc                       sparc64_defconfig
arm                             ezx_defconfig
sh                           se7750_defconfig
xtensa                         virt_defconfig
arm                           corgi_defconfig
sparc                               defconfig
powerpc                 mpc8272_ads_defconfig
m68k                         apollo_defconfig
mips                           jazz_defconfig
arm                         s5pv210_defconfig
sparc64                          alldefconfig
mips                           ip28_defconfig
m68k                       m5208evb_defconfig
powerpc                      arches_defconfig
xtensa                              defconfig
arm                        spear3xx_defconfig
arm                             mxs_defconfig
sh                   secureedge5410_defconfig
mips                      pistachio_defconfig
mips                            e55_defconfig
powerpc                     ppa8548_defconfig
nios2                         3c120_defconfig
powerpc                      pcm030_defconfig
sh                        sh7763rdp_defconfig
c6x                                 defconfig
xtensa                    smp_lx200_defconfig
mips                           rs90_defconfig
powerpc                      ppc40x_defconfig
arm                  colibri_pxa300_defconfig
mips                  maltasmvp_eva_defconfig
sh                         microdev_defconfig
alpha                               defconfig
riscv                             allnoconfig
arm                    vt8500_v6_v7_defconfig
arm                         mv78xx0_defconfig
arm                          badge4_defconfig
mips                      loongson3_defconfig
m68k                        stmark2_defconfig
sh                           se7780_defconfig
sparc                            allyesconfig
powerpc                    mvme5100_defconfig
arm                            xcep_defconfig
sh                     sh7710voipgw_defconfig
mips                        bcm63xx_defconfig
mips                        omega2p_defconfig
arm                       versatile_defconfig
arm                            mps2_defconfig
powerpc                        icon_defconfig
arm                       omap2plus_defconfig
mips                        jmr3927_defconfig
mips                       rbtx49xx_defconfig
mips                        nlm_xlp_defconfig
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
csky                                defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200917
i386                 randconfig-a006-20200917
i386                 randconfig-a003-20200917
i386                 randconfig-a001-20200917
i386                 randconfig-a002-20200917
i386                 randconfig-a005-20200917
x86_64               randconfig-a014-20200917
x86_64               randconfig-a011-20200917
x86_64               randconfig-a016-20200917
x86_64               randconfig-a012-20200917
x86_64               randconfig-a015-20200917
x86_64               randconfig-a013-20200917
x86_64               randconfig-a014-20200919
x86_64               randconfig-a011-20200919
x86_64               randconfig-a012-20200919
x86_64               randconfig-a016-20200919
x86_64               randconfig-a015-20200919
x86_64               randconfig-a013-20200919
x86_64               randconfig-a004-20200918
x86_64               randconfig-a006-20200918
x86_64               randconfig-a003-20200918
x86_64               randconfig-a002-20200918
x86_64               randconfig-a005-20200918
x86_64               randconfig-a001-20200918
i386                 randconfig-a015-20200917
i386                 randconfig-a014-20200917
i386                 randconfig-a011-20200917
i386                 randconfig-a013-20200917
i386                 randconfig-a016-20200917
i386                 randconfig-a012-20200917
i386                 randconfig-a015-20200918
i386                 randconfig-a011-20200918
i386                 randconfig-a014-20200918
i386                 randconfig-a013-20200918
i386                 randconfig-a012-20200918
i386                 randconfig-a016-20200918
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20200917
x86_64               randconfig-a004-20200917
x86_64               randconfig-a003-20200917
x86_64               randconfig-a002-20200917
x86_64               randconfig-a001-20200917
x86_64               randconfig-a005-20200917

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
