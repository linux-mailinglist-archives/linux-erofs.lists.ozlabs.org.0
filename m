Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9E59A3E42
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Oct 2024 14:23:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XVP532gCcz3br7
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Oct 2024 23:23:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729254229;
	cv=none; b=Nwu7UeEc14xKuB5jcPrM1pjn8FCtJ5+ISx1QHmL9GmmRMTbBEErPWoRelWur7T0kKqCN33xHN9YSe3udlsliXVHOrLsMDonuRx7b8SoJmjP9P+g7ufnPBu+fGgtGlPkYV3kdNLwAAUhHz0MmJrIUQWrY+JvkbyiS62z1dYJ7HDtgbJTiNgllwh0j5SKuT6YKgkWHb8jachFy83QgmSj52sC/t7SjoF/xIkqIIm3uA4KlP/544tu09ZAh5K/mRSL1RrXt0GHwmWeF0FbcfK0AAScAx52EURgKq7EY+Z1lbbAfKb1DPwIEoskpAsq2kzbEGe3kx5Wt22hpd98fwo14BA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729254229; c=relaxed/relaxed;
	bh=0D4e1OrMfI9OANbLT44Q09CMMFwNiCR9OCi0Y1peW+o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bUzlHRwA73IBxy1cIBoPzOuVf5Qf1jxDlYXA9VpSKBIwXSgbO0RUZe8mUR72vePRGVAQ3ehmIu7554gvaQQUZ5sud807MpPMyOK4Jk22dQ/gZHNwmtjQBRhvNkxr2727i+wOFLfk/b+ZzZaRZle7jIBL+KxnCRQYvx2lxrQyFNPj1XzHGMwdjc+tOP9cUmbtU/831Jh2QxCANi1rSvCF6JujQ7qTi0tSI/yBC+VZd1VLHKkLzvkSiD65OVBrbZ0dLVDfDnp7zyUmFl2HK+YXE6gzq/3i0xklOVVnU59mwvEtk3eNU0hvgAmAS3c2f6d//ywPR7tsUlm0QV08qFjU3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jJ+/8vjt; dkim-atps=neutral; spf=pass (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jJ+/8vjt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XVP4y082zz3bn1
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Oct 2024 23:23:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729254227; x=1760790227;
  h=date:from:to:cc:subject:message-id;
  bh=j17wC6Fh9sLf7lOY21XzHA5nrj0I5HY5IQ3JXP9ty7o=;
  b=jJ+/8vjtgNoYhUggAF+RNevCWJ0j1ONllwW6jSdX/sYbxjeEHvR+nYqi
   mwihB9o2g6vQ9iUA0NYkU/JxtIUek1uwtSB0xJK+fCuskHu5bmMnohRH8
   k9/lJHURUc1c0YEsgjXGDsallwgdTD6k2+2ResVV9PoIECGauLnDp89kR
   vUhuncKIvVQylF6906bE1Nx6Z7mPEdtYBkSMbWa6jG6J7YAOIRAs7Wn/c
   L9rj38Ak/l+5QO9ZN3+CRKiaIZAKxd40cKL3IX7MUACNFfU+tZPNcM1lK
   nyRNzA8XFMrqaYBzA29MonmvbgMuZAMpJ2myYzfBYlcmuoZ1aPizD7g5Q
   Q==;
X-CSE-ConnectionGUID: RduESXqHSveikUym+JmQvg==
X-CSE-MsgGUID: Z/Rtfa+YQji3/gXR07yaGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46241444"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46241444"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:23:38 -0700
X-CSE-ConnectionGUID: yDDVLIXJR7yZadi4AN4YOA==
X-CSE-MsgGUID: TH3wyJtpTkeJSCEByDcy7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="83918488"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 18 Oct 2024 05:23:36 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1m0z-000NnW-22;
	Fri, 18 Oct 2024 12:23:33 +0000
