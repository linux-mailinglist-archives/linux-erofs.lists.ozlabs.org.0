Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AA26549590A
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jan 2022 05:58:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jg6bY4cqJz30Q8
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jan 2022 15:58:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iunMetBT;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=iunMetBT; dkim-atps=neutral
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jg6bQ3xhmz2xsP
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jan 2022 15:58:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1642741122; x=1674277122;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=5/JwIWIhe2lFKKVbd2opuHQ7x9oC7Pay/c6mV5LoKFc=;
 b=iunMetBTadQhBvXN/u7uML8Ba7A4AUg7L8ch4TdgLKzkkEhAlz8iAV8L
 yacLM8ZH2xFNFh9OrCuDm+ycZILDXmRwpAbjP4v5IdN2Oc1LY4Byal6JU
 9KwjspPXzhmZDT9kNRldSNY0pk/Xd8zRNFoYpTzxO1M+5m/AG949UjvNq
 i4JqgjMCK76P4+TZ0EEzkna+SJqsPqIq6KOSk0j12KQQTmDxqtO8FiawR
 nykpaxGZLjFNZxqyOfdB4Fdf0lCAsbzmRcO3mDamamvIBF9PPfsbjArH7
 bJ9V3jPQfbAfn/gag+e3Ma0rawkx+We+YIItoOrxHZZVAyOOqUhalL/M+ A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="232926098"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; d="scan'208";a="232926098"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2022 20:57:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; d="scan'208";a="579480245"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 20 Jan 2022 20:57:31 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nAlzO-000Ev7-Gr; Fri, 21 Jan 2022 04:57:30 +0000
Date: Fri, 21 Jan 2022 12:56:53 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 514abfe06f34f029e91fc0dccf8f95acff3ee084
Message-ID: <61ea3d15.MrxIduHR3nUngRqh%lkp@intel.com>
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
branch HEAD: 514abfe06f34f029e91fc0dccf8f95acff3ee084  erofs: fix fsdax partition offset handling

elapsed time: 725m

configs tested: 144
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
mips                 randconfig-c004-20220120
sh                          urquell_defconfig
sh                          sdk7780_defconfig
sh                               j2_defconfig
arm                           stm32_defconfig
sh                          landisk_defconfig
arm                           corgi_defconfig
powerpc                       eiger_defconfig
xtensa                       common_defconfig
ia64                      gensparse_defconfig
arm                     eseries_pxa_defconfig
m68k                        m5307c3_defconfig
powerpc                     mpc83xx_defconfig
mips                            gpr_defconfig
ia64                             alldefconfig
m68k                       m5208evb_defconfig
powerpc                     rainier_defconfig
arm                           h5000_defconfig
arm                        realview_defconfig
arm                        cerfcube_defconfig
h8300                            alldefconfig
sh                  sh7785lcr_32bit_defconfig
xtensa                generic_kc705_defconfig
sh                          polaris_defconfig
arm                       imx_v6_v7_defconfig
m68k                       m5475evb_defconfig
powerpc                         wii_defconfig
arm                  randconfig-c002-20220120
arm                  randconfig-c002-20220116
arm                  randconfig-c002-20220117
arm                  randconfig-c002-20220118
arm                  randconfig-c002-20220119
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a015
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64               randconfig-a016-20220117
x86_64               randconfig-a012-20220117
x86_64               randconfig-a013-20220117
x86_64               randconfig-a011-20220117
x86_64               randconfig-a014-20220117
x86_64               randconfig-a015-20220117
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220120
riscv                randconfig-r042-20220119
s390                 randconfig-r044-20220119
arc                  randconfig-r043-20220119
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
arm                  randconfig-c002-20220120
riscv                randconfig-c006-20220120
powerpc              randconfig-c003-20220120
mips                 randconfig-c004-20220120
i386                          randconfig-c001
arm                  randconfig-c002-20220121
riscv                randconfig-c006-20220121
powerpc              randconfig-c003-20220121
mips                 randconfig-c004-20220121
powerpc                     ppa8548_defconfig
powerpc                       ebony_defconfig
mips                        omega2p_defconfig
x86_64                           allyesconfig
arm                      tct_hammer_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     kmeter1_defconfig
i386                 randconfig-a005-20220117
i386                 randconfig-a001-20220117
i386                 randconfig-a006-20220117
i386                 randconfig-a004-20220117
i386                 randconfig-a002-20220117
i386                 randconfig-a003-20220117
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64               randconfig-a005-20220117
x86_64               randconfig-a004-20220117
x86_64               randconfig-a001-20220117
x86_64               randconfig-a006-20220117
x86_64               randconfig-a002-20220117
x86_64               randconfig-a003-20220117
riscv                randconfig-r042-20220120
hexagon              randconfig-r045-20220120
hexagon              randconfig-r041-20220120
s390                 randconfig-r044-20220120

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
