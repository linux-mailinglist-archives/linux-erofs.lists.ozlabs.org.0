Return-Path: <linux-erofs+bounces-1535-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1D4CD6B3C
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Dec 2025 17:46:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZkYs4kh2z2xSZ;
	Tue, 23 Dec 2025 03:46:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766422001;
	cv=none; b=k3ya4HGNEfEQyIvyjN3tY5AE2dD83GCntwkW70+LonK7Psf6R5xCyzIh3r92cDQvj5wNzXmB/awv1EgHEQqQNb9vhAo0EDJpDh/C4TZ2qjK159WcXCjHHj0Q75zkx3BV9U/VmoCpdBcsbvskS5+0jUqi8Nd2/T6zM+sQr0T5alT2OI8vSePuO0z8EvVEZFPLC/B1ewOvv5j8H281AkDxVFxJfV0LthNpAM7p+HHhDEOiIwU7bcsVOUBtpVBflPks383AN2QrzoQe+DTFbKro8nAJPD2qhvfo6IT+eUI9EWylbDJVpn88yWACnLI7ZGqpCf4160AHtOg05OxH8GEBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766422001; c=relaxed/relaxed;
	bh=gHYyL1Or1BK0L7RP7dzZKx9cdU02idx8oYM/wMkBBbw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iBLC+75yBtKbrB2f/hf4F/unhWSJU1ETEentEGeZA6ZsRMbj5hu/CowFH+uu0MsPClNwYTFuBXW0VaIfTLNHBRv1UnafdFf4W4St4GuHckk+Qc6GpcAmstCg8cb5rRkuclydtuyRDFte5ldkCy+l9CrcBtMZdkzo5G587pGoALDpZ9OcNRRLisXOezzbgHD/mmztJVukJsU9hCyFIwbukETw+bwN5PbyoImrrwih4r0Sk5syNEee4bf05gXC1Ww6sNWDp8OZafa5FnJy4lKM8UlKXnn69Rmwl1gYLXh4TGeLRRSF1JxTPOqTZTAKQjMQ9q7/WqWGdUEw1Ji4zeFOiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h8nT74FX; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h8nT74FX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZkYp0t7xz2x99
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 03:46:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766421999; x=1797957999;
  h=date:from:to:cc:subject:message-id;
  bh=L6FqSfPYMUiIOgTrms7auPD+mHTp1/yEwB54BDClHK8=;
  b=h8nT74FXOuMQqdNKIJlsXHwW6+vYUyw9E4QUqnHdRwVSGr5WRV99SHWv
   IZjmyBYhYOcSic/LhnRHYRpYeVfQe8rxOnt070WS7HnibmlL3bF9OEPnx
   tt1fz2hHZfePehkvySBLBWSO0ZDRBuHHC1GSjb4mpigpq92evDlwf/7Ac
   KTjjBYB+AIt2xTKqviFhbRSTEw4sB5D036Ib6ZZ8XaKPNmub10Fsgp0qs
   ylTvsknrFtof/FjjRXf7TXdRMEgdV6Bgof8kpkWN366Uo/8Ei54VN4mLM
   SS7LMcmXq/G6G8x0a5nzNToRO1WS2HTqY1sgkhIR63GDNpcOb5TAuI8IM
   w==;
X-CSE-ConnectionGUID: TCbkbJo6QxOhhDipI+VXqw==
X-CSE-MsgGUID: Gca6WZstTCePGItaHicYtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68216897"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68216897"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 08:46:31 -0800
X-CSE-ConnectionGUID: LhtqgcYPSF6QJVgnpGMd3w==
X-CSE-MsgGUID: gTsujDBpTqmwyKpnV52wzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; 
   d="scan'208";a="199202738"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 22 Dec 2025 08:46:29 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXj3D-000000000sz-1Tmu;
	Mon, 22 Dec 2025 16:46:27 +0000
Date: Tue, 23 Dec 2025 00:46:20 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 4012d78562193ef5eb613bad4b0c0fa187637cfe
Message-ID: <202512230015.HXI2tKzV-lkp@intel.com>
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
branch HEAD: 4012d78562193ef5eb613bad4b0c0fa187637cfe  erofs: fix unexpected EIO under memory pressure

elapsed time: 1442m

