Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C2996706B
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2024 11:01:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WwpsH1nBgz2yPM
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2024 19:01:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725094861;
	cv=none; b=iNguttJmCiGko75nX6I5MaA2DwQgg3UAaCP3OgwfSPWSdFUUMhGxvUD9CZT2px7Qk7lBtP1KOrurTstWmYfjTXMzoYvvm4yEZ+H2Pk+5OsxCIYES81+19smXM/uHR8iUwEJ5RzUmtzGEmYVmwGs9IGn6t/+8JduMjCKNiRUTeQZlhq5DEp2FJlziKc63Pwfg6k4mZbzJEusmnP4k22CuR19ow7oxtvXZJpzxsy4GVHNK9MY2E3FPfV5OTD7PI9nW/haI9m2XeD/rRL9+vQ4zbl4tGiV9Hl5ORpoU3FHp8es9sUmC9jtwmXBtk0U58mGH6zwFrp6DwH41duz3/P5i6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725094861; c=relaxed/relaxed;
	bh=q8P38ZqttW5JIH6SVtK/s9KdyV8Mqn0fLcpasOnitUM=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:User-Agent; b=NtTdCWxULDA/Wwe8sxU2qsbALYlltCLkxSon1+TYy8HN4u2zg0B9TQdetk1dYyd1SvNTwGPdLWJIawaRH/wpoemPQepRcNb7hSh5Gr+a7q1KpnymH6m1jjcjs9Sue6WVlpYA+2wEzwfkI8pIzdpLu3fCP46PmbGdb2fK4P/zfo0Q9flu07EohNC0MB7bUwceHKrsQ3fnCzrUAkTCQ/4BKzMWdQUs6jPkVMnaStR3fIj3f8VYoGlPj10WhSevqmMC6psuhlN2d1u7TgHp8MVxn5m/PPa//UsYyhOfeYdAQwLAS+PehbWnPkVOMOWlF2RteiOCHrG0p/BbYlIma26gWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S2aPe88D; dkim-atps=neutral; spf=pass (client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S2aPe88D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wwps81LwZz2y0B
	for <linux-erofs@lists.ozlabs.org>; Sat, 31 Aug 2024 19:00:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725094860; x=1756630860;
  h=date:from:to:cc:subject:message-id;
  bh=9TBHsLcUTPQR37oLP25qm1d9cFgjl9I4A+W4IU3PZFA=;
  b=S2aPe88D1l5hwzkNNPrrCZpGLOPijWYr6KfgMwQuyaoXwvaLMKohoF5u
   xF4V5k/9iqTJNaR48xZqfLi/ZQaHvS0+LvtI1xID3BK+lFENkNBt0tGp0
   lrNRQNzll0n9ggjUNDPscqbCUE6D6KzpRP10sRzEz2xsDOLFFZimbavCN
   7b+/1/iWpR7c3ledBB3FAG1rlMVyq+etN8qG5EknKMicWKHZB/DjoNkiV
   sLQZZPKMFsquw5jpKV0H/8O9pIlPG7a3CXD6OlZkuL11myMPKS3MfTb6x
   ZHNY2J0V3OeOKBmBWBQXtqgahBMEV9XCEd7C5wgRPP3WnW4CJ8SklK847
   g==;
X-CSE-ConnectionGUID: BVbdwmY7Ro+tNDoJpZV8Kg==
X-CSE-MsgGUID: zPjS0AlTRJa/TOWj1DYCUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23906579"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="23906579"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 02:00:54 -0700
X-CSE-ConnectionGUID: G+JDQV4ZSvCyJ0fWsI/0mg==
X-CSE-MsgGUID: omIuHMCTSuiZ0iR6NfPWEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="68790898"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 31 Aug 2024 02:00:52 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skJyU-0002Uk-2C;
	Sat, 31 Aug 2024 09:00:50 +0000
Date: Sat, 31 Aug 2024 17:00:40 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 50b89a2ee010614c01c4a7e0474364a66bba0a74
Message-ID: <202408311737.zLtePtWJ-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 50b89a2ee010614c01c4a7e0474364a66bba0a74  erofs: mark experimental fscache backend deprecated

elapsed time: 1547m

