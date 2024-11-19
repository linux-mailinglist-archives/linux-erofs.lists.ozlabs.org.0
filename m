Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AEC9D1CE6
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Nov 2024 02:05:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XsmWS5NBRz3bX5
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Nov 2024 12:05:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731978322;
	cv=none; b=T7nXSu80wXL0PSSSCzkJ6rrqET6z1q2/8UNsx48cKXOhQZf6oZbv5bvS1PoDHJgYcrMALKmnrNhkmnL6RqgTwYIJ+SDjCwR5rpKLx611x2/1UggrNmsKHqVXpKPEIyMWQQs1Z2MHrtiRCec0hqnSqQmNQIQDdhY740uutwsK4Sg3M2QXMAvkJ1UQWH5aVeyM+2yyw/gqkqzfDDt0mTqEs4HYOP7Mj5wmU5+JpOUUvMMhOEoJKDCkw9bgyoQ8PQI1hd00uX6JnMa7y6VLrig36gUCRhnuYhYWR9oTeOALxOXopXiJebcTDCyv863OHonO96I6t6tDBRI1DI53ESUcnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731978322; c=relaxed/relaxed;
	bh=paEE1Z7dBub0G9lZ3cDaGsqQa/QqG235vqR/ei3CDDg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fXBOCQO/En3D6Zg5KmZHfXC/9vh/8Yrm8gMkH0mR5lJvsxGPOl12W+LJDmD3KkiHOhf8rIZ81kvoy3wD8tKnflzbJycjUeHYl4LutvI9eT6kurK9abpa6p/M0+ww6lnnpDkoQYsoJD0d7iC8190BfNLKUbFKG1Gpf63xZ6J+YONcq2YEIVZ6xcf+RZpLG5sCO9AxQVpiQU7nc6QmYCfwCZ2T5cj5wlHoW7yXI88n4AVxFsHyv6P14o6Do2ad2k+r2GIEQgZsw6h4kmmHAzQeX4ZfERydX9fBZEGf9aHA3Lqg8gcOnRZqzaPnDc5WiL1EgfqG6SYwoYjMBuIGrftwbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZJMaZ+fC; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZJMaZ+fC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XsmWK5Mgtz2y65
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Nov 2024 12:05:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731978318; x=1763514318;
  h=date:from:to:cc:subject:message-id;
  bh=33PXHGXyY9AuqYOBI3nC0g/OpMHORmZoeau+Bzidkms=;
  b=ZJMaZ+fCc0p13720qeayg3+a6XjmFqZrdyEUEif6w4UkolTrBET4F6hE
   yL95yBLiNQCg1cQXig0eZ+w0FmZ67iDtVTY5LThr9jzolRMNs/QfqTYwW
   Dgy5/AnZObZszM+e2aPFgladmdC3cu/BlmE0+MbSy4spYmztAlzAVcSPS
   jshkZAsACLddqqj0e+BRe13NqAolD/Nk89TdRIRNZPeY4c5D1mFM/ZhCw
   Ua8tYJBH757ddEJgXeqqkIR8twkzQNLiqlrXTfYvpZ5UTVrMZDCz6M9yQ
   um76GBpKcN7AOA+dkGt5R5NuJ8/lcGXGmT7vyvyhQtznmtKeVz4yD639c
   Q==;
