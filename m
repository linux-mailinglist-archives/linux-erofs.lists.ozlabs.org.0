Return-Path: <linux-erofs+bounces-1300-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD58C1788E
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Oct 2025 01:26:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cx7N52cHrz2yyx;
	Wed, 29 Oct 2025 11:26:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761697605;
	cv=none; b=CgbAQ0uWawH9ID/n6tZ2Q/OT6vMqw6wKxherlcQwaZTD+6+Vnb8RW3CVH8hyoEhO0RYWIl/gG88z7PvEYuX6GRRFrvCUNznwakXD54JqNe+QTT5ThMG4PKVk8QFizyNkIL8Bye4MQTXRSCNwQAC/xyOZfxjUoN5si7gOTuCjNKogRMpArkQO+f6oNyjPXssJSYA7PSpCXSO9dlhMngPguRj+1X1011Ea6Ct0Kk7vGYWmCcKGlRA90GFdp8OafdF/C4tgvUluWFS4OxLK3Ev8v+T9UhrclXcUbsWa1uzOCJFVkjgDilmQbE7VLw4V7n2rB5DvQKxWZTBVAOT4OOyP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761697605; c=relaxed/relaxed;
	bh=HOzKwnKmyg1HMPlwN2QXaVBltp7oxmMeZxNcYgHQfuI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BMCK8U3tRpvFnf8VquksJtzkFAbJBRay+EyVirUffcjrdl8lOL3PbDgkeo1X2KE4hg7wTQ10f6Y+pwOf2JUsb4JHEaPV2z1cKh/WMJ7X44kgfTzCF3IQWCD5fW5dxQ70rG0XAc+hKfQjDZSnU2zO9YGVwfbv9VX7hzCxWegrTX/r7P7q/Iwv6WQZEDqy85To5VWZ82yuo49nGbDaCQ692ACbzV8G0mFK6oG8FNq4YPIImonERJHkQH5htls8n99yo9GfPTW+PdeK5USCZ0enWHrSoTpNMaE0Tbu6eWMB4mIbt/Qsafj4KtYFjhNXj9FZBO5XzuNxnl6CM7CF4Zlrag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dT6DQX05; dkim-atps=neutral; spf=pass (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dT6DQX05;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cx7N236rwz2xsq
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Oct 2025 11:26:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761697602; x=1793233602;
  h=date:from:to:cc:subject:message-id;
  bh=oZtMU+F34cA0Fmr0B8Ss6kufBarcBjfQmuKMdkJf+Dk=;
  b=dT6DQX0538rcicSukwAVc3+0abSZfu49qEsdDWaEaT+roHqDb+LxDK9a
   LCOm6XBZn8neg6v11SuG4CXagP2Usbf+HII5MkWaskVtVTKwIJGy1cgGA
   AClEVHbndUIWe3Ci/nyI9j6wmN6n1XEawjpMecrj6RFe06SPxcDjnYI4o
   cQXpGQbwf9tTJxsM1VdMcwYdNwf2frZvaktRDXX/3/KiR7iXEglZG5RT7
   E56BGwLIHqhm9SedQmXGZWDoP3B/ymXuIL1MvaNiPhPL5ND1s9ICmIfvB
   fqxGyEWOQqjGrQySECXxKFh507LVbca+ssa34YC6P+rz2fIqSREwLYfKh
   A==;
X-CSE-ConnectionGUID: oeeKmB7GT0u1AZ8iUt8qIQ==
X-CSE-MsgGUID: jb9qAhFOSVqzwSSykid0MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63846701"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="63846701"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 17:26:38 -0700
X-CSE-ConnectionGUID: 5We7Z8woT+6kAyUcuII+XQ==
X-CSE-MsgGUID: utx1sBNrQjyJg9Kcozy/Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="185964622"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 28 Oct 2025 17:26:36 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDu1K-000Jvo-1X;
	Wed, 29 Oct 2025 00:26:34 +0000
Date: Wed, 29 Oct 2025 08:26:27 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 fa9bb305791513e7763fd557ba4344e1d1c1d59c
Message-ID: <202510290821.FOcQY416-lkp@intel.com>
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
branch HEAD: fa9bb305791513e7763fd557ba4344e1d1c1d59c  MAINTAINERS: erofs: add myself as reviewer

elapsed time: 1178m

configs tested: 172
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                        nsimosci_defconfig    clang-22
arc                   randconfig-001-20251028    gcc-8.5.0
arc                   randconfig-002-20251028    gcc-13.4.0
arc                   randconfig-002-20251028    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                   randconfig-001-20251028    clang-22
arm                   randconfig-001-20251028    gcc-8.5.0
arm                   randconfig-002-20251028    clang-22
arm                   randconfig-002-20251028    gcc-8.5.0
arm                   randconfig-003-20251028    clang-22
arm                   randconfig-003-20251028    gcc-8.5.0
arm                   randconfig-004-20251028    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251028    gcc-14
i386        buildonly-randconfig-002-20251028    gcc-14
i386        buildonly-randconfig-003-20251028    gcc-14
i386        buildonly-randconfig-004-20251028    gcc-14
i386        buildonly-randconfig-005-20251028    gcc-14
i386        buildonly-randconfig-006-20251028    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-011-20251028    gcc-14
i386                  randconfig-012-20251028    clang-20
i386                  randconfig-012-20251028    gcc-14
i386                  randconfig-013-20251028    clang-20
i386                  randconfig-013-20251028    gcc-14
i386                  randconfig-014-20251028    clang-20
i386                  randconfig-014-20251028    gcc-14
i386                  randconfig-015-20251028    clang-20
i386                  randconfig-015-20251028    gcc-14
i386                  randconfig-016-20251028    gcc-14
i386                  randconfig-017-20251028    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                           sun3_defconfig    clang-22
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                 mpc8313_rdb_defconfig    clang-22
powerpc                    socrates_defconfig    clang-22
powerpc                     tqm8541_defconfig    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                          r7785rp_defconfig    clang-22
sparc                            alldefconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251028    gcc-9.5.0
sparc                 randconfig-002-20251028    gcc-9.5.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251028    gcc-9.5.0
sparc64               randconfig-002-20251028    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251028    gcc-9.5.0
um                    randconfig-002-20251028    gcc-9.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251028    clang-20
x86_64      buildonly-randconfig-002-20251028    clang-20
x86_64      buildonly-randconfig-003-20251028    clang-20
x86_64      buildonly-randconfig-004-20251028    clang-20
x86_64      buildonly-randconfig-005-20251028    clang-20
x86_64      buildonly-randconfig-006-20251028    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251028    clang-20
x86_64                randconfig-002-20251028    clang-20
x86_64                randconfig-003-20251028    clang-20
x86_64                randconfig-004-20251028    clang-20
x86_64                randconfig-005-20251028    clang-20
x86_64                randconfig-006-20251028    clang-20
x86_64                randconfig-011-20251028    clang-20
x86_64                randconfig-012-20251028    clang-20
x86_64                randconfig-013-20251028    clang-20
x86_64                randconfig-014-20251028    clang-20
x86_64                randconfig-015-20251028    clang-20
x86_64                randconfig-016-20251028    clang-20
x86_64                randconfig-071-20251028    clang-20
x86_64                randconfig-072-20251028    clang-20
x86_64                randconfig-073-20251028    clang-20
x86_64                randconfig-074-20251028    clang-20
x86_64                randconfig-075-20251028    clang-20
x86_64                randconfig-076-20251028    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251028    gcc-9.5.0
xtensa                randconfig-002-20251028    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

