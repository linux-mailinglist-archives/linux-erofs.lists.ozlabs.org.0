Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1262F92AF3D
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jul 2024 07:02:21 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ce+CPXQR;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WJ84B4cL1z3fRj
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jul 2024 15:02:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ce+CPXQR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WJ8446w6sz3dBK
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Jul 2024 15:02:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720501334; x=1752037334;
  h=date:from:to:cc:subject:message-id;
  bh=9ZAoXGGAaSZKCC2gEqTZGVDEVOF9nd/0qo1DISOIwCQ=;
  b=Ce+CPXQRbG8M4CCwmz0h0u+A9q8SKwFJnNPy7uZXHjZsua4MRmySb9vc
   eJsLwOAzQ7fP9KU5CIAhLszEULWOVeNPKEoedTF8dxF0OJf0iRfsF6nIB
   jxqO1j4jQ7mHVcSdXJIDqDlFjO5SpHotUdSal7hy2ydcC8QbPW2DHtOVv
   myoMNT6ySRz96/Dhnx6rU+kXq2u0Qb1I2pTGVHouvwLoXEEvpXy/x3b7b
   HvUEV1hyvCsjBfDjSUEFMvy42zvv/H4LeeyLbwLTK20eAsC75lc5ye1Gt
   dA/a+tji9Wj2azEA69V+kmdMOKeXa5EB16yu1FGxgICc6mlHqdYo6vqMw
   w==;
X-CSE-ConnectionGUID: sxacasdVRJK8MAgHJsSMDg==
X-CSE-MsgGUID: TwVzwMRuSwSZkBqJEm5MnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17549286"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="17549286"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 22:02:07 -0700
X-CSE-ConnectionGUID: Uk9oLiktQQeHmuAfv8whzg==
X-CSE-MsgGUID: yueYr0TySJmORIK5B3pUHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="47651149"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 08 Jul 2024 22:02:05 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sR2zJ-000WKg-34;
	Tue, 09 Jul 2024 05:02:01 +0000
Date: Tue, 09 Jul 2024 13:01:21 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 2080ca1ed3e43233c4e8480c0b9d2840886de01e
Message-ID: <202407091319.ZuxFIygz-lkp@intel.com>
User-Agent: s-nail v14.9.24
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
branch HEAD: 2080ca1ed3e43233c4e8480c0b9d2840886de01e  erofs: tidy up `struct z_erofs_bvec`

elapsed time: 862m

configs tested: 167
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-13.2.0
arm                          gemini_defconfig   gcc-13.2.0
arm                      integrator_defconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   gcc-13.2.0
arm                         nhk8815_defconfig   gcc-13.2.0
arm                        spear6xx_defconfig   gcc-13.2.0
arm                         vf610m4_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240709   gcc-11
i386         buildonly-randconfig-002-20240709   gcc-11
i386         buildonly-randconfig-003-20240709   gcc-11
i386         buildonly-randconfig-004-20240709   gcc-11
i386         buildonly-randconfig-005-20240709   gcc-11
i386         buildonly-randconfig-006-20240709   gcc-11
i386                                defconfig   clang-18
i386                  randconfig-001-20240709   gcc-11
i386                  randconfig-002-20240709   gcc-11
i386                  randconfig-003-20240709   gcc-11
i386                  randconfig-004-20240709   gcc-11
i386                  randconfig-005-20240709   gcc-11
i386                  randconfig-006-20240709   gcc-11
i386                  randconfig-011-20240709   gcc-11
i386                  randconfig-012-20240709   gcc-11
i386                  randconfig-013-20240709   gcc-11
i386                  randconfig-014-20240709   gcc-11
i386                  randconfig-015-20240709   gcc-11
i386                  randconfig-016-20240709   gcc-11
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                       bvme6000_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                          multi_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                         bigsur_defconfig   gcc-13.2.0
mips                         cobalt_defconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-13.2.0
mips                           jazz_defconfig   gcc-13.2.0
mips                      malta_kvm_defconfig   gcc-13.2.0
mips                    maltaup_xpa_defconfig   gcc-13.2.0
nios2                         3c120_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
openrisc                    or1ksim_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-13.2.0
powerpc                    gamecube_defconfig   gcc-13.2.0
powerpc                     kmeter1_defconfig   gcc-13.2.0
powerpc                   lite5200b_defconfig   gcc-13.2.0
powerpc                      mgcoge_defconfig   gcc-13.2.0
powerpc                    mvme5100_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc                     powernv_defconfig   gcc-13.2.0
powerpc                      ppc44x_defconfig   gcc-13.2.0
powerpc                         ps3_defconfig   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-13.2.0
powerpc                      tqm8xx_defconfig   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
sh                               alldefconfig   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                        dreamcast_defconfig   gcc-13.2.0
sh                ecovec24-romimage_defconfig   gcc-13.2.0
sh                        edosk7760_defconfig   gcc-13.2.0
sh                            hp6xx_defconfig   gcc-13.2.0
sh                          rsk7203_defconfig   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                           se7206_defconfig   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.2.0
sh                   secureedge5410_defconfig   gcc-13.2.0
sh                        sh7785lcr_defconfig   gcc-13.2.0
sh                            shmin_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                          alldefconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240709   gcc-11
x86_64       buildonly-randconfig-002-20240709   gcc-11
x86_64       buildonly-randconfig-003-20240709   gcc-11
x86_64       buildonly-randconfig-004-20240709   gcc-11
x86_64       buildonly-randconfig-005-20240709   gcc-11
x86_64       buildonly-randconfig-006-20240709   gcc-11
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240709   gcc-11
x86_64                randconfig-002-20240709   gcc-11
x86_64                randconfig-003-20240709   gcc-11
x86_64                randconfig-004-20240709   gcc-11
x86_64                randconfig-005-20240709   gcc-11
x86_64                randconfig-006-20240709   gcc-11
x86_64                randconfig-011-20240709   gcc-11
x86_64                randconfig-012-20240709   gcc-11
x86_64                randconfig-013-20240709   gcc-11
x86_64                randconfig-014-20240709   gcc-11
x86_64                randconfig-015-20240709   gcc-11
x86_64                randconfig-016-20240709   gcc-11
x86_64                randconfig-071-20240709   gcc-11
x86_64                randconfig-072-20240709   gcc-11
x86_64                randconfig-073-20240709   gcc-11
x86_64                randconfig-074-20240709   gcc-11
x86_64                randconfig-075-20240709   gcc-11
x86_64                randconfig-076-20240709   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                    xip_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