configs tested: 173
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251222    gcc-9.5.0
arc                   randconfig-002-20251222    gcc-9.5.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.1.0
arm                         lpc32xx_defconfig    clang-17
arm                          pxa910_defconfig    gcc-15.1.0
arm                   randconfig-001-20251222    gcc-9.5.0
arm                   randconfig-002-20251222    gcc-9.5.0
arm                   randconfig-003-20251222    gcc-9.5.0
arm                   randconfig-004-20251222    gcc-9.5.0
arm                         wpcm450_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251222    gcc-10.5.0
arm64                 randconfig-002-20251222    gcc-10.5.0
arm64                 randconfig-003-20251222    gcc-10.5.0
arm64                 randconfig-004-20251222    gcc-10.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251222    gcc-10.5.0
csky                  randconfig-002-20251222    gcc-10.5.0
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251222    clang-22
hexagon               randconfig-002-20251222    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251222    gcc-12
i386        buildonly-randconfig-002-20251222    gcc-12
i386        buildonly-randconfig-003-20251222    gcc-12
i386        buildonly-randconfig-004-20251222    gcc-12
i386        buildonly-randconfig-005-20251222    gcc-12
i386        buildonly-randconfig-006-20251222    gcc-12
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251222    gcc-14
i386                  randconfig-002-20251222    gcc-14
i386                  randconfig-003-20251222    gcc-14
i386                  randconfig-004-20251222    gcc-14
i386                  randconfig-005-20251222    gcc-14
i386                  randconfig-006-20251222    gcc-14
i386                  randconfig-007-20251222    gcc-14
i386                  randconfig-011-20251222    gcc-14
i386                  randconfig-012-20251222    gcc-14
i386                  randconfig-013-20251222    gcc-14
i386                  randconfig-014-20251222    gcc-14
i386                  randconfig-015-20251222    gcc-14
i386                  randconfig-016-20251222    gcc-14
i386                  randconfig-017-20251222    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251222    clang-22
loongarch             randconfig-002-20251222    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                         amcore_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        mvme147_defconfig    gcc-15.1.0
m68k                           sun3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                           ci20_defconfig    clang-17
mips                           ip32_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251222    clang-22
nios2                 randconfig-002-20251222    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251222    gcc-10.5.0
parisc                randconfig-002-20251222    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                      bamboo_defconfig    gcc-15.1.0
powerpc                     mpc83xx_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251222    gcc-10.5.0
powerpc               randconfig-002-20251222    gcc-10.5.0
powerpc                     sequoia_defconfig    clang-17
powerpc                     tqm5200_defconfig    clang-17
powerpc64             randconfig-001-20251222    gcc-10.5.0
powerpc64             randconfig-002-20251222    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251222    gcc-8.5.0
riscv                 randconfig-002-20251222    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251222    gcc-8.5.0
s390                  randconfig-002-20251222    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251222    gcc-8.5.0
sh                    randconfig-002-20251222    gcc-8.5.0
sh                      rts7751r2d1_defconfig    clang-17
sh                   rts7751r2dplus_defconfig    gcc-15.1.0
sh                          sdk7780_defconfig    gcc-15.1.0
sh                           se7721_defconfig    gcc-15.1.0
sh                  sh7785lcr_32bit_defconfig    clang-17
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251222    clang-22
sparc                 randconfig-002-20251222    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251222    clang-22
sparc64               randconfig-002-20251222    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251222    clang-22
um                    randconfig-002-20251222    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251222    clang-20
x86_64      buildonly-randconfig-002-20251222    clang-20
x86_64      buildonly-randconfig-003-20251222    clang-20
x86_64      buildonly-randconfig-004-20251222    clang-20
x86_64      buildonly-randconfig-005-20251222    clang-20
x86_64      buildonly-randconfig-006-20251222    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-071-20251222    gcc-14
x86_64                randconfig-072-20251222    gcc-14
x86_64                randconfig-073-20251222    gcc-14
x86_64                randconfig-074-20251222    gcc-14
x86_64                randconfig-075-20251222    gcc-14
x86_64                randconfig-076-20251222    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                  audio_kc705_defconfig    clang-17
xtensa                randconfig-001-20251222    clang-22
xtensa                randconfig-002-20251222    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

