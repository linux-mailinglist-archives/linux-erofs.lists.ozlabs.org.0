Return-Path: <linux-erofs+bounces-1674-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D69CED345
	for <lists+linux-erofs@lfdr.de>; Thu, 01 Jan 2026 18:01:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dhtQm2YZfz2yFW;
	Fri, 02 Jan 2026 04:01:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767286912;
	cv=none; b=dxilB39/SyIea/6OAyaG08wzuOzucqRNS6PIBvrLiTsYTGERM2i/OU8p2w5K+IlqUcYTj0CB688ZL6fUvXUMMaBvqqnuOygPpONwdJ2G6SJ2fW0xjIGtEeGcVRjPgd/zRRNdQMd7gwKh4UV36dccQ643589fYN3vKP61dbY5PHTE13rukQJiXcij1dBDoRRfzfOcO6kGN4OE6pqjGXvoe77iZoUnYz9ydabbZT5gwUebpouY81fE+H0q8Z7JRaM9uZ79JTbqBdWx/F7onOhCgpjTJic6lSGnWo7dfpYkYICXxtCvkBEbEL9uckhgzZUOOG2TbHbspki8dQ1z3kOXew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767286912; c=relaxed/relaxed;
	bh=m6nYJEm07JbZKUSsJvmPsmqwqC2CnV6Itd9dtgmZ1dc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IZjlZiIDTEddxVLPeDTAKlmDLXv5Cct14/Svfxy813FFehG3Zd3bdyWr7sqlYJfS1kvy8NAI8UJaA7jTMq6Zv6eQjiMUwxF7+g4u3WJSGxA+Vz0aAFtYO6oKGmAV6s+5ZjArckaFrLnUP0YEbfYylcJoV3AETbxVMMW8RdU4hM5GYofHeLjiBraij5dPfPSJ/DkUvkJPqThpq+ouGmpfyUta6def7mrKN6k5fl5B+D2ozHcARRf0cN67xjEdo61FNMiVsDMXpISzD/CEfmMjA+qs8HkqcW8uDweAh+6ygBMDfJc6P1nom/NxO2PZwyYGgOeQx6X2u555SvbjBEjnFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ULv5Q+Ok; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ULv5Q+Ok;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dhtQj4jMdz2xqr
	for <linux-erofs@lists.ozlabs.org>; Fri, 02 Jan 2026 04:01:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767286910; x=1798822910;
  h=date:from:to:cc:subject:message-id;
  bh=JxT3iWXORhx8d4i4BTF8K7+583iAuIKUzx+EDzawces=;
  b=ULv5Q+OkOmq5jB1eqYy8V4AvapyxOdq69WK7uLUZzI2/OpH13DOYnVdH
   f8L2HdS04Y3U9XXlOoX0stVh03ecl3TdvOb5WY4X9E0EQJ0jFhF+hSfVP
   zqc2LtdVJ4AqjczMzMtg43xp6YrzHfNGTwrZ86rJF/gc0g8pwLVn2jUEW
   IVb6CV9mBKbqae9xdooQ5BHgsGoCO/c4BQ/kc6dVjWzs0mve92tLR0pMo
   1O/HuCqb+OroggBwD6skl9Pp+qs0GY26HgarEJOqr4VzYbY4Jhi7WUa3+
   IQgTEnUYwCUKHh6PHHfhV/HWexZPBnBYeKPyAWPd5gJ8ZhIydIfBaTV+T
   w==;
X-CSE-ConnectionGUID: W1DSZ5gqTeeafOdCe6VoxQ==
X-CSE-MsgGUID: qSdyCnUhQ5m894TkWQAmXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68755318"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68755318"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2026 09:01:45 -0800
X-CSE-ConnectionGUID: IQWE1uRETIC+T1/2VCX0wQ==
X-CSE-MsgGUID: fRo4xYycQfykTu5FIPxA4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,194,1763452800"; 
   d="scan'208";a="206161046"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 01 Jan 2026 09:01:43 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vbM3Q-000000001xI-3Ww9;
	Thu, 01 Jan 2026 17:01:40 +0000
Date: Fri, 02 Jan 2026 01:01:14 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 cba8a6e918d761538eadb402b30972f87c8863c0
Message-ID: <202601020106.lsp7EEui-lkp@intel.com>
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
branch HEAD: cba8a6e918d761538eadb402b30972f87c8863c0  erofs: don't bother with s_stack_depth increasing for now

elapsed time: 1182m

