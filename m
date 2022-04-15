Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E6363502001
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Apr 2022 03:12:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kfdb56rDRz3bWM
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Apr 2022 11:12:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GEZny4Cn;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GEZny4Cn; dkim-atps=neutral
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KfdZy3KTRz2yZf
 for <linux-erofs@lists.ozlabs.org>; Fri, 15 Apr 2022 11:11:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649985114; x=1681521114;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=50+b1xECbUGmjp3kz8XL9xkm2ruHUx0Uv/fhljDa8NQ=;
 b=GEZny4CnQ5pEqi2tYo+HZsr2ltSsTC7UixzF42/6Y6VZ9mbS22YDDCTX
 GyLWubeQzDRI0yo/e+Gcfe6qcE1nuLf4lKWaCGI2tetXS585BylXe6kOu
 G3CxbgIir6zAYCdqqgd8uctGEuCHYKo83YqM/iZu201/wBoELHfF+kjmh
 ceC0mDtpEUwZ4d/jVDEKFSn8LxS5mS/HlJO7BNNMw51A3iYRdx0Z0dqjD
 IqK1vW6xmgpdxId/9dHKG7Y3CR4Km1wcVfyfvhCNkZkLXPQGFP6cqpbD5
 HHVCcmvMW5vurYkACh2e5GHAODRPgDrsDHcRPTCggXmIVxzMXbL0S0FNl A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="260664455"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; d="scan'208";a="260664455"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2022 18:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; d="scan'208";a="527622788"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 14 Apr 2022 18:10:43 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nfATy-0001Mb-Gv;
 Fri, 15 Apr 2022 01:10:42 +0000
Date: Fri, 15 Apr 2022 09:10:14 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 3c096ea0f51171fe4e2144da513d8259d55e5a13
Message-ID: <6258c5f6.CZqYYwi2caUZtkRy%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 3c096ea0f51171fe4e2144da513d8259d55e5a13  Documentation/ABI: sysfs-fs-erofs: Fix Sphinx errors

elapsed time: 1972m

configs tested: 119
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                             sh03_defconfig
powerpc                 mpc837x_mds_defconfig
arc                        vdk_hs38_defconfig
mips                  decstation_64_defconfig
openrisc                  or1klitex_defconfig
mips                      maltasmvp_defconfig
xtensa                         virt_defconfig
m68k                       m5475evb_defconfig
arm                        shmobile_defconfig
arm                        oxnas_v6_defconfig
arm                        keystone_defconfig
arm                             rpc_defconfig
mips                         mpc30x_defconfig
powerpc                     pq2fads_defconfig
ia64                          tiger_defconfig
parisc64                            defconfig
powerpc                     taishan_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         assabet_defconfig
parisc                generic-64bit_defconfig
x86_64                           alldefconfig
arm                           sunxi_defconfig
xtensa                           alldefconfig
x86_64                              defconfig
arm                           u8500_defconfig
arm                        spear6xx_defconfig
arm                            mps2_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220413
arm                  randconfig-c002-20220414
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
alpha                            allyesconfig
csky                                defconfig
nios2                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                randconfig-r042-20220413
arc                  randconfig-r043-20220413
s390                 randconfig-r044-20220413
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                               defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220413
arm                  randconfig-c002-20220413
i386                          randconfig-c001
riscv                randconfig-c006-20220413
mips                 randconfig-c004-20220413
powerpc              randconfig-c003-20220414
arm                  randconfig-c002-20220414
arm                       spear13xx_defconfig
mips                malta_qemu_32r6_defconfig
arm                      tct_hammer_defconfig
powerpc                     tqm5200_defconfig
arm                        multi_v5_defconfig
mips                           mtx1_defconfig
arm                        spear3xx_defconfig
arm                       mainstone_defconfig
arm                       netwinder_defconfig
mips                        workpad_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220414
hexagon              randconfig-r045-20220414
riscv                randconfig-r042-20220414

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
