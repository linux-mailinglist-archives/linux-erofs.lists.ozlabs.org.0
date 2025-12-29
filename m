Return-Path: <linux-erofs+bounces-1641-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ACDCE773E
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Dec 2025 17:27:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dg1p917fxz2xgv;
	Tue, 30 Dec 2025 03:27:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767025633;
	cv=none; b=jV0OaA65r8sZYq54ZB1vKzhyWIp2VFfF6T084x5aDXcdcm7dFHIVvlVFL9/L117EOwp0voye0yP+r00BiXaBdqpBMYVxbX44/HYj8JLGnPEq8Gyw0xT4uzVaO0RAeqqyR/wkLYzfyt6NH2IfsvlJzTnnHadyWWAgRdopWxleFuqxPCHHyINQ3M515ddtCXNwy61cbunH80tVRfWuqIJ87I3c1Yq7XWEwZEcP+UOjHJmHg32MEasLo29zEszLGSN8+lHIkOJHJMCqollYRKTn9/253HLNylkPOU1djjftKve7y1sy6aYyQG8pCD8Y8fUtQ6vafVSFzjUiuh6OZHsJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767025633; c=relaxed/relaxed;
	bh=bUpLkcC8TIEdKrX1mC4NaUk6vba3EXR3jYT8n5+ePUk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SkSF3PBO7jFnLkeAnyGJpz0zUODG1bDAW5v3eB51wNttmVasrK7mJzxOBUgBOwI3YvHqx+lsdDFa7XnKJaBZVkPynp5FXm8eDrNuAOT89HeDFC/lVF1VwFsxvIL4HcTH8wMGi4MnDpcKvIcM8WmGXbNXRJxdxpCIpGtOt34kF90gOp21/YT2pbedr1hLhaTCLbul0mKIpPfGWovnPT8qTpV7vbQ6/t5Ja7LD45grDDm0q1r+QTQYU0jHLQNtEVovcDnehn8z65jVSLx9xptcZyQAlBfVRXkakvkaqLkxu4CWI23rl0k/VFoyQlK/TEjtI8XnFYu9q4+Z4JrUD0URZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eCX5nULF; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eCX5nULF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dg1p63q1Kz2x9M
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 03:27:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767025630; x=1798561630;
  h=date:from:to:cc:subject:message-id;
  bh=uvUrNxYwuUxNHnvy2zfzIFMTL4nBkIykiXMXao4yu08=;
  b=eCX5nULFqyuRrjMZ3LhIMDxyEdC5sRMTnk/JaB1mq3DS2uOg6wm4fqtq
   /s+cvJhraOt3YCe9JX5Cn61jN4NxtvTbzmfqBOuC76AUW3i83EoTVwL0Y
   ktmTyz4rjk1GfWCTjeqzA/sYAwMHjXxtrYA0Od4yGzBJyl0vg51eauAvk
   lgwDpwFysQ+w0e9b+nykWsl9lZmNyUS9XC6goqa7ffeV0waWyQOkaLAKc
   xZepErUurnBdInIPNha1r/W5ekQGpIn5XGIvNCgk++PaRuXQHJ9w1okqY
   FitHheYc4jXjpoCzNH7ThuC8nlDt6RusWoqiX3+kK/C3Xjs6pXEpYDbTJ
   w==;
X-CSE-ConnectionGUID: JTuLJ7G5Q46gXIRcyH4jBg==
X-CSE-MsgGUID: ns7kXcg4Sua5pH8vKXD0kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="79361409"
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="79361409"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 08:27:03 -0800
X-CSE-ConnectionGUID: 6cDL6wyfR42clFjSRpq1nA==
X-CSE-MsgGUID: +uaG4AH8SsKxQKS4l5V8tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,186,1763452800"; 
   d="scan'208";a="201408370"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 29 Dec 2025 08:27:02 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vaG5E-000000007Sj-0sxG;
	Mon, 29 Dec 2025 16:27:00 +0000
Date: Tue, 30 Dec 2025 00:26:26 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 6ff312442c59d2c3cc08a74b70a4373b552fd0c1
Message-ID: <202512300020.09CjFbky-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 6ff312442c59d2c3cc08a74b70a4373b552fd0c1  erofs: avoid noisy messages for transient -ENOMEM

elapsed time: 724m

