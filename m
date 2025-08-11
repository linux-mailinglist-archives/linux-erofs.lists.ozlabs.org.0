Return-Path: <linux-erofs+bounces-813-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D17B208AC
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Aug 2025 14:22:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c0v0Y2j5kz3d9L;
	Mon, 11 Aug 2025 22:22:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754914957;
	cv=none; b=UZaL1BwnnqgLDE1OeHKRrsJOnIV71WkAe8n0L2cGa671lcROip3yNVns0fS9ugKmsPA6CLCmxhVkOMXa6XNtWlDoMDXzXcaSx9cdHW6NDLnV569UrxxcZLt3M64GF7nqvBDPFzxHpi71UKfh9ubijra20aMcfUSj1vBaFMkgeSnif2uGLcaaE2rGYk0dKx3lgxi2BSLNtoeEiL4R5Wcn3KBDOnGtXsbwZKz1+o7LWuUVc64ojydVjRpubUW7rHdtRj79rt+8r+OP+ZN9KjhoBvW0G/9nmnMWSCBV00S8hbN7csELU1IcKtpSCVySepsMyeUIDYXg2qakJAXNS5cMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754914957; c=relaxed/relaxed;
	bh=oyj7/cogcKJ7CMwGc0uLTziY7IgTDGyZC13ZDAsE/N8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LTYqVtwuoX9udsH3r/EUcs9lefqlidR/bwftXYCwUHR/KHVg8Pd5Wv4KCuARhNy2lU9bNFNTAY9W9chpHi8EVUrWuINQt1xZExLXexKkPXVVQXmbBIHG4n0C8A4zAY+ylIoqmqEWPScefEKb8EB7xRq6ScaowK999EfmXiNkMWIKv7He7p/shwV6cFEG1Kr32TI+9li8jh84D/jYL4rvmX2xjz5GwbSU+KnzMPS3hiwkD0yVxvGoORqm58ngCYIhQY9FCpFLHCqbrGsf0SE50PB0GgOdPyV2v5KzQRyZti1lTUS5CRPOHy8+UtSsSgQJYHgksW+EPo0UQJtGwweXgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f3VYrwH+; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f3VYrwH+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c0v0W0kSWz3d9B
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Aug 2025 22:22:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754914955; x=1786450955;
  h=date:from:to:cc:subject:message-id;
  bh=AtIXKQijzJBYkXnOn9oLFHjesCsY8AOZw3FyuJ/MKSI=;
  b=f3VYrwH+h8QpVZ40t3XaP0x4J8bJnoNYLfFxFYBdGeaW3FMk4ykLLXXs
   /GcMCQXY0/0U/uSkRnpnmKQCmtfnA2reGv75ly3NbRtDotUUdm/axvMhn
   XodAigLywk6TMlYbnMfQSqD1v90LAGW9lKPbpvlhAliTkpWFkKu3qQLbm
   fTrlsjbh9ZjhBMFjphzORxsvaaf4cU657TIuGntlX5f0XMGQMgi8PUnWi
   O7sfzGfz29CwA6qbpqQ79SBDfT6BACRaB5tX2MAwJ/a94UpapgmAPxeTq
   v41BilUTueBVC/9ErJpMhfpQV6wnIC0os0K5UTSzdsW8Q81qo2rjL5fZ9
   w==;
X-CSE-ConnectionGUID: jE5RyI0QT7CCtJFDVrHv3A==
X-CSE-MsgGUID: RpFlbdILReSy0wMRkrN0fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="82604634"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="82604634"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 05:22:30 -0700
X-CSE-ConnectionGUID: yom5EUuXQwGqkd6mF8mTyA==
X-CSE-MsgGUID: Yl18sNShSemE8yMQNv0bSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="171253230"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 11 Aug 2025 05:22:28 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulRXm-0005qR-06;
	Mon, 11 Aug 2025 12:22:26 +0000
Date: Mon, 11 Aug 2025 20:21:47 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 0b96d9bed324a1c1b7d02bfb9596351ef178428d
Message-ID: <202508112041.MdzxtWmy-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
branch HEAD: 0b96d9bed324a1c1b7d02bfb9596351ef178428d  erofs: fix block count report when 48-bit layout is on

elapsed time: 781m

configs tested: 139
configs skipped: 6

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
arc                   randconfig-001-20250811    gcc-8.5.0
arc                   randconfig-002-20250811    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                     am200epdkit_defconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                            hisi_defconfig    gcc-15.1.0
arm                   randconfig-001-20250811    gcc-10.5.0
arm                   randconfig-002-20250811    gcc-13.4.0
arm                   randconfig-003-20250811    clang-22
arm                   randconfig-004-20250811    gcc-10.5.0
arm                           sunxi_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250811    clang-22
arm64                 randconfig-002-20250811    clang-19
arm64                 randconfig-003-20250811    clang-20
arm64                 randconfig-004-20250811    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250811    gcc-15.1.0
csky                  randconfig-002-20250811    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250811    clang-17
hexagon               randconfig-002-20250811    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250811    clang-20
i386        buildonly-randconfig-002-20250811    clang-20
i386        buildonly-randconfig-003-20250811    gcc-12
i386        buildonly-randconfig-004-20250811    gcc-12
i386        buildonly-randconfig-005-20250811    gcc-12
i386        buildonly-randconfig-006-20250811    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                 loongson3_defconfig    clang-22
loongarch             randconfig-001-20250811    gcc-15.1.0
loongarch             randconfig-002-20250811    gcc-12.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath79_defconfig    gcc-15.1.0
mips                         db1xxx_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250811    gcc-10.5.0
nios2                 randconfig-002-20250811    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250811    gcc-9.5.0
parisc                randconfig-002-20250811    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                 linkstation_defconfig    clang-20
powerpc                     mpc83xx_defconfig    clang-22
powerpc                  mpc866_ads_defconfig    clang-22
powerpc               randconfig-001-20250811    gcc-13.4.0
powerpc               randconfig-002-20250811    clang-22
powerpc               randconfig-003-20250811    gcc-13.4.0
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc                      tqm8xx_defconfig    clang-19
powerpc                 xes_mpc85xx_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250811    clang-22
powerpc64             randconfig-002-20250811    clang-22
powerpc64             randconfig-003-20250811    gcc-14.3.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250811    gcc-8.5.0
riscv                 randconfig-002-20250811    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250811    gcc-8.5.0
s390                  randconfig-002-20250811    clang-17
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        edosk7760_defconfig    gcc-15.1.0
sh                    randconfig-001-20250811    gcc-15.1.0
sh                    randconfig-002-20250811    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250811    gcc-8.5.0
sparc                 randconfig-002-20250811    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250811    clang-22
sparc64               randconfig-002-20250811    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250811    clang-18
um                    randconfig-002-20250811    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250811    gcc-12
x86_64      buildonly-randconfig-002-20250811    clang-20
x86_64      buildonly-randconfig-003-20250811    clang-20
x86_64      buildonly-randconfig-004-20250811    clang-20
x86_64      buildonly-randconfig-005-20250811    clang-20
x86_64      buildonly-randconfig-006-20250811    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250811    gcc-9.5.0
xtensa                randconfig-002-20250811    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

