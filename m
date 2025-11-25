Return-Path: <linux-erofs+bounces-1433-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B242C83CA0
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Nov 2025 08:50:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dFvxW1ydVz2yvv;
	Tue, 25 Nov 2025 18:50:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764057023;
	cv=none; b=Pqr/UbHkpnYRaedEn3aMXSbumxd11y47ovRmHp6VgZQzrF60odgmIj344x1XQhGXRzHWW4FJW5wmrCISDVNhM5dbs0q0aSJI14nZV1CiMhjfxl8lbo3cKsSe1Xd7Ui9aL+9Z5VKjuEKDWkR3xxlErLG99TAwnglhs37ntk1x1X3uLMHN91tReri28QOP8/0dlU2acBHTQGTsQ2Xwd6rpvioZ9cmvUq5uO1JzeV3XFWWw/rK0rFAprfSAmIdtIffuo5GtmoQ423Ryi2/1zvv4jeKC3s3VugBrRkr3tjeEGaT/mmeJi8F7DckQL3lftToWwYPSTFpFUflIlM6DRNW7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764057023; c=relaxed/relaxed;
	bh=vLeIwlV44VL2DNkQtRhiYq+Fql+pNlApo3Xp9zL+3/w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OVdbO4ariKMMukMQgpb94WA4FwhLHDonvQ9PUTKpzuMDvJ89wfR85CP8SiiIfI9kkcXG/qhABpPXjtPt7KYPHU9YIq+YxYKLcvVr++Up6GURs5DJkg+gTCqwVHestkbjf/DVl3V/Tuv2XQZ0lgTJ3gG/hejwdZaTQoL1W93lsmPUedyuj2xgQYIvI53VpF7CC4mHstJy5MA71pA3AEwjev0lBwG9RegmjPQdXqs4PGYeHae5ln4x8NB3t3FkOv3uvkcBqBIFN9ph1dTTODKpXd8blmoklkDx6I8dd9FLgqJcozDS9jdLXpdnaHAWrGtbbZyzBX/V9YmRXCqh4TTSJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H+wqrBWO; dkim-atps=neutral; spf=pass (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H+wqrBWO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dFvxS0zFVz2yrT
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Nov 2025 18:50:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764057020; x=1795593020;
  h=date:from:to:cc:subject:message-id;
  bh=rJJzg5QbTHUgE0bdDD14LiEWIFpAQzFcuG2wLcVBvXQ=;
  b=H+wqrBWO7Lsy5mrwYgT74KzbeH3ZCcXC8xabzJ3mnxi0ZaD9Rq8e8u97
   Qh1Xv4sJYGAD0XU24GqL0Vrt+iSxsiqiKKZjFZUWQcRYHfczPP5aDggBn
   aHBX8ahgZaKazZAuM/vUDp2Cgoqn7nycrI690QDhSVDPZ2xKKTIbIZQPR
   zD+knz4B13fWzCfZqIttJX86ipR9tIE8POhSCZF6FbW4+iwWd6SPZTrvP
   Rw4NkXyw95N/mN1HFAwsjLEcVe53a9iSI/s9Fskk09p1Rc2z+crK7ciru
   FxuYzpBC8cncXM1TluUDUcqjDS4dOkA0pONNBFl1z6N0Mgqi69jyr12xo
   Q==;
X-CSE-ConnectionGUID: nCX6qNjQR9OXL6G6rkl3cA==
X-CSE-MsgGUID: 4q10BmAzQ5GsqxeZUpyykg==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="77542422"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="77542422"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 23:50:15 -0800
X-CSE-ConnectionGUID: r7SeotyVT5KxjiFmAV+ugw==
X-CSE-MsgGUID: 4UupAUZkS/CNdOJ5DcVqWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="192205491"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 24 Nov 2025 23:50:13 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vNnoR-000000001TZ-1J1e;
	Tue, 25 Nov 2025 07:50:11 +0000
Date: Tue, 25 Nov 2025 15:50:07 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [xiang-erofs:dev] BUILD SUCCESS
 d53cd891f0e4311889349fff3a784dc552f814b9
Message-ID: <202511251501.zzLgsYNT-lkp@intel.com>
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
branch HEAD: d53cd891f0e4311889349fff3a784dc552f814b9  erofs: limit the level of fs stacking for file-backed mounts

elapsed time: 1475m

configs tested: 140
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251124    gcc-10.5.0
arc                   randconfig-002-20251124    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                                 defconfig    clang-22
arm                            hisi_defconfig    gcc-15.1.0
arm                           omap1_defconfig    gcc-15.1.0
arm                   randconfig-001-20251124    clang-19
arm                   randconfig-002-20251124    gcc-12.5.0
arm                   randconfig-003-20251124    gcc-11.5.0
arm                   randconfig-004-20251124    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251124    clang-22
arm64                 randconfig-002-20251124    clang-19
arm64                 randconfig-003-20251124    gcc-9.5.0
arm64                 randconfig-004-20251124    gcc-11.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251124    gcc-10.5.0
csky                  randconfig-002-20251124    gcc-12.5.0
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251124    clang-17
hexagon               randconfig-002-20251124    clang-18
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251124    gcc-14
i386        buildonly-randconfig-002-20251124    gcc-14
i386        buildonly-randconfig-003-20251124    gcc-14
i386        buildonly-randconfig-004-20251124    clang-20
i386        buildonly-randconfig-005-20251124    clang-20
i386        buildonly-randconfig-006-20251124    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251124    clang-20
i386                  randconfig-002-20251124    gcc-14
i386                  randconfig-003-20251124    gcc-14
i386                  randconfig-004-20251124    gcc-14
i386                  randconfig-005-20251124    gcc-13
i386                  randconfig-006-20251124    clang-20
i386                  randconfig-007-20251124    gcc-14
i386                  randconfig-011-20251125    clang-20
i386                  randconfig-012-20251125    gcc-14
i386                  randconfig-013-20251125    gcc-13
i386                  randconfig-014-20251125    clang-20
i386                  randconfig-015-20251125    gcc-14
i386                  randconfig-016-20251125    clang-20
i386                  randconfig-017-20251125    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251124    clang-22
loongarch             randconfig-002-20251124    gcc-14.3.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251124    gcc-11.5.0
nios2                 randconfig-002-20251124    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251124    gcc-14.3.0
parisc                randconfig-002-20251124    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc                   lite5200b_defconfig    clang-22
powerpc                      ppc64e_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251124    gcc-12.5.0
powerpc               randconfig-002-20251124    clang-16
powerpc                    sam440ep_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251124    gcc-8.5.0
powerpc64             randconfig-002-20251124    gcc-14.3.0
riscv                            alldefconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                    nommu_virt_defconfig    clang-22
riscv                 randconfig-001-20251124    clang-17
riscv                 randconfig-002-20251124    clang-22
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251124    gcc-8.5.0
s390                  randconfig-002-20251124    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                     magicpanelr2_defconfig    gcc-15.1.0
sh                    randconfig-001-20251124    gcc-15.1.0
sh                    randconfig-002-20251124    gcc-12.5.0
sh                           se7750_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251124    gcc-8.5.0
sparc                 randconfig-002-20251124    gcc-13.4.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251124    gcc-15.1.0
sparc64               randconfig-002-20251124    gcc-8.5.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251124    gcc-14
um                    randconfig-002-20251124    clang-20
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251125    gcc-12
x86_64      buildonly-randconfig-002-20251125    gcc-14
x86_64      buildonly-randconfig-003-20251125    gcc-14
x86_64      buildonly-randconfig-004-20251125    clang-20
x86_64      buildonly-randconfig-005-20251125    gcc-14
x86_64      buildonly-randconfig-006-20251125    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251125    clang-20
x86_64                randconfig-002-20251125    clang-20
x86_64                randconfig-003-20251125    clang-20
x86_64                randconfig-004-20251125    clang-20
x86_64                randconfig-005-20251125    clang-20
x86_64                randconfig-006-20251125    clang-20
x86_64                randconfig-011-20251125    gcc-12
x86_64                randconfig-012-20251125    clang-20
x86_64                randconfig-013-20251125    gcc-14
x86_64                randconfig-014-20251125    gcc-14
x86_64                randconfig-015-20251125    clang-20
x86_64                randconfig-016-20251125    gcc-14
x86_64                randconfig-071-20251125    clang-20
x86_64                randconfig-072-20251125    clang-20
x86_64                randconfig-073-20251125    clang-20
x86_64                randconfig-074-20251125    clang-20
x86_64                randconfig-075-20251125    gcc-14
x86_64                randconfig-076-20251125    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251124    gcc-10.5.0
xtensa                randconfig-002-20251124    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