Date: Fri, 18 Oct 2024 20:23:26 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 2c22f0bdfa448f86a7092985587e994b3c0e95a8
Message-ID: <202410182018.w0MSXpVL-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 2c22f0bdfa448f86a7092985587e994b3c0e95a8  erofs: sunset `struct erofs_workgroup`

elapsed time: 1210m

configs tested: 150
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                 nsimosci_hs_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          exynos_defconfig    gcc-14.1.0
arm                          gemini_defconfig    gcc-14.1.0
arm                          ixp4xx_defconfig    gcc-14.1.0
arm                        keystone_defconfig    gcc-14.1.0
arm                        multi_v7_defconfig    gcc-14.1.0
arm                             rpc_defconfig    gcc-14.1.0
arm                         s5pv210_defconfig    gcc-14.1.0
arm                           tegra_defconfig    gcc-14.1.0
arm                       versatile_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241018    gcc-11
i386        buildonly-randconfig-002-20241018    gcc-11
i386        buildonly-randconfig-003-20241018    gcc-11
i386        buildonly-randconfig-004-20241018    gcc-11
i386        buildonly-randconfig-005-20241018    gcc-11
i386        buildonly-randconfig-006-20241018    gcc-11
i386                                defconfig    clang-18
i386                  randconfig-001-20241018    gcc-11
i386                  randconfig-002-20241018    gcc-11
i386                  randconfig-003-20241018    gcc-11
i386                  randconfig-004-20241018    gcc-11
i386                  randconfig-005-20241018    gcc-11
i386                  randconfig-006-20241018    gcc-11
i386                  randconfig-011-20241018    gcc-11
i386                  randconfig-012-20241018    gcc-11
i386                  randconfig-013-20241018    gcc-11
i386                  randconfig-014-20241018    gcc-11
i386                  randconfig-015-20241018    gcc-11
i386                  randconfig-016-20241018    gcc-11
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        m5272c3_defconfig    gcc-14.1.0
m68k                        stmark2_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
microblaze                      mmu_defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                  cavium_octeon_defconfig    gcc-14.1.0
mips                           ip30_defconfig    gcc-14.1.0
nios2                            alldefconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                    or1ksim_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                  iss476-smp_defconfig    gcc-14.1.0
powerpc                      pcm030_defconfig    gcc-14.1.0
powerpc                     redwood_defconfig    gcc-14.1.0
powerpc                     skiroot_defconfig    gcc-14.1.0
powerpc                      tqm8xx_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-14.1.0
riscv                    nommu_virt_defconfig    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                            hp6xx_defconfig    gcc-14.1.0
sh                          sdk7786_defconfig    gcc-14.1.0
sh                           se7705_defconfig    gcc-14.1.0
sh                           se7751_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241018    clang-18
x86_64      buildonly-randconfig-002-20241018    clang-18
x86_64      buildonly-randconfig-003-20241018    clang-18
x86_64      buildonly-randconfig-004-20241018    clang-18
x86_64      buildonly-randconfig-005-20241018    clang-18
x86_64      buildonly-randconfig-006-20241018    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241018    clang-18
x86_64                randconfig-002-20241018    clang-18
x86_64                randconfig-003-20241018    clang-18
x86_64                randconfig-004-20241018    clang-18
x86_64                randconfig-005-20241018    clang-18
x86_64                randconfig-006-20241018    clang-18
x86_64                randconfig-011-20241018    clang-18
x86_64                randconfig-012-20241018    clang-18
x86_64                randconfig-013-20241018    clang-18
x86_64                randconfig-014-20241018    clang-18
x86_64                randconfig-015-20241018    clang-18
x86_64                randconfig-016-20241018    clang-18
x86_64                randconfig-071-20241018    clang-18
x86_64                randconfig-072-20241018    clang-18
x86_64                randconfig-073-20241018    clang-18
x86_64                randconfig-074-20241018    clang-18
x86_64                randconfig-075-20241018    clang-18
x86_64                randconfig-076-20241018    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                       common_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