X-CSE-ConnectionGUID: g0zMkr5sRlqnRZGGUguSXQ==
X-CSE-MsgGUID: GhNuqBeoRQmDovNoNceGMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="19569285"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="19569285"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 17:05:13 -0800
X-CSE-ConnectionGUID: QVlNx3m8SbueBV/tosvv1A==
X-CSE-MsgGUID: hHFtRAblQGKM/8XYVr78vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="93850432"
Received: from lkp-server01.sh.intel.com (HELO 64fdafcea91b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 18 Nov 2024 17:05:11 -0800
Received: from kbuild by 64fdafcea91b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tDCft-00003N-0r;
	Tue, 19 Nov 2024 01:05:01 +0000
Date: Tue, 19 Nov 2024 09:04:06 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 0bc8061ffc733a0a246b8689b2d32a3e9204f43c
Message-ID: <202411190900.4SsgtEel-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 0bc8061ffc733a0a246b8689b2d32a3e9204f43c  erofs: handle NONHEAD !delta[1] lclusters gracefully

elapsed time: 825m

configs tested: 272
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.2.0
arc                        nsimosci_defconfig    clang-15
arc                   randconfig-001-20241119    gcc-14.2.0
arc                   randconfig-002-20241119    gcc-14.2.0
arc                        vdk_hs38_defconfig    clang-20
arc                    vdk_hs38_smp_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                        clps711x_defconfig    clang-15
arm                                 defconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-20
arm                            hisi_defconfig    clang-20
arm                        keystone_defconfig    clang-20
arm                         lpc32xx_defconfig    clang-15
arm                   milbeaut_m10v_defconfig    clang-20
arm                            mmp2_defconfig    gcc-14.2.0
arm                         nhk8815_defconfig    clang-20
arm                       omap2plus_defconfig    gcc-14.2.0
arm                          pxa910_defconfig    clang-20
arm                             pxa_defconfig    clang-20
arm                   randconfig-001-20241119    gcc-14.2.0
arm                   randconfig-002-20241119    gcc-14.2.0
arm                   randconfig-003-20241119    gcc-14.2.0
arm                   randconfig-004-20241119    gcc-14.2.0
arm                             rpc_defconfig    clang-20
arm                       spear13xx_defconfig    clang-20
arm                        spear3xx_defconfig    clang-15
arm                        spear6xx_defconfig    clang-20
arm                           u8500_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241119    gcc-14.2.0
arm64                 randconfig-002-20241119    gcc-14.2.0
arm64                 randconfig-003-20241119    gcc-14.2.0
arm64                 randconfig-004-20241119    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241119    gcc-14.2.0
csky                  randconfig-002-20241119    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241119    gcc-14.2.0
hexagon               randconfig-002-20241119    gcc-14.2.0
i386                             alldefconfig    clang-20
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241118    gcc-12
i386        buildonly-randconfig-001-20241119    clang-19
i386        buildonly-randconfig-002-20241118    gcc-12
i386        buildonly-randconfig-002-20241119    clang-19
i386        buildonly-randconfig-003-20241118    gcc-12
i386        buildonly-randconfig-003-20241119    clang-19
i386        buildonly-randconfig-004-20241118    gcc-12
i386        buildonly-randconfig-004-20241119    clang-19
i386        buildonly-randconfig-005-20241118    gcc-12
i386        buildonly-randconfig-005-20241119    clang-19
i386        buildonly-randconfig-006-20241118    gcc-12
i386        buildonly-randconfig-006-20241119    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241118    gcc-12
i386                  randconfig-001-20241119    clang-19
i386                  randconfig-002-20241118    gcc-12
i386                  randconfig-002-20241119    clang-19
i386                  randconfig-003-20241118    gcc-12
i386                  randconfig-003-20241119    clang-19
i386                  randconfig-004-20241118    gcc-12
i386                  randconfig-004-20241119    clang-19
i386                  randconfig-005-20241118    gcc-12
i386                  randconfig-005-20241119    clang-19
i386                  randconfig-006-20241118    gcc-12
i386                  randconfig-006-20241119    clang-19
i386                  randconfig-011-20241118    gcc-12
i386                  randconfig-011-20241119    clang-19
i386                  randconfig-012-20241118    gcc-12
i386                  randconfig-012-20241119    clang-19
i386                  randconfig-013-20241118    gcc-12
i386                  randconfig-013-20241119    clang-19
i386                  randconfig-014-20241118    gcc-12
i386                  randconfig-014-20241119    clang-19
i386                  randconfig-015-20241118    gcc-12
i386                  randconfig-015-20241119    clang-19
i386                  randconfig-016-20241118    gcc-12
i386                  randconfig-016-20241119    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241119    gcc-14.2.0
loongarch             randconfig-002-20241119    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          hp300_defconfig    clang-15
m68k                       m5208evb_defconfig    clang-20
m68k                       m5249evb_defconfig    clang-20
m68k                       m5275evb_defconfig    clang-15
m68k                        m5307c3_defconfig    clang-20
m68k                            mac_defconfig    clang-20
m68k                          multi_defconfig    gcc-14.2.0
m68k                        mvme147_defconfig    clang-20
m68k                            q40_defconfig    clang-20
m68k                            q40_defconfig    gcc-14.2.0
m68k                          sun3x_defconfig    clang-15
m68k                           virt_defconfig    clang-15
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      bmips_stb_defconfig    clang-20
mips                          eyeq5_defconfig    clang-20
mips                           gcw0_defconfig    clang-15
mips                       rbtx49xx_defconfig    clang-20
mips                        vocore2_defconfig    clang-15
mips                           xway_defconfig    clang-20
nios2                         3c120_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241119    gcc-14.2.0
nios2                 randconfig-002-20241119    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241119    gcc-14.2.0
parisc                randconfig-002-20241119    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                    adder875_defconfig    clang-20
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                   bluestone_defconfig    gcc-14.2.0
powerpc                       eiger_defconfig    clang-20
powerpc                     ep8248e_defconfig    clang-15
powerpc                     ep8248e_defconfig    clang-20
powerpc                          g5_defconfig    clang-20
powerpc                       holly_defconfig    clang-20
powerpc                      mgcoge_defconfig    clang-15
powerpc                 mpc836x_rdk_defconfig    clang-15
powerpc                  mpc885_ads_defconfig    clang-20
powerpc                     ppa8548_defconfig    clang-15
powerpc                      ppc44x_defconfig    gcc-14.2.0
powerpc                     rainier_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241119    gcc-14.2.0
powerpc               randconfig-002-20241119    gcc-14.2.0
powerpc               randconfig-003-20241119    gcc-14.2.0
powerpc                     redwood_defconfig    clang-20
powerpc                      tqm8xx_defconfig    clang-20
powerpc64             randconfig-001-20241119    gcc-14.2.0
powerpc64             randconfig-002-20241119    gcc-14.2.0
powerpc64             randconfig-003-20241119    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    clang-20
riscv                 randconfig-001-20241119    gcc-14.2.0
riscv                 randconfig-002-20241119    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241119    gcc-14.2.0
s390                  randconfig-002-20241119    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    gcc-14.2.0
sh                             espt_defconfig    clang-20
sh                             espt_defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    clang-20
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                    randconfig-001-20241119    gcc-14.2.0
sh                    randconfig-002-20241119    gcc-14.2.0
sh                           se7712_defconfig    clang-20
sh                           se7722_defconfig    clang-20
sh                           se7724_defconfig    clang-15
sh                        sh7763rdp_defconfig    clang-20
sh                             shx3_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                       sparc32_defconfig    clang-20
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241119    gcc-14.2.0
sparc64               randconfig-002-20241119    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    clang-15
um                             i386_defconfig    gcc-12
um                             i386_defconfig    gcc-14.2.0
um                    randconfig-001-20241119    gcc-14.2.0
um                    randconfig-002-20241119    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
um                           x86_64_defconfig    gcc-14.2.0
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241118    gcc-12
x86_64      buildonly-randconfig-001-20241119    gcc-12
x86_64      buildonly-randconfig-002-20241118    gcc-12
x86_64      buildonly-randconfig-002-20241119    gcc-12
x86_64      buildonly-randconfig-003-20241118    gcc-12
x86_64      buildonly-randconfig-003-20241119    gcc-12
x86_64      buildonly-randconfig-004-20241118    gcc-12
x86_64      buildonly-randconfig-004-20241119    gcc-12
x86_64      buildonly-randconfig-005-20241118    gcc-12
x86_64      buildonly-randconfig-005-20241119    gcc-12
x86_64      buildonly-randconfig-006-20241118    gcc-12
x86_64      buildonly-randconfig-006-20241119    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241118    gcc-12
x86_64                randconfig-001-20241119    gcc-12
x86_64                randconfig-002-20241118    gcc-12
x86_64                randconfig-002-20241119    gcc-12
x86_64                randconfig-003-20241118    gcc-12
x86_64                randconfig-003-20241119    gcc-12
x86_64                randconfig-004-20241118    gcc-12
x86_64                randconfig-004-20241119    gcc-12
x86_64                randconfig-005-20241118    gcc-12
x86_64                randconfig-005-20241119    gcc-12
x86_64                randconfig-006-20241118    gcc-12
x86_64                randconfig-006-20241119    gcc-12
x86_64                randconfig-011-20241118    gcc-12
x86_64                randconfig-011-20241119    gcc-12
x86_64                randconfig-012-20241118    gcc-12
x86_64                randconfig-012-20241119    gcc-12
x86_64                randconfig-013-20241118    gcc-12
x86_64                randconfig-013-20241119    gcc-12
x86_64                randconfig-014-20241118    gcc-12
x86_64                randconfig-014-20241119    gcc-12
x86_64                randconfig-015-20241118    gcc-12
x86_64                randconfig-015-20241119    gcc-12
x86_64                randconfig-016-20241118    gcc-12
x86_64                randconfig-016-20241119    gcc-12
x86_64                randconfig-071-20241118    gcc-12
x86_64                randconfig-071-20241119    gcc-12
x86_64                randconfig-072-20241118    gcc-12
x86_64                randconfig-072-20241119    gcc-12
x86_64                randconfig-073-20241118    gcc-12
x86_64                randconfig-073-20241119    gcc-12
x86_64                randconfig-074-20241118    gcc-12
x86_64                randconfig-074-20241119    gcc-12
x86_64                randconfig-075-20241118    gcc-12
x86_64                randconfig-075-20241119    gcc-12
x86_64                randconfig-076-20241118    gcc-12
x86_64                randconfig-076-20241119    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                               rhel-9.4    gcc-12
xtensa                           alldefconfig    gcc-14.2.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241119    gcc-14.2.0
xtensa                randconfig-002-20241119    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
