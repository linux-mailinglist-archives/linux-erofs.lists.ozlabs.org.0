Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1179DBACD
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Nov 2024 16:44:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XzgbB6PSRz2yst
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Nov 2024 02:44:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732808645;
	cv=none; b=InrtFN6eluZeNAJ8lnT24RvqWDZy+Oau0rxel9U68mYUgJc4IiqMxWD1KIGgR1bG2wQy24q0TGzRsex/um3CFNq+vWmooN5j8iiZYElkSkTeYZ24yRYg5igutBzVG1Nid7YqTGhXw87YsK6Nmj1827m4P8LI4koCxFKik4VVTUFloZq2DmQmL0FeeiZDcR/xyUaefxYyZhuitf3QP/rfJ1s13yw/TZf204tiHMcQACZXbPux2lS7ikyj7TGZD1GJ94oNsieZrONaJCUjMrX7UkeK3qrwJTXmKPhHGHej5DtL0tTh//vW2/Cx4qMv7NQmnR+/fUz3NLUNAuDjzbV/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732808645; c=relaxed/relaxed;
	bh=YwjuAt9lVadk32AEF2KJ1u2evP2qRPweVzxL8NK/dVc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DWPAqlP02nj5yBFZ1Tu4GdJEQbNvXkUIfvQc7rAiMLDI6xR/DnCTZSvJc/3QP6+dPTTR2fz9AHl/5AMLlM3JMGxMgPZIMGDspjrwoWGHloWOXuaYIMK2488IY1SSPBgeKRVaCf+AUr6fgDVzJNSicKPi9rXnxcbZyQdL1nNLFbAbNYp2byDq2nfXsugfTgHew2otVfNMaZ69QOAZdNnTRSRZCyXqBRQmQ/J+qC7YujWUs1myt7BlcmWQQbKHNWvN5oBwfc5LyFuoUD3uKxPmYslA4pFkStHuOPD4utskuuxMecS2bzZI+zWxAjIyqgeEHxHkmgJFyiyiu2g1R4ABZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JkLrDg86; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JkLrDg86;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xzgb62vwwz2xxx
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 Nov 2024 02:43:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732808642; x=1764344642;
  h=date:from:to:cc:subject:message-id;
  bh=+qfKzmpgF/L1eedYt6T5D4pbsTKMcqgGSwcXgXeFeCs=;
  b=JkLrDg8600rJYfX8sGBA/925hiz4D84FSf1jiM/FFLgTNm7F71SwPU+S
   uBASS9BVcCbQHkBGMw9CivSPooBRU0PwrVWGAXRgMjgNvFqSCQmC36Ddw
   LbuezCmFW6bw5lyhMgGktw42WwWdz81a5EnbLu6rRtifrKVi5DGzZxsh5
   7M4MUOOMXy/Hcf6n254UrBQQ2XHqt4IukbZwWkYvZ8JzELA7nEMR6+Kcn
   6+sa+3wtQsOHDvCXTmk3OlUtsXA2HGn89MhF4Bym8L/9Z6kc0zZs6zUoY
   kWKDAXEa3Cvm5lwEB64qay8JbWtFE0a8hqJ6C/blPE+PWf8C2+nH81jfK
   Q==;
X-CSE-ConnectionGUID: QvhdLgZ6SDeaAPj5ODKy5Q==
X-CSE-MsgGUID: 7xf9R2AbQY6NBnhNYDn7HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="32413045"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="32413045"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 07:43:55 -0800
X-CSE-ConnectionGUID: FU5uOrl2TnSUfcmR3tC3Jg==
X-CSE-MsgGUID: I6V1fQ1JQKKVJEtEGer6RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="92363190"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 28 Nov 2024 07:43:53 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGggJ-0009jX-0A;
	Thu, 28 Nov 2024 15:43:51 +0000
Date: Thu, 28 Nov 2024 23:41:32 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 21c8a16b73491166a498634e285484d7112003f8
Message-ID: <202411282322.Sy9ujYcI-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
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
branch HEAD: 21c8a16b73491166a498634e285484d7112003f8  erofs: fix PSI memstall accounting

elapsed time: 725m