configs tested: 178
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arc                        nsimosci_defconfig   clang-20
arc                   randconfig-001-20240831   gcc-14.1.0
arc                   randconfig-002-20240831   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                          ep93xx_defconfig   clang-20
arm                          gemini_defconfig   clang-20
arm                      jornada720_defconfig   clang-20
arm                         nhk8815_defconfig   clang-20
arm                   randconfig-001-20240831   gcc-14.1.0
arm                   randconfig-002-20240831   gcc-14.1.0
arm                   randconfig-003-20240831   gcc-14.1.0
arm                   randconfig-004-20240831   gcc-14.1.0
arm                        realview_defconfig   clang-20
arm                         vf610m4_defconfig   clang-20
arm                    vt8500_v6_v7_defconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   clang-20
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240831   gcc-14.1.0
arm64                 randconfig-002-20240831   gcc-14.1.0
arm64                 randconfig-003-20240831   gcc-14.1.0
arm64                 randconfig-004-20240831   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240831   gcc-14.1.0
csky                  randconfig-002-20240831   gcc-14.1.0
hexagon                          alldefconfig   clang-20
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240831   gcc-14.1.0
hexagon               randconfig-002-20240831   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240831   clang-18
i386         buildonly-randconfig-002-20240831   clang-18
i386         buildonly-randconfig-003-20240831   clang-18
i386         buildonly-randconfig-004-20240831   clang-18
i386         buildonly-randconfig-005-20240831   clang-18
i386         buildonly-randconfig-006-20240831   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240831   clang-18
i386                  randconfig-002-20240831   clang-18
i386                  randconfig-003-20240831   clang-18
i386                  randconfig-004-20240831   clang-18
i386                  randconfig-005-20240831   clang-18
i386                  randconfig-006-20240831   clang-18
i386                  randconfig-011-20240831   clang-18
i386                  randconfig-012-20240831   clang-18
i386                  randconfig-013-20240831   clang-18
i386                  randconfig-014-20240831   clang-18
i386                  randconfig-015-20240831   clang-18
i386                  randconfig-016-20240831   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240831   gcc-14.1.0
loongarch             randconfig-002-20240831   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   clang-20
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                            gpr_defconfig   clang-20
mips                          malta_defconfig   clang-20
mips                      malta_kvm_defconfig   clang-20
mips                        omega2p_defconfig   clang-20
mips                         rt305x_defconfig   clang-20
nios2                            alldefconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240831   gcc-14.1.0
nios2                 randconfig-002-20240831   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                            defconfig   gcc-12
openrisc                  or1klitex_defconfig   clang-20
parisc                            allnoconfig   clang-20
parisc                              defconfig   gcc-12
parisc                generic-64bit_defconfig   clang-20
parisc                randconfig-001-20240831   gcc-14.1.0
parisc                randconfig-002-20240831   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                    adder875_defconfig   clang-20
powerpc                           allnoconfig   clang-20
powerpc                 canyonlands_defconfig   clang-20
powerpc                       ebony_defconfig   clang-20
powerpc                    gamecube_defconfig   clang-20
powerpc                       maple_defconfig   clang-20
powerpc                 mpc834x_itx_defconfig   clang-20
powerpc                    mvme5100_defconfig   clang-20
powerpc               randconfig-001-20240831   gcc-14.1.0
powerpc                  storcenter_defconfig   clang-20
powerpc                     tqm8540_defconfig   clang-20
powerpc64             randconfig-001-20240831   gcc-14.1.0
powerpc64             randconfig-002-20240831   gcc-14.1.0
powerpc64             randconfig-003-20240831   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                               defconfig   gcc-12
riscv                    nommu_k210_defconfig   clang-20
riscv                 randconfig-001-20240831   gcc-14.1.0
riscv                 randconfig-002-20240831   gcc-14.1.0
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240831   gcc-14.1.0
s390                  randconfig-002-20240831   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                    randconfig-001-20240831   gcc-14.1.0
sh                    randconfig-002-20240831   gcc-14.1.0
sh                           se7780_defconfig   clang-20
sh                   secureedge5410_defconfig   clang-20
sh                        sh7763rdp_defconfig   clang-20
sh                        sh7785lcr_defconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240831   gcc-14.1.0
sparc64               randconfig-002-20240831   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240831   gcc-14.1.0
um                    randconfig-002-20240831   gcc-14.1.0
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240831   clang-18
x86_64       buildonly-randconfig-002-20240831   clang-18
x86_64       buildonly-randconfig-003-20240831   clang-18
x86_64       buildonly-randconfig-004-20240831   clang-18
x86_64       buildonly-randconfig-005-20240831   clang-18
x86_64       buildonly-randconfig-006-20240831   clang-18
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240831   clang-18
x86_64                randconfig-002-20240831   clang-18
x86_64                randconfig-003-20240831   clang-18
x86_64                randconfig-004-20240831   clang-18
x86_64                randconfig-005-20240831   clang-18
x86_64                randconfig-006-20240831   clang-18
x86_64                randconfig-011-20240831   clang-18
x86_64                randconfig-012-20240831   clang-18
x86_64                randconfig-013-20240831   clang-18
x86_64                randconfig-014-20240831   clang-18
x86_64                randconfig-015-20240831   clang-18
x86_64                randconfig-016-20240831   clang-18
x86_64                randconfig-071-20240831   clang-18
x86_64                randconfig-072-20240831   clang-18
x86_64                randconfig-073-20240831   clang-18
x86_64                randconfig-074-20240831   clang-18
x86_64                randconfig-075-20240831   clang-18
x86_64                randconfig-076-20240831   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240831   gcc-14.1.0
xtensa                randconfig-002-20240831   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
