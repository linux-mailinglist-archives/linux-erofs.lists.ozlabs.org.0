Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3702710DB
	for <lists+linux-erofs@lfdr.de>; Sun, 20 Sep 2020 00:07:22 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bv4Yz5lK6zDqq7
	for <lists+linux-erofs@lfdr.de>; Sun, 20 Sep 2020 08:07:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bv4Yt5GNwzDqlw
 for <linux-erofs@lists.ozlabs.org>; Sun, 20 Sep 2020 08:07:12 +1000 (AEST)
IronPort-SDR: sdcgXUMAst33Z/KTiKPnjEPgjaP04YCcLBQ+PzjQEWsmyWRjj6RkODN8lRyZo5HmQmG0SqHG1O
 hpDntFI2ASEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9749"; a="161101512"
X-IronPort-AV: E=Sophos;i="5.77,280,1596524400"; d="scan'208";a="161101512"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2020 15:07:06 -0700
IronPort-SDR: SmMOVbqRw3Pr3g3xSGw9rOgfyVr49DmjUuOet2ipSKMV//0Nv2jUVOlUQGGrRRKSKEUxl9r50m
 TEh3nXaTQIpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,280,1596524400"; d="scan'208";a="303891702"
Received: from lkp-server01.sh.intel.com (HELO a05db971c861) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 19 Sep 2020 15:07:04 -0700
Received: from kbuild by a05db971c861 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kJl0a-0001BY-13; Sat, 19 Sep 2020 22:07:04 +0000
Date: Sun, 20 Sep 2020 06:06:14 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 6ea5aad32dd8b35af68b1ba955daa368900d3b98
Message-ID: <5f6680d6.bVGX6HHs5tXAefqa%lkp@intel.com>
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
branch HEAD: 6ea5aad32dd8b35af68b1ba955daa368900d3b98  erofs: add REQ_RAHEAD flag to readahead requests

elapsed time: 723m

configs tested: 130
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm                       imx_v6_v7_defconfig
powerpc                 mpc832x_mds_defconfig
arm                             rpc_defconfig
c6x                              allyesconfig
arm                            u300_defconfig
arm                           efm32_defconfig
arm                          prima2_defconfig
sparc                       sparc64_defconfig
arm                             ezx_defconfig
arm                          pxa3xx_defconfig
powerpc                      mgcoge_defconfig
parisc                generic-32bit_defconfig
m68k                        m5272c3_defconfig
sh                     magicpanelr2_defconfig
arm                         nhk8815_defconfig
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
c6x                                 defconfig
xtensa                    smp_lx200_defconfig
mips                           rs90_defconfig
powerpc                      ppc40x_defconfig
arm                  colibri_pxa300_defconfig
mips                  maltasmvp_eva_defconfig
sh                         microdev_defconfig
alpha                               defconfig
arm                    vt8500_v6_v7_defconfig
arm                         mv78xx0_defconfig
arm                          badge4_defconfig
mips                      loongson3_defconfig
m68k                        stmark2_defconfig
sh                           se7780_defconfig
powerpc                     tqm5200_defconfig
powerpc                    klondike_defconfig
arc                         haps_hs_defconfig
arm                          lpd270_defconfig
arm                          simpad_defconfig
mips                           ci20_defconfig
h8300                       h8s-sim_defconfig
sh                          rsk7264_defconfig
sh                           se7724_defconfig
mips                  decstation_64_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
i386                 randconfig-a015-20200917
i386                 randconfig-a014-20200917
i386                 randconfig-a011-20200917
i386                 randconfig-a013-20200917
i386                 randconfig-a016-20200917
i386                 randconfig-a012-20200917
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
x86_64               randconfig-a006-20200917
x86_64               randconfig-a004-20200917
x86_64               randconfig-a003-20200917
x86_64               randconfig-a002-20200917
x86_64               randconfig-a001-20200917
x86_64               randconfig-a005-20200917

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