configs tested: 158
configs skipped: 24

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                   randconfig-001-20241128    clang-20
arc                   randconfig-002-20241128    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                         assabet_defconfig    gcc-14.2.0
arm                           h3600_defconfig    gcc-14.2.0
arm                         lpc32xx_defconfig    gcc-14.2.0
arm                        neponset_defconfig    gcc-14.2.0
arm                   randconfig-001-20241128    clang-20
arm                   randconfig-002-20241128    clang-20
arm                   randconfig-003-20241128    clang-20
arm                   randconfig-004-20241128    clang-20
arm                           sama5_defconfig    gcc-14.2.0
arm                           spitz_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241128    clang-20
arm64                 randconfig-002-20241128    clang-20
arm64                 randconfig-003-20241128    clang-20
arm64                 randconfig-004-20241128    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241128    clang-20
csky                  randconfig-002-20241128    clang-20
hexagon                          alldefconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241128    clang-20
hexagon               randconfig-002-20241128    clang-20
i386        buildonly-randconfig-001-20241128    clang-19
i386        buildonly-randconfig-002-20241128    clang-19
i386        buildonly-randconfig-003-20241128    clang-19
i386        buildonly-randconfig-004-20241128    clang-19
i386        buildonly-randconfig-005-20241128    clang-19
i386        buildonly-randconfig-006-20241128    clang-19
i386                  randconfig-001-20241128    clang-19
i386                  randconfig-002-20241128    clang-19
i386                  randconfig-003-20241128    clang-19
i386                  randconfig-004-20241128    clang-19
i386                  randconfig-005-20241128    clang-19
i386                  randconfig-006-20241128    clang-19
i386                  randconfig-011-20241128    clang-19
i386                  randconfig-012-20241128    clang-19
i386                  randconfig-013-20241128    clang-19
i386                  randconfig-014-20241128    clang-19
i386                  randconfig-015-20241128    clang-19
i386                  randconfig-016-20241128    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20241128    clang-20
loongarch             randconfig-002-20241128    clang-20
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         db1xxx_defconfig    gcc-14.2.0
mips                           ip22_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241128    clang-20
nios2                 randconfig-002-20241128    clang-20
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20241128    clang-20
parisc                randconfig-002-20241128    clang-20
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241128    clang-20
powerpc               randconfig-002-20241128    clang-20
powerpc               randconfig-003-20241128    clang-20
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241128    clang-20
powerpc64             randconfig-002-20241128    clang-20
powerpc64             randconfig-003-20241128    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                 randconfig-001-20241128    clang-20
riscv                 randconfig-002-20241128    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    gcc-14.2.0
s390                  randconfig-001-20241128    clang-20
s390                  randconfig-002-20241128    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20241128    clang-20
sh                    randconfig-002-20241128    clang-20
sh                             sh03_defconfig    gcc-14.2.0
sh                     sh7710voipgw_defconfig    gcc-14.2.0
sh                            shmin_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64               randconfig-001-20241128    clang-20
sparc64               randconfig-002-20241128    clang-20
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                             i386_defconfig    gcc-14.2.0
um                    randconfig-001-20241128    clang-20
um                    randconfig-002-20241128    clang-20
x86_64      buildonly-randconfig-001-20241128    clang-19
x86_64      buildonly-randconfig-002-20241128    clang-19
x86_64      buildonly-randconfig-003-20241128    clang-19
x86_64      buildonly-randconfig-004-20241128    clang-19
x86_64      buildonly-randconfig-005-20241128    clang-19
x86_64      buildonly-randconfig-006-20241128    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241128    clang-19
x86_64                randconfig-002-20241128    clang-19
x86_64                randconfig-003-20241128    clang-19
x86_64                randconfig-004-20241128    clang-19
x86_64                randconfig-005-20241128    clang-19
x86_64                randconfig-006-20241128    clang-19
x86_64                randconfig-011-20241128    clang-19
x86_64                randconfig-012-20241128    clang-19
x86_64                randconfig-013-20241128    clang-19
x86_64                randconfig-014-20241128    clang-19
x86_64                randconfig-015-20241128    clang-19
x86_64                randconfig-016-20241128    clang-19
x86_64                randconfig-071-20241128    clang-19
x86_64                randconfig-072-20241128    clang-19
x86_64                randconfig-073-20241128    clang-19
x86_64                randconfig-074-20241128    clang-19
x86_64                randconfig-075-20241128    clang-19
x86_64                randconfig-076-20241128    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                          rhel-9.4-func    clang-19
x86_64                    rhel-9.4-kselftests    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                randconfig-001-20241128    clang-20
xtensa                randconfig-002-20241128    clang-20
xtensa                    smp_lx200_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
