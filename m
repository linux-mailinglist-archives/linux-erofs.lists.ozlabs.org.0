Return-Path: <linux-erofs+bounces-1181-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B6357BD5FAE
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Oct 2025 21:39:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4clnjp3n0Vz30P3;
	Tue, 14 Oct 2025 06:39:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760384382;
	cv=none; b=hSkGbMJjy7CYAb2OGAkKe1BQErGXDy1uP1vp+vSCH2RS0AFYUdudoz6gKkXcKR/mhM7u4EWtia+PksVxpdPwSSgNHwNFcIhxBKwVLVk3FRY652mgBK5WTy1tfhFaZHZTs9DMYjg/D1yedKl7B+fFYFsVpraT7TwCfppFoNDApGG9f4qwpO4zfR7lg8tGuN5TtZUtZFh8Cx7bh10ucZdJoBQ4m0/3tIOmO8H9GiebqDsrzoXDiZKhyZ0VzNIq1sIwIzyINouSZsSPO81QzqK4C03/7qsfpz/ApKsFfxg+MgDwlNNd7XzMD+SWH5tk+aMqDM+vRbgOEoEww0yiBxkVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760384382; c=relaxed/relaxed;
	bh=0ZV/3x+cZXoHtOQzDMNicmQL8qDjd7ndw+sTSYlGsiY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iWZ7+K54XjFB8ctROjJus3DWZ9rE7xs2onw74XMrKjim32i79MhTyo96Ypyt8hnMNdcLgoFubN2ASiliUUmu+ln9EnywgXxB0xpfoFxIvbbM3avX9r4bwd2Xik2WRon7+mR75jSoIHLI+RZuc8vSTL5gONI9MiVmbiniDew8GJ6hMyT8vkjglcn+CddFvaE9SOfSYFZWBIakC4WD3BcP2NIrqF++iL8KEmDmou3u/3zlETbLlshxYKw5NZygcpXFMSfd8GJVyu2/5dljeYutwmhx7IkWQySN6GJZ7C5NTgJ7C25LIVVUbUFbYVzfDpTFtBUB5wZN682DCzyBtWU+/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sh90fN0x; dkim-atps=neutral; spf=pass (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sh90fN0x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4clnjm1kw2z2xQ6
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Oct 2025 06:39:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760384380; x=1791920380;
  h=date:from:to:cc:subject:message-id;
  bh=DK9VlbKiXHU9jJuxM81c6qSR8g6vfo/MPzgUYD0E5DU=;
  b=Sh90fN0xC6AjLw1aWPDgvfK6DGNBP1CPxKZ+uICKMVMQQ0Lxv8iFkg9g
   9MEFgA3ikLslhy4J6swW7BkCKQtFGv6SoW7a9i0imLTVjC3NTodkfj57g
   JBZdK2/TV0hpLkEtZt6N9yCasa9dBULMNpwUUAooGE0Gqp8O7adUdILv6
   vaUmCdGUokqdocpfOXD7fIPBewiDyeDGczAIuSfd3WAwS1Crlsw5b9w0q
   Iy5Yh+VBUfTSkUSfxzDTTbXURYQgCLeg5GjdJN4q23tUIcekGWul8yyG4
   QW68+qr9eOcadQjCcrOq61vXGj6xZPDlxV4mQKb3H1tjrlBgvZ9P1kBF1
   w==;
X-CSE-ConnectionGUID: WfmG+cw8Trm7EBip6rG0Jw==
X-CSE-MsgGUID: KrcZNbtlRsy40WikE1zOpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="65154346"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="65154346"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 12:39:35 -0700
X-CSE-ConnectionGUID: j3ORBDelQM+uC2bs96QVWg==
X-CSE-MsgGUID: orD3C+5xQdqrjQ7N5lFIEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="186089767"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 13 Oct 2025 12:39:33 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8OOJ-00020N-1w;
	Mon, 13 Oct 2025 19:39:31 +0000
Date: Tue, 14 Oct 2025 03:38:33 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 959c58491d04e9611fcc58d209f05795975816d7
Message-ID: <202510140327.ARoqHOKl-lkp@intel.com>
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
branch HEAD: 959c58491d04e9611fcc58d209f05795975816d7  erofs: fix crafted invalid cases for encoded extents

elapsed time: 724m

configs tested: 127
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20251013    gcc-8.5.0
arc                   randconfig-002-20251013    gcc-13.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                          gemini_defconfig    clang-20
arm                        mvebu_v5_defconfig    gcc-15.1.0
arm                   randconfig-001-20251013    gcc-10.5.0
arm                   randconfig-002-20251013    clang-22
arm                   randconfig-003-20251013    gcc-12.5.0
arm                   randconfig-004-20251013    clang-22
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251013    clang-19
arm64                 randconfig-002-20251013    gcc-8.5.0
arm64                 randconfig-003-20251013    clang-22
arm64                 randconfig-004-20251013    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251013    gcc-15.1.0
csky                  randconfig-002-20251013    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251013    clang-22
hexagon               randconfig-002-20251013    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251013    gcc-13
i386        buildonly-randconfig-002-20251013    clang-20
i386        buildonly-randconfig-003-20251013    gcc-14
i386        buildonly-randconfig-004-20251013    clang-20
i386        buildonly-randconfig-005-20251013    gcc-14
i386        buildonly-randconfig-006-20251013    gcc-14
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251013    clang-18
loongarch             randconfig-002-20251013    gcc-13.4.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq6_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251013    gcc-8.5.0
nios2                 randconfig-002-20251013    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-64bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20251013    gcc-12.5.0
parisc                randconfig-002-20251013    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                      arches_defconfig    gcc-15.1.0
powerpc                     asp8347_defconfig    clang-22
powerpc                       ebony_defconfig    clang-22
powerpc                          g5_defconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    clang-22
powerpc                 mpc832x_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251013    clang-22
powerpc               randconfig-002-20251013    clang-18
powerpc               randconfig-003-20251013    clang-22
powerpc64             randconfig-001-20251013    gcc-10.5.0
powerpc64             randconfig-002-20251013    gcc-15.1.0
powerpc64             randconfig-003-20251013    clang-20
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20251013    clang-22
riscv                 randconfig-002-20251013    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251013    gcc-8.5.0
s390                  randconfig-002-20251013    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                            migor_defconfig    gcc-15.1.0
sh                    randconfig-001-20251013    gcc-10.5.0
sh                    randconfig-002-20251013    gcc-15.1.0
sh                            shmin_defconfig    gcc-15.1.0
sh                             shx3_defconfig    gcc-15.1.0
sh                          urquell_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251013    gcc-8.5.0
sparc                 randconfig-002-20251013    gcc-8.5.0
sparc64               randconfig-001-20251013    clang-20
sparc64               randconfig-002-20251013    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20251013    gcc-14
um                    randconfig-002-20251013    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251013    gcc-13
x86_64      buildonly-randconfig-002-20251013    clang-20
x86_64      buildonly-randconfig-003-20251013    clang-20
x86_64      buildonly-randconfig-004-20251013    gcc-14
x86_64      buildonly-randconfig-005-20251013    clang-20
x86_64      buildonly-randconfig-006-20251013    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251013    gcc-11.5.0
xtensa                randconfig-002-20251013    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