configs tested: 175
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20260101    gcc-8.5.0
arc                   randconfig-002-20260101    gcc-12.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                      integrator_defconfig    clang-22
arm                        mvebu_v5_defconfig    gcc-15.1.0
arm                   randconfig-001-20260101    gcc-15.1.0
arm                   randconfig-002-20260101    gcc-15.1.0
arm                   randconfig-003-20260101    gcc-10.5.0
arm                   randconfig-004-20260101    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20260101    clang-20
arm64                 randconfig-002-20260101    clang-22
arm64                 randconfig-003-20260101    gcc-8.5.0
arm64                 randconfig-004-20260101    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20260101    gcc-14.3.0
csky                  randconfig-002-20260101    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260101    clang-22
hexagon               randconfig-002-20260101    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260101    gcc-14
i386        buildonly-randconfig-002-20260101    gcc-14
i386        buildonly-randconfig-003-20260101    gcc-14
i386        buildonly-randconfig-004-20260101    gcc-14
i386        buildonly-randconfig-005-20260101    clang-20
i386        buildonly-randconfig-006-20260101    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260101    gcc-12
i386                  randconfig-002-20260101    clang-20
i386                  randconfig-003-20260101    clang-20
i386                  randconfig-004-20260101    clang-20
i386                  randconfig-005-20260101    gcc-14
i386                  randconfig-006-20260101    gcc-14
i386                  randconfig-007-20260101    gcc-14
i386                  randconfig-011-20260101    clang-20
i386                  randconfig-012-20260101    clang-20
i386                  randconfig-013-20260101    gcc-14
i386                  randconfig-014-20260101    clang-20
i386                  randconfig-015-20260101    clang-20
i386                  randconfig-016-20260101    gcc-14
i386                  randconfig-017-20260101    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260101    clang-22
loongarch             randconfig-002-20260101    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                           virt_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                          ath25_defconfig    clang-22
mips                       rbtx49xx_defconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-11.5.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260101    gcc-11.5.0
openrisc                         alldefconfig    gcc-15.1.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20260101    gcc-9.5.0
parisc                randconfig-002-20260101    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          g5_defconfig    gcc-15.1.0
powerpc                   lite5200b_defconfig    clang-22
powerpc                     mpc83xx_defconfig    clang-22
powerpc               randconfig-001-20260101    gcc-14.3.0
powerpc               randconfig-002-20260101    clang-16
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20260101    gcc-8.5.0
powerpc64             randconfig-002-20260101    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260101    clang-18
riscv                 randconfig-002-20260101    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260101    clang-22
s390                  randconfig-002-20260101    gcc-8.5.0
s390                       zfcpdump_defconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        dreamcast_defconfig    gcc-15.1.0
sh                    randconfig-001-20260101    gcc-15.1.0
sh                    randconfig-002-20260101    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20260101    gcc-11.5.0
sparc                 randconfig-002-20260101    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260101    clang-22
sparc64               randconfig-002-20260101    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260101    clang-18
um                    randconfig-002-20260101    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260101    clang-20
x86_64      buildonly-randconfig-002-20260101    clang-20
x86_64      buildonly-randconfig-003-20260101    gcc-14
x86_64      buildonly-randconfig-004-20260101    clang-20
x86_64      buildonly-randconfig-005-20260101    gcc-12
x86_64      buildonly-randconfig-006-20260101    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260101    clang-20
x86_64                randconfig-002-20260101    clang-20
x86_64                randconfig-003-20260101    clang-20
x86_64                randconfig-004-20260101    clang-20
x86_64                randconfig-005-20260101    gcc-14
x86_64                randconfig-006-20260101    gcc-14
x86_64                randconfig-011-20260101    clang-20
x86_64                randconfig-012-20260101    gcc-14
x86_64                randconfig-013-20260101    gcc-14
x86_64                randconfig-014-20260101    gcc-14
x86_64                randconfig-015-20260101    gcc-14
x86_64                randconfig-016-20260101    clang-20
x86_64                randconfig-071-20260101    gcc-14
x86_64                randconfig-072-20260101    gcc-14
x86_64                randconfig-073-20260101    clang-20
x86_64                randconfig-074-20260101    clang-20
x86_64                randconfig-075-20260101    gcc-14
x86_64                randconfig-076-20260101    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                       common_defconfig    gcc-15.1.0
xtensa                          iss_defconfig    gcc-15.1.0
xtensa                randconfig-001-20260101    gcc-12.5.0
xtensa                randconfig-002-20260101    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