configs tested: 176
configs skipped: 2

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
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20251229    gcc-13.4.0
arc                   randconfig-002-20251229    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                            dove_defconfig    gcc-15.1.0
arm                   randconfig-001-20251229    gcc-15.1.0
arm                   randconfig-002-20251229    gcc-12.5.0
arm                   randconfig-003-20251229    clang-22
arm                   randconfig-004-20251229    gcc-15.1.0
arm                    vt8500_v6_v7_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251229    clang-22
arm64                 randconfig-002-20251229    clang-22
arm64                 randconfig-003-20251229    gcc-10.5.0
arm64                 randconfig-004-20251229    gcc-9.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251229    gcc-15.1.0
csky                  randconfig-002-20251229    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251229    clang-22
hexagon               randconfig-002-20251229    clang-22
i386                             alldefconfig    gcc-14
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251229    clang-20
i386        buildonly-randconfig-002-20251229    gcc-14
i386        buildonly-randconfig-003-20251229    gcc-13
i386        buildonly-randconfig-004-20251229    clang-20
i386        buildonly-randconfig-005-20251229    gcc-14
i386        buildonly-randconfig-006-20251229    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251229    gcc-14
i386                  randconfig-002-20251229    clang-20
i386                  randconfig-003-20251229    clang-20
i386                  randconfig-004-20251229    clang-20
i386                  randconfig-005-20251229    clang-20
i386                  randconfig-006-20251229    clang-20
i386                  randconfig-007-20251229    clang-20
i386                  randconfig-011-20251229    gcc-14
i386                  randconfig-012-20251229    gcc-14
i386                  randconfig-013-20251229    gcc-14
i386                  randconfig-014-20251229    gcc-14
i386                  randconfig-015-20251229    gcc-14
i386                  randconfig-016-20251229    gcc-14
i386                  randconfig-017-20251229    gcc-14
loongarch                        alldefconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251229    clang-18
loongarch             randconfig-002-20251229    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                            q40_defconfig    gcc-15.1.0
m68k                        stmark2_defconfig    gcc-15.1.0
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                       bmips_be_defconfig    gcc-15.1.0
mips                     cu1830-neo_defconfig    gcc-15.1.0
mips                           jazz_defconfig    clang-17
mips                        vocore2_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251229    gcc-11.5.0
nios2                 randconfig-002-20251229    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-64bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20251229    gcc-13.4.0
parisc                randconfig-002-20251229    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251229    gcc-12.5.0
powerpc               randconfig-002-20251229    clang-18
powerpc64             randconfig-001-20251229    clang-20
powerpc64             randconfig-002-20251229    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251229    gcc-15.1.0
riscv                 randconfig-002-20251229    clang-20
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251229    clang-22
s390                  randconfig-002-20251229    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        dreamcast_defconfig    gcc-15.1.0
sh                    randconfig-001-20251229    gcc-10.5.0
sh                    randconfig-002-20251229    gcc-15.1.0
sh                           se7750_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251229    gcc-13.4.0
sparc                 randconfig-002-20251229    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251229    clang-20
sparc64               randconfig-002-20251229    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251229    gcc-14
um                    randconfig-002-20251229    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251229    clang-20
x86_64      buildonly-randconfig-002-20251229    clang-20
x86_64      buildonly-randconfig-003-20251229    gcc-14
x86_64      buildonly-randconfig-004-20251229    clang-20
x86_64      buildonly-randconfig-005-20251229    gcc-14
x86_64      buildonly-randconfig-006-20251229    gcc-13
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251229    gcc-14
x86_64                randconfig-002-20251229    clang-20
x86_64                randconfig-003-20251229    gcc-14
x86_64                randconfig-004-20251229    clang-20
x86_64                randconfig-005-20251229    gcc-14
x86_64                randconfig-006-20251229    gcc-14
x86_64                randconfig-011-20251229    clang-20
x86_64                randconfig-012-20251229    gcc-14
x86_64                randconfig-013-20251229    clang-20
x86_64                randconfig-014-20251229    clang-20
x86_64                randconfig-015-20251229    clang-20
x86_64                randconfig-016-20251229    gcc-14
x86_64                randconfig-071-20251229    clang-20
x86_64                randconfig-072-20251229    gcc-14
x86_64                randconfig-073-20251229    gcc-13
x86_64                randconfig-074-20251229    clang-20
x86_64                randconfig-075-20251229    clang-20
x86_64                randconfig-076-20251229    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251229    gcc-8.5.0
xtensa                randconfig-002-20251229    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

