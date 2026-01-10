Return-Path: <linux-erofs+bounces-1815-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807CDD0DD7E
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Jan 2026 21:53:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dpW7t4FLhz2ySY;
	Sun, 11 Jan 2026 07:53:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768078410;
	cv=none; b=X+FgoeXRLzEITHc/MgKp05nhImG7WcttGkgosC4SS0Pit84rRg3Obth+VRgQygkXTcci8G/gpR/3/z7/L5rj9HcYrcjMnxuA5z4YwxnGXh8zNwmb23fh2054EhAvagLfNRuNzyNhUX7FeNfirYkF5YWMM6e9NHbFwjYI/5HQyOEuLNwiPtvIWiyJf9qqbWkMNcT7FiNvOBt4fju2gewpDKMYx/8sY4jDNSE+W1QsS4yO3T8KvlWPpQQu/hgqeoadznVXMRtYKwdl8e9F+IU5GLKR4rD/laHhkxP90nbDXfA3lO9ir9GkGypSHK/i75pbHjvjpAVvyoNa/ZDr+te/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768078410; c=relaxed/relaxed;
	bh=V/+tft39EHvtPZ0FqHuS3s0xqJPGSSw+qcdYK5PS3cg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=foDA0tAkW3RiOyDN585i5cBT8vK/PYxlESJ+2sCgHZYQJGCTkiZgKIf7BrDTyoYAsPUsEX5uLer9JPJW/xpLs+sXqjo4ge1P3erYV15KTl4CmB/oKgkM64G/nMQWOPaxR6uKh/nQBYyCLSntlLsFJKIwF9HH0xl7CkzuMFamOp/CEqKhYZIjGGq8Pka5C3lUhfH/n5z604ctmm6bSr6HLjeiz1aZjiyrb9AjOekO4x0057dbAxcdt3v1AlMVNIExEsxCsgJ53goJTGJ8I0DHxvCf8XUz5MAd+b55kP0Vn6x9MVR00YFWg14tmZ1ktm4if0MxgbzN6Lv0Psbr9PAXMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nHSwmggG; dkim-atps=neutral; spf=pass (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nHSwmggG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dpW7q6r2nz2ySV
	for <linux-erofs@lists.ozlabs.org>; Sun, 11 Jan 2026 07:53:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768078408; x=1799614408;
  h=date:from:to:cc:subject:message-id;
  bh=QVWhefHVhmoWimyEkbufDHJAMsqa4XaOlllGmFK2Vsw=;
  b=nHSwmggG4zWJjj5WH4dRvr3r5xHMutslZ3e0sNzpORbC0+kN3CYtpV7u
   AXHLOtf+Q9ca72LcshPg7ipWheeBMhId30OWN5zta8yBVisjxnAclsZyB
   6X8Zozi9w5PoR6LNYfNOfsVrNo0VX1cZXdO0Odm7PrfFpvY3bt271GduT
   COJcsskmdxZYaH6QC5SZyDsesjFQHBWm4Djq3ttpG9ceQf7TPmhWqha0Z
   AB2iPMBf3vRZ74wb9ijIWMYRLi2nRuRnpBj9JpuL/6D5c92vbTC++B+fF
   q6a00fKXKjVemEJH7Hk66GMkJfA/8YH41GvLJiSrQNUBx/6favx6wAal5
   A==;
X-CSE-ConnectionGUID: LX5DjXP0Q+ibhWPLgb8jRA==
X-CSE-MsgGUID: CLvbLQ7bT/6J7kA+t+eF4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11667"; a="79710268"
X-IronPort-AV: E=Sophos;i="6.21,217,1763452800"; 
   d="scan'208";a="79710268"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2026 12:53:22 -0800
X-CSE-ConnectionGUID: NfF1HiYBRJ+sy9CjNiykhg==
X-CSE-MsgGUID: r0ymyYMTRkKh2OL/Rz+U8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,217,1763452800"; 
   d="scan'208";a="204036072"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Jan 2026 12:53:20 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vefxW-0000000099w-2OUa;
	Sat, 10 Jan 2026 20:53:18 +0000
Date: Sun, 11 Jan 2026 04:53:16 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 0a7468a8de7a2721cc0cce30836726f2a3ac2120
Message-ID: <202601110410.NZ2l0rX2-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 0a7468a8de7a2721cc0cce30836726f2a3ac2120  erofs: don't bother with s_stack_depth increasing for now [real fix]

elapsed time: 787m

configs tested: 236
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.2.0
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260110    clang-22
arc                   randconfig-001-20260111    clang-22
arc                   randconfig-002-20260110    clang-22
arc                   randconfig-002-20260111    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                           h3600_defconfig    gcc-15.2.0
arm                           imxrt_defconfig    gcc-15.2.0
arm                          ixp4xx_defconfig    gcc-15.2.0
arm                            mmp2_defconfig    gcc-15.2.0
arm                   randconfig-001-20260110    clang-22
arm                   randconfig-001-20260111    clang-22
arm                   randconfig-002-20260110    clang-22
arm                   randconfig-002-20260111    clang-22
arm                   randconfig-003-20260110    clang-22
arm                   randconfig-003-20260111    clang-22
arm                   randconfig-004-20260110    clang-22
arm                   randconfig-004-20260111    clang-22
arm                        shmobile_defconfig    clang-22
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    clang-22
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260110    gcc-10.5.0
arm64                 randconfig-001-20260111    gcc-12.5.0
arm64                 randconfig-002-20260110    gcc-10.5.0
arm64                 randconfig-002-20260111    gcc-12.5.0
arm64                 randconfig-003-20260110    gcc-10.5.0
arm64                 randconfig-003-20260111    gcc-12.5.0
arm64                 randconfig-004-20260110    gcc-10.5.0
arm64                 randconfig-004-20260111    gcc-12.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260110    gcc-10.5.0
csky                  randconfig-001-20260111    gcc-12.5.0
csky                  randconfig-002-20260110    gcc-10.5.0
csky                  randconfig-002-20260111    gcc-12.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260110    clang-22
hexagon               randconfig-001-20260111    clang-22
hexagon               randconfig-002-20260110    clang-22
hexagon               randconfig-002-20260111    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260110    gcc-14
i386        buildonly-randconfig-001-20260111    clang-20
i386        buildonly-randconfig-002-20260110    gcc-14
i386        buildonly-randconfig-002-20260111    clang-20
i386        buildonly-randconfig-003-20260110    gcc-12
i386        buildonly-randconfig-003-20260110    gcc-14
i386        buildonly-randconfig-003-20260111    clang-20
i386        buildonly-randconfig-004-20260110    clang-20
i386        buildonly-randconfig-004-20260110    gcc-14
i386        buildonly-randconfig-004-20260111    clang-20
i386        buildonly-randconfig-005-20260110    gcc-14
i386        buildonly-randconfig-005-20260111    clang-20
i386        buildonly-randconfig-006-20260110    gcc-14
i386        buildonly-randconfig-006-20260111    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260110    gcc-14
i386                  randconfig-002-20260110    gcc-14
i386                  randconfig-003-20260110    gcc-14
i386                  randconfig-004-20260110    gcc-14
i386                  randconfig-005-20260110    gcc-14
i386                  randconfig-006-20260110    gcc-14
i386                  randconfig-007-20260110    gcc-14
i386                  randconfig-011-20260110    gcc-14
i386                  randconfig-012-20260110    gcc-14
i386                  randconfig-013-20260110    gcc-14
i386                  randconfig-014-20260110    gcc-14
i386                  randconfig-015-20260110    gcc-14
i386                  randconfig-016-20260110    gcc-14
i386                  randconfig-017-20260110    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260110    clang-22
loongarch             randconfig-001-20260111    clang-22
loongarch             randconfig-002-20260110    clang-22
loongarch             randconfig-002-20260111    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                        m5307c3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                       bmips_be_defconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                     decstation_defconfig    clang-22
mips                          eyeq6_defconfig    clang-22
mips                           mtx1_defconfig    gcc-15.2.0
mips                         rt305x_defconfig    clang-22
mips                        vocore2_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260110    clang-22
nios2                 randconfig-001-20260111    clang-22
nios2                 randconfig-002-20260110    clang-22
nios2                 randconfig-002-20260111    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
openrisc                 simple_smp_defconfig    clang-22
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                generic-32bit_defconfig    clang-22
parisc                randconfig-001-20260110    gcc-14.3.0
parisc                randconfig-002-20260110    gcc-14.3.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                        fsp2_defconfig    gcc-15.2.0
powerpc                       holly_defconfig    clang-22
powerpc                      mgcoge_defconfig    clang-22
powerpc               mpc834x_itxgp_defconfig    clang-22
powerpc                      ppc6xx_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260110    gcc-14.3.0
powerpc               randconfig-002-20260110    gcc-14.3.0
powerpc                     tqm5200_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260110    gcc-14.3.0
powerpc64             randconfig-002-20260110    gcc-14.3.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260110    clang-22
riscv                 randconfig-001-20260110    gcc-15.2.0
riscv                 randconfig-002-20260110    clang-22
riscv                 randconfig-002-20260110    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260110    gcc-15.2.0
s390                  randconfig-001-20260110    gcc-9.5.0
s390                  randconfig-002-20260110    clang-22
s390                  randconfig-002-20260110    gcc-15.2.0
sh                               alldefconfig    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                        edosk7760_defconfig    gcc-15.2.0
sh                            hp6xx_defconfig    gcc-15.2.0
sh                          landisk_defconfig    clang-22
sh                          r7780mp_defconfig    clang-22
sh                    randconfig-001-20260110    gcc-15.2.0
sh                    randconfig-002-20260110    gcc-12.5.0
sh                    randconfig-002-20260110    gcc-15.2.0
sh                          rsk7203_defconfig    gcc-15.2.0
sh                        sh7785lcr_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260110    clang-22
sparc                 randconfig-002-20260110    clang-22
sparc64                          alldefconfig    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260110    clang-22
sparc64               randconfig-002-20260110    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260110    clang-22
um                    randconfig-002-20260110    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260110    gcc-14
x86_64      buildonly-randconfig-002-20260110    clang-20
x86_64      buildonly-randconfig-002-20260110    gcc-14
x86_64      buildonly-randconfig-003-20260110    clang-20
x86_64      buildonly-randconfig-003-20260110    gcc-14
x86_64      buildonly-randconfig-004-20260110    gcc-14
x86_64      buildonly-randconfig-005-20260110    gcc-14
x86_64      buildonly-randconfig-006-20260110    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260110    clang-20
x86_64                randconfig-002-20260110    clang-20
x86_64                randconfig-002-20260110    gcc-14
x86_64                randconfig-003-20260110    clang-20
x86_64                randconfig-004-20260110    clang-20
x86_64                randconfig-005-20260110    clang-20
x86_64                randconfig-005-20260110    gcc-14
x86_64                randconfig-006-20260110    clang-20
x86_64                randconfig-011-20260110    clang-20
x86_64                randconfig-012-20260110    clang-20
x86_64                randconfig-012-20260110    gcc-14
x86_64                randconfig-013-20260110    clang-20
x86_64                randconfig-013-20260110    gcc-14
x86_64                randconfig-014-20260110    clang-20
x86_64                randconfig-015-20260110    clang-20
x86_64                randconfig-015-20260110    gcc-14
x86_64                randconfig-016-20260110    clang-20
x86_64                randconfig-071-20260110    clang-20
x86_64                randconfig-072-20260110    clang-20
x86_64                randconfig-073-20260110    clang-20
x86_64                randconfig-074-20260110    clang-20
x86_64                randconfig-075-20260110    clang-20
x86_64                randconfig-076-20260110    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260110    clang-22
xtensa                randconfig-002-20260110    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

