Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5679C482211
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Dec 2021 06:01:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JQCdn2BNMz3051
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Dec 2021 16:01:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mT/NoZSq;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mT/NoZSq; dkim-atps=neutral
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JQCdg3HNTz2ywZ
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 Dec 2021 16:00:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640926855; x=1672462855;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=nUvOXpLg44h5EbohO/tTdMD0KbMxLjv4XxlxSUQtXpE=;
 b=mT/NoZSq79ICCYk8UFOrXHfRa1Gvs0wps5+8k2sC/k0hPNJE4DL9nAw8
 cMaYClx51wJjtqiIaG1CMvPtY6jZozV4kjKY0ns5zjO1pUSMAN0CS8a9V
 BHXK9t4Oe7dhbbQMs1pHJZJ8PJHq0eapCMozpoZQFFr5I1VPqBpJIOpVh
 PSUl/x/sglA70RsyHfnJlex9TTHvSt8r+G9XKTcl12RGnP0m93LpPQUaU
 YoOF1NR89G0HNDKRtSqc2ArVY1Nvd1byGGsQG5p+XAWZkUFAEVB0XbOM0
 4OhUlioQ760q2AUDW+xPWKvrme0+pjApazmn9DN+clOOVivzA3KcGnuMv g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="228596392"
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; d="scan'208";a="228596392"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2021 20:59:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; d="scan'208";a="468993377"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 30 Dec 2021 20:59:43 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1n3A10-000Axs-KC; Fri, 31 Dec 2021 04:59:42 +0000
Date: Fri, 31 Dec 2021 12:58:52 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 ab92184ff8f12979f3d3dd5ed601ed85770d81ba
Message-ID: <61ce8e0c.NzQ7JlkbTpVKMyBf%lkp@intel.com>
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
branch HEAD: ab92184ff8f12979f3d3dd5ed601ed85770d81ba  erofs: add on-disk compressed tail-packing inline support

elapsed time: 724m

configs tested: 155
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                 randconfig-c001-20211229
i386                 randconfig-c001-20211230
mips                 randconfig-c004-20211230
sh                             sh03_defconfig
sh                   secureedge5410_defconfig
powerpc                 canyonlands_defconfig
sh                            hp6xx_defconfig
arc                        nsimosci_defconfig
arm                            hisi_defconfig
mips                       lemote2f_defconfig
powerpc                     ppa8548_defconfig
powerpc                      makalu_defconfig
sh                           se7780_defconfig
arm                         at91_dt_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                          sdk7780_defconfig
powerpc                    mvme5100_defconfig
ia64                        generic_defconfig
m68k                       m5249evb_defconfig
arm                           stm32_defconfig
powerpc                     kilauea_defconfig
arm                              alldefconfig
powerpc                 mpc8313_rdb_defconfig
arm                          collie_defconfig
powerpc                 mpc8315_rdb_defconfig
arc                          axs103_defconfig
sh                                  defconfig
mips                     loongson2k_defconfig
openrisc                         alldefconfig
csky                                defconfig
mips                        bcm63xx_defconfig
sh                          rsk7203_defconfig
arm                      footbridge_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                            e55_defconfig
powerpc                     ksi8560_defconfig
h8300                       h8s-sim_defconfig
powerpc                          g5_defconfig
arm                           spitz_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                          pxa168_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                   lite5200b_defconfig
h8300                               defconfig
arm                         nhk8815_defconfig
parisc                           allyesconfig
arm                      tct_hammer_defconfig
arm                        vexpress_defconfig
powerpc                 mpc837x_mds_defconfig
mips                         bigsur_defconfig
um                               alldefconfig
mips                            gpr_defconfig
m68k                           sun3_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                    ge_imp3a_defconfig
mips                           mtx1_defconfig
sh                ecovec24-romimage_defconfig
arm                        mini2440_defconfig
xtensa                           alldefconfig
sh                            migor_defconfig
sparc64                          alldefconfig
xtensa                  cadence_csp_defconfig
arm                        spear3xx_defconfig
arm                     davinci_all_defconfig
powerpc                   bluestone_defconfig
m68k                          multi_defconfig
arm                  randconfig-c002-20211230
arm                  randconfig-c002-20211231
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
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a013-20211230
x86_64               randconfig-a015-20211230
x86_64               randconfig-a012-20211230
x86_64               randconfig-a011-20211230
x86_64               randconfig-a016-20211230
x86_64               randconfig-a014-20211230
i386                 randconfig-a016-20211230
i386                 randconfig-a011-20211230
i386                 randconfig-a012-20211230
i386                 randconfig-a013-20211230
i386                 randconfig-a014-20211230
i386                 randconfig-a015-20211230
arc                  randconfig-r043-20211230
riscv                randconfig-r042-20211230
s390                 randconfig-r044-20211230
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func

clang tested configs:
x86_64               randconfig-a002-20211230
x86_64               randconfig-a001-20211230
x86_64               randconfig-a003-20211230
x86_64               randconfig-a006-20211230
x86_64               randconfig-a004-20211230
x86_64               randconfig-a005-20211230
i386                 randconfig-a001-20211230
i386                 randconfig-a005-20211230
i386                 randconfig-a004-20211230
i386                 randconfig-a002-20211230
i386                 randconfig-a006-20211230
i386                 randconfig-a003-20211230
x86_64               randconfig-a015-20211228
x86_64               randconfig-a014-20211228
x86_64               randconfig-a013-20211228
x86_64               randconfig-a012-20211228
x86_64               randconfig-a011-20211228
x86_64               randconfig-a016-20211228
hexagon              randconfig-r045-20211230
hexagon              randconfig-r041-20211230

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
