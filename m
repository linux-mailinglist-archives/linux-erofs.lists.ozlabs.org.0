Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 582274DBF85
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Mar 2022 07:28:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJxzk6yBmz308h
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Mar 2022 17:28:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Dg7JD8uF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.115; helo=mga14.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Dg7JD8uF; dkim-atps=neutral
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJxzb4PDlz2xWc
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Mar 2022 17:28:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647498507; x=1679034507;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=wKJxBkt20lwgGMEb02NspFATDS3GWbjd0zL0YyzYk2s=;
 b=Dg7JD8uFU/kfRMYkXskjDfOg+DR8oNoHxim6WrYwo/NuirlX4l21jeqL
 +iKtjA6kDbgHrQxPlEA7milxa4xU8yx79Bv+T/ouzWaRUysZ2Bf8GXIar
 kmFaKmFIidlXIGj9qSuBs2irUxwDSS938hUnQbB/UZtgRg/i6xSZ1HU7X
 H0KUa5tWj0lQCOfK8IB/ze7V9jisjf5MWBEQQ51PjRMJbnC09a8ygnfJb
 XgWIYwDUwjasNR8kNe97Tw3gR7uf8NycgDwkCnSVPmRuS5XrtodfRsaPQ
 ydqQkO8zTSRfj8LBQ8SFzGtswyct/igRSryf3pQBymtN/sJ7kyFKeowdq Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256983488"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; d="scan'208";a="256983488"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 23:27:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; d="scan'208";a="646942337"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 23:27:14 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nUjbN-000DNY-Hi; Thu, 17 Mar 2022 06:27:13 +0000
Date: Thu, 17 Mar 2022 14:26:35 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 500edd0956487281a6fa0e1e34e931817e85d8b6
Message-ID: <6232d49b.N/BV3QWtIK9RJebd%lkp@intel.com>
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
branch HEAD: 500edd0956487281a6fa0e1e34e931817e85d8b6  erofs: use meta buffers for inode lookup

elapsed time: 793m

configs tested: 165
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
i386                 randconfig-c001-20220314
mips                 randconfig-c004-20220314
arm                         at91_dt_defconfig
arc                      axs103_smp_defconfig
arm                      footbridge_defconfig
arm                            lart_defconfig
sh                         microdev_defconfig
arm                         vf610m4_defconfig
powerpc                  storcenter_defconfig
sh                           sh2007_defconfig
ia64                            zx1_defconfig
arc                     nsimosci_hs_defconfig
alpha                            alldefconfig
powerpc                         wii_defconfig
h8300                            alldefconfig
arm                         nhk8815_defconfig
arc                        nsimosci_defconfig
sh                          urquell_defconfig
powerpc                     ep8248e_defconfig
parisc                generic-64bit_defconfig
xtensa                           alldefconfig
sh                              ul2_defconfig
powerpc                     tqm8541_defconfig
sh                               alldefconfig
powerpc                     tqm8555_defconfig
h8300                               defconfig
powerpc                      arches_defconfig
powerpc                      ppc40x_defconfig
sh                          sdk7780_defconfig
arm                            xcep_defconfig
mips                           ip32_defconfig
sh                        edosk7705_defconfig
nds32                             allnoconfig
sh                           se7750_defconfig
nios2                            alldefconfig
m68k                       m5475evb_defconfig
ia64                          tiger_defconfig
openrisc                 simple_smp_defconfig
xtensa                         virt_defconfig
sh                        apsh4ad0a_defconfig
arm                           stm32_defconfig
arm                        cerfcube_defconfig
sh                        dreamcast_defconfig
arm                      jornada720_defconfig
arm                        mvebu_v7_defconfig
xtensa                    smp_lx200_defconfig
powerpc                     asp8347_defconfig
arc                                 defconfig
powerpc                     taishan_defconfig
sh                        sh7757lcr_defconfig
arm                  randconfig-c002-20220314
ia64                                defconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a003-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a006-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a005-20220314
x86_64               randconfig-a002-20220314
x86_64               randconfig-a001-20220314
x86_64               randconfig-a003-20220314
x86_64               randconfig-a004-20220314
x86_64               randconfig-a006-20220314
x86_64               randconfig-a005-20220314
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
arc                  randconfig-r043-20220314
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                         shannon_defconfig
mips                            e55_defconfig
powerpc                     tqm8560_defconfig
arm                        mvebu_v5_defconfig
arm                           omap1_defconfig
hexagon                             defconfig
arm                                 defconfig
powerpc                     ksi8560_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     pseries_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     powernv_defconfig
mips                        maltaup_defconfig
mips                           mtx1_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64               randconfig-a014-20220314
x86_64               randconfig-a015-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a011-20220314
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
i386                 randconfig-a013-20220314
i386                 randconfig-a015-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a016-20220314
i386                 randconfig-a012-20220314
hexagon              randconfig-r045-20220313
hexagon              randconfig-r041-20220313
hexagon              randconfig-r045-20220314
riscv                randconfig-r042-20220314
hexagon              randconfig-r041-20220314
s390                 randconfig-r044-20220314

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
