Return-Path: <linux-erofs+bounces-1602-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5C3CDD208
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 23:51:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dc6Yf5bmFz2yN1;
	Thu, 25 Dec 2025 09:51:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766616678;
	cv=none; b=Qw86vQJSJvEB16Wpx1fqBySHXbp5uRce09McNen7Nkkbtwpx8oqHEJO7KsH3lx5HmDurFS4n+LyUOkG6jR3bN5y+2BH6u5mFZ85aNH/qrPfdBN3jeg2cd+5lrXbom8mxWvn5twaee3eI0YIOkz2+KNhn3nBlcuipZhQiE/S2O0hNr4EZ9dOC2hE98VGwqcodiHWj7Dd32Lfq8DG+NNSd3aZW6a8p2VaGPfAVNL0JPyjrI2i/5hZx/5Dls1pPqCm/vDAXOMFZwse8QcnERXEm/RGfigjppiiFxpKR2TEa+Alfy1n1otbbgfCwCP2PSzu66trRACQJ9YA5Z5WOwWg1og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766616678; c=relaxed/relaxed;
	bh=vbi7klZQixyqDDqFpia2srmgZ16WuWppKaKY3BXgZcI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SdEejNnEqSM3Xwwv1rAQ8q5WYdNKyb2yi4MVEV7IitJZ6JbsKjTxlxTqlhvoPxMQmijrQ6ND0H53iapIaPasB+nZLjoi7g7nbnHLRj/vRJwq18axwGdSg6HrU/T1FBJh78DEMPjfBXVCQU9Qm4+XIXNAGIVPiPo1F1TH4FoRqN+wHuEkh8HF9y8eLql1kYg8ebJr0y3D2SCDlz5TgQ0n3zvR7TIAa+o3P5wpvxj9k3c2hFDgoG9YoQsIzMv5vz6mvj1l7wF5Q53uykCdDuVU2A6S5NOzyOazA9Io37qdTYDe1RamjGUlhVxWWPZO3PyR1Zawsbzw5olRTG50424ujQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LhYK0VF1; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LhYK0VF1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dc6Yb5rz9z2yMv
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Dec 2025 09:51:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766616676; x=1798152676;
  h=date:from:to:cc:subject:message-id;
  bh=Yf37UscjipRXj8O/4FgKUyjMvyqqUMQZBxOQ2FjWJSk=;
  b=LhYK0VF1ZqfXpc1gCL5I1dETG5wcrX3iR40UyIJVHPOy1V7qOMAD8g45
   Qi6fl4JJ1GCp/yxf6Nl8RJmF5sb3Gj4BbxYQn8OwpuvmjUkV2QVW5YB2k
   npaBXKWabhTB1Oc2COhlm0V6hWo008CLAzXAGshm6VD2kHuwLc81/F6hl
   qc/261yk66sWL037y6j0LlAEGIWg92fHqM5dfzj5U3++Ikk2baHw9/InB
   n4MntC6dc0xtGfrDzDsZ3j+1ffZTesZ3TcMrfqPQVDbAuIdEyKrkFRB7V
   BA0RmJyBgN7DmgL+gKT+bBKsZr555ACMPgaktbLVMk5OonYvaH+MhzHIG
   g==;
X-CSE-ConnectionGUID: SrNxwwLJS66aJNlrbb+AIA==
X-CSE-MsgGUID: su2pKyZASsuQj5Lhv2tmNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="79165754"
X-IronPort-AV: E=Sophos;i="6.21,174,1763452800"; 
   d="scan'208";a="79165754"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2025 14:51:11 -0800
X-CSE-ConnectionGUID: TzHttikvQCOF/Bs4AmsdDA==
X-CSE-MsgGUID: GtYD7hqVQqmHWzH8l/PfLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,174,1763452800"; 
   d="scan'208";a="205013200"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 24 Dec 2025 14:51:09 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYXhD-000000003X7-1Dvf;
	Wed, 24 Dec 2025 22:51:07 +0000
Date: Thu, 25 Dec 2025 06:50:08 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 97efa004aca1ef7b090bc97f836902598886fd7a
Message-ID: <202512250603.IuvLxMan-lkp@intel.com>
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
branch HEAD: 97efa004aca1ef7b090bc97f836902598886fd7a  erofs: improve LZ4 error strings

elapsed time: 971m

configs tested: 136
configs skipped: 1

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
arc                   randconfig-001-20251225    gcc-11.5.0
arc                   randconfig-002-20251225    gcc-11.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20251225    clang-22
arm                   randconfig-002-20251225    gcc-12.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251224    gcc-8.5.0
arm64                 randconfig-002-20251224    gcc-14.3.0
arm64                 randconfig-003-20251224    clang-17
arm64                 randconfig-004-20251224    gcc-10.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251224    gcc-15.1.0
csky                  randconfig-002-20251224    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251224    clang-22
hexagon               randconfig-002-20251224    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-011-20251224    clang-20
i386                  randconfig-012-20251224    clang-20
i386                  randconfig-013-20251224    clang-20
i386                  randconfig-014-20251224    clang-20
i386                  randconfig-015-20251224    clang-20
i386                  randconfig-016-20251224    clang-20
i386                  randconfig-017-20251224    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251224    gcc-15.1.0
loongarch             randconfig-002-20251224    gcc-12.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       m5249evb_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                          eyeq6_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20251224    gcc-11.5.0
nios2                 randconfig-002-20251224    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251224    gcc-8.5.0
parisc                randconfig-002-20251224    gcc-9.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251224    clang-22
powerpc               randconfig-002-20251224    clang-22
powerpc                     skiroot_defconfig    clang-22
powerpc                     tqm8541_defconfig    clang-22
powerpc64                        alldefconfig    clang-22
powerpc64             randconfig-001-20251224    gcc-8.5.0
powerpc64             randconfig-002-20251224    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251224    gcc-8.5.0
riscv                 randconfig-002-20251224    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251224    gcc-10.5.0
s390                  randconfig-002-20251224    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                            migor_defconfig    gcc-15.1.0
sh                    randconfig-001-20251224    gcc-14.3.0
sh                    randconfig-002-20251224    gcc-10.5.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251225    gcc-8.5.0
sparc                 randconfig-002-20251225    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251225    gcc-9.5.0
sparc64               randconfig-002-20251225    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251225    gcc-13
um                    randconfig-002-20251225    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251225    clang-20
x86_64      buildonly-randconfig-002-20251225    clang-20
x86_64      buildonly-randconfig-003-20251225    gcc-14
x86_64      buildonly-randconfig-004-20251225    clang-20
x86_64      buildonly-randconfig-005-20251225    gcc-14
x86_64      buildonly-randconfig-006-20251225    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251224    gcc-14
x86_64                randconfig-012-20251224    gcc-14
x86_64                randconfig-013-20251224    clang-20
x86_64                randconfig-014-20251224    gcc-14
x86_64                randconfig-015-20251224    gcc-14
x86_64                randconfig-016-20251224    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251225    gcc-8.5.0
xtensa                randconfig-002-20251225    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

