Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 468AB4CB540
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Mar 2022 04:13:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K8GJT2Q2yz3brQ
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Mar 2022 14:12:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=axr6UMIo;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=axr6UMIo; dkim-atps=neutral
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K8GJK6xD8z30Qg
 for <linux-erofs@lists.ozlabs.org>; Thu,  3 Mar 2022 14:12:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646277171; x=1677813171;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=9H2+PfOmlxQOm9k55E2rLh8fr5GQPNRxfFpqWw4dycE=;
 b=axr6UMIo0oiz/YXehXXJD2DAzIc/ZqEYyHnhP5FOl5mLzFHwBfVm6w/B
 gG61/FqkVYpnPXgSJZswranLEgiiCPLJwP/VcZ8cgdE+IRGCXB7QE54L6
 Gg4EQx4UmP6SV9CHScsQ/GLA0zvBt+5VeIS7+8PtXXbZWSaRi5dBjqROy
 KHIPTxub0VfuXCO/wyGiY0fe+kzfNcSRfbX26sN0rUYjfIIoTSQDJ58gQ
 YknAo3lctKUAU0UM7ct9EmXy7xpBwHGos5BMF6wJHDr47Q0Iib/Mpwdah
 cGcYZ5le4rxL13N1kTSrUAO4B9nQZwZT/Rfjt7gg2OhfwvZcyCK4aJVEL Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="234179842"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; d="scan'208";a="234179842"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2022 19:11:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; d="scan'208";a="594236609"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2022 19:11:41 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nPbsS-00001I-F0; Thu, 03 Mar 2022 03:11:40 +0000
Date: Thu, 03 Mar 2022 10:15:01 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 22ba5e99b96f1c0dbdfa4f4e1d9751b4c8348541
Message-ID: <622024a5.NPSJJ/Bfm+wtU/wA%lkp@intel.com>
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
branch HEAD: 22ba5e99b96f1c0dbdfa4f4e1d9751b4c8348541  erofs: fix ztailpacking on > 4GiB filesystems

elapsed time: 724m

configs tested: 137
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
powerpc                   motionpro_defconfig
sh                         microdev_defconfig
mips                           xway_defconfig
arm                            zeus_defconfig
powerpc                      pasemi_defconfig
openrisc                            defconfig
sh                        dreamcast_defconfig
sh                ecovec24-romimage_defconfig
mips                      fuloong2e_defconfig
mips                     loongson1b_defconfig
powerpc                    klondike_defconfig
arm                             ezx_defconfig
h8300                     edosk2674_defconfig
powerpc                    amigaone_defconfig
mips                            ar7_defconfig
m68k                          sun3x_defconfig
arm                            mps2_defconfig
mips                        jmr3927_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                 decstation_r4k_defconfig
powerpc                    adder875_defconfig
m68k                       m5275evb_defconfig
mips                          rb532_defconfig
powerpc                     asp8347_defconfig
parisc64                         alldefconfig
sparc                               defconfig
sh                            titan_defconfig
m68k                        m5272c3_defconfig
i386                             alldefconfig
arm                         at91_dt_defconfig
arm                         nhk8815_defconfig
mips                       bmips_be_defconfig
arm                           u8500_defconfig
sh                          sdk7780_defconfig
sh                             shx3_defconfig
sh                            migor_defconfig
arm                  randconfig-c002-20220302
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
i386                             allyesconfig
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
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220302
s390                 randconfig-r044-20220302
riscv                randconfig-r042-20220302
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220302
riscv                randconfig-c006-20220302
i386                          randconfig-c001
arm                  randconfig-c002-20220302
mips                 randconfig-c004-20220302
mips                           ip27_defconfig
arm                          ep93xx_defconfig
arm                          imote2_defconfig
arm                          pxa168_defconfig
powerpc                 mpc8560_ads_defconfig
mips                   sb1250_swarm_defconfig
mips                         tb0219_defconfig
arm                         socfpga_defconfig
powerpc                   bluestone_defconfig
mips                           mtx1_defconfig
mips                          ath25_defconfig
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
hexagon              randconfig-r045-20220302
hexagon              randconfig-r041-20220302

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
