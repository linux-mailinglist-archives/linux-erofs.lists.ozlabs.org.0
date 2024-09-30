Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3941798ADD4
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Sep 2024 22:13:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XHXMX1JXlz305X
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Oct 2024 06:13:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727727221;
	cv=none; b=dD2HONv/tjKjubytWCO2BBDob54woOEtZukb3fTP+yn2SvrN//4vPjmk0SdMvyJtNpdZtFRqg5lPhSLBeBbfUDNL9u+vhjN4ye9gPtjOtMeLtjPFnlTtwzBAQr3VSxJfhiiF9wMnJP/2Q3hpgWjoynLkXexOjITuL84b9ke0vXyaHja5H5baaxXpXooQR5FtlZ6pGgYdzhseEuBzveNOQk4h+L9f018Ywa+ajDG5vV4B5n+ZF8vOW9W0in/CWJxAy9HDE0WaKA+gUDn4pxeHyBrldhbysPptycFYt07LzuQl7r3TC7bfzrRSgV/TtuUbio0k7APAliiecY+ZyrS/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727727221; c=relaxed/relaxed;
	bh=b7adWrcW92Vdnl5xAjsrNvP2buM94LleMb14F/tnpl4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bOuVHPrrQ/31u2ofF5+ZuwjHkQiSq5THLzPPXf7+kZc672ESSxpUR8p3sKweLuge4q1QTBJbQEr9/GhTt3kQPr4qNQOj+aIP+Pdi5ohAk4FA55oaf5nubFw15kXwSEgqU9CrYcNOMMlVMmMsuFyWd7YK7CcbRgCV/nZOBfRmwVYe4JqFkv+l0VS+0MtoSYlzwZifdtREKY5sps/UGpWdq9Ypd79X9FZl4d6WrKm1asTyrIur9GI7q2Tp3wWj14exn1dTRUG88iIbkZYLZ3gywC2ymliwrU3w5igXC+nTOcrCtDDas8MZu7ZMIQxIqKKmOya6+TANoZNk7J7q1p10mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lt3gMn3V; dkim-atps=neutral; spf=pass (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lt3gMn3V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XHXMR5xhKz2xfK
	for <linux-erofs@lists.ozlabs.org>; Tue,  1 Oct 2024 06:13:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727727221; x=1759263221;
  h=date:from:to:cc:subject:message-id;
  bh=h5TnD/ahMyggkeP6NpE/clg2PHMvY9JkeUPhzctslbg=;
  b=lt3gMn3VJdxX1lwcRGiDz9rZ7/Z94ERrY0HW4NzeLM0hHgdFCiRlqiiz
   bdJWO20vx+fOGL1HF9Gd0tF+/zMQiTkDjykT3zQAK2lR2WF9xdk7Q7wUt
   BOW5MjGZK81h+HNw/u8KOYuZtDKTrB2KtPYrWgc4CQQ1yIk6QnkWUVAaa
   00ozotj/3ip9c2qosEcjkUsqPdVCUdAvXpU08Hi49pxd+Bia9n7CqeddX
   wbu7lB2KK+hL+tqsCRTi128w+BTeiuyQfN1A0mZNI04dseuhCqnW8PKMy
   FvPYhppAxsjKyzwwLmCnzqTWMlyTDb4Wqz0suBQyKEClsp5XR2TccpIur
   g==;
X-CSE-ConnectionGUID: tst+r3UKRrS/rd1bwPRkTg==
X-CSE-MsgGUID: +B2U014vSAeI+BHfAioWyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26716406"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26716406"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:13:34 -0700
X-CSE-ConnectionGUID: 2+KM5r4vRaGiACDS7sRt7g==
X-CSE-MsgGUID: myKCM5CbRXeyP/tQ4SX/xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73734150"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Sep 2024 13:13:33 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svMlu-000PqJ-0W;
	Mon, 30 Sep 2024 20:13:30 +0000
Date: Tue, 01 Oct 2024 04:12:36 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 98dd36c9fa0853ab3c0e6d9aa8287a8518cffea9
Message-ID: <202410010429.dyryxR4M-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-0.3 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
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
branch HEAD: 98dd36c9fa0853ab3c0e6d9aa8287a8518cffea9  erofs: ensure regular inodes for file-backed mounts

elapsed time: 753m

configs tested: 127
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                     haps_hs_smp_defconfig    clang-20
arc                           tb10x_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                          ep93xx_defconfig    clang-20
arm                      integrator_defconfig    clang-20
arm                         orion5x_defconfig    clang-20
arm                        realview_defconfig    clang-20
arm                          sp7021_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240930    gcc-12
i386        buildonly-randconfig-002-20240930    clang-18
i386        buildonly-randconfig-003-20240930    clang-18
i386        buildonly-randconfig-004-20240930    gcc-12
i386        buildonly-randconfig-005-20240930    clang-18
i386        buildonly-randconfig-006-20240930    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20240930    clang-18
i386                  randconfig-002-20240930    clang-18
i386                  randconfig-003-20240930    gcc-12
i386                  randconfig-004-20240930    clang-18
i386                  randconfig-005-20240930    clang-18
i386                  randconfig-006-20240930    clang-18
i386                  randconfig-011-20240930    clang-18
i386                  randconfig-012-20240930    clang-18
i386                  randconfig-013-20240930    gcc-12
i386                  randconfig-014-20240930    gcc-12
i386                  randconfig-015-20240930    clang-18
i386                  randconfig-016-20240930    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch                 loongson3_defconfig    clang-20
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          sun3x_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           ci20_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                   bluestone_defconfig    clang-20
powerpc                      cm5200_defconfig    clang-20
powerpc                     ep8248e_defconfig    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    gcc-12
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                            hp6xx_defconfig    clang-20
sh                           se7619_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               alldefconfig    clang-20
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    clang-20
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
