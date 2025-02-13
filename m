Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C2EA33A2F
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Feb 2025 09:40:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YtpXY4rrPz30WF
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Feb 2025 19:40:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739436012;
	cv=none; b=hgjo/3WIlTIo1tKVyL4sYGmCDTIboGJrTcFYzL5HFZGjhqk2NAqzYjpP2a2s2bNMBiSPSJh8Zf58rfCR/A6TkM3xCCLyPg8Gx+tfy+X+JLxWeOZ9NLbglkimSzjOE1STIdLW4z/Qc+G9zsFBoljA/snGNTDD/+rrm92UesWn3656+lZqpQxOc52/yBOt3C0rTD27o3PVNDuwDrnyWIV3Oh15kyKwxLBZ2WlaMcV42AUdFO2Xf9BXfvebRGbILNhy1XX6ovl8qifmcHZEoBTC45Qo1QHFYjYclB8eXfSpQUnAgA5vkm+JSsEraiYZhEuJOZkHDLTxuQiwN/YCvqkqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739436012; c=relaxed/relaxed;
	bh=5Su9UMfLi4QBRUkN5PlcHcIqYANyg40KXId7w+yDRRk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EP0X3f29ljQCYGsxHb8U0RHu6YAEsb1pvTyvp4qSptx8A4AcVPY5AINFoDb3WnScT1iCfjx75hpfLmEwB3y/CPNYm5+F3WW3QaCtK8ubQAyPdI8X9TLDI8WQAp+kh+hcZnUfz5cPp8/S6C/Mtst0d7YS6iuPm+LPa9auFbvpnoC1RSbu8rTbrtRlSrOmya7ehGyl9FCiNfd6UOCa3qK6c7Gty8ZF0wP4QdRyqYQvZwHbvwB10nGKz7aPfofHcCWo+V38flj7XIkskmlzFMaUELW2sXZuR4knk3i4A1KiP9lNmCerqJpaF50179vPMWuGguJAEHW4PSd1CgYjSOwLUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ho2QVsYi; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ho2QVsYi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YtpXT2VJqz2yvq
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Feb 2025 19:40:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739436009; x=1770972009;
  h=date:from:to:cc:subject:message-id;
  bh=qy7H0X/qx+YwFE46Gx3oQE7Dk23TjnPdhtId/PKVG5Y=;
  b=ho2QVsYiwPfngPA4P7prW27k2ePz8Qh1r2Qj0Ts8EsgayTCAOsa3JvZ0
   UEZAfBcJF6L/jnnqJBB6pdgatZQld3cD7VMwN3PFQ/CNLM0AtyMrAOlNQ
   ui0lfxgscR5Ow6QlgZPw6Um1aqKjnc0tok8mkTEaK4p9Ep3CLl9RrwDlT
   LaHlj4tFB3t5GtV+tDR4UO6j790sml+zxwPXWb5enCeE2OQytOlqhr4WI
   WoIiwOq7MZAqDo4XCoAfL/5K0OeTcm78kATSRl5AZOet7wU2NfW4SO0Aw
   m8GLgUAf5WkC2q/YIxu/HGAlfbKXp0o7cu3Pb3QE/ixI8UoD0z3yfzweJ
   A==;
X-CSE-ConnectionGUID: NVmW1O7uTwuoVyRHwbxcfQ==
X-CSE-MsgGUID: dPZriAcaRre9cCf5RMd1Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="44056913"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="44056913"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 00:40:04 -0800
X-CSE-ConnectionGUID: pBKciAzmQLSH5iGw6xHulw==
X-CSE-MsgGUID: 7wGoL8oIRWOfZ/8A80y1hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117689703"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 Feb 2025 00:40:02 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiUlM-0016pD-1G;
	Thu, 13 Feb 2025 08:40:00 +0000
Date: Thu, 13 Feb 2025 16:39:34 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 1b0f0fc616e235d2b0c72220cc5aff13c780d0c9
Message-ID: <202502131628.SO5g03tu-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
branch HEAD: 1b0f0fc616e235d2b0c72220cc5aff13c780d0c9  erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify switches

elapsed time: 1172m

configs tested: 226
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250212    gcc-13.2.0
arc                   randconfig-001-20250213    gcc-14.2.0
arc                   randconfig-002-20250212    gcc-13.2.0
arc                   randconfig-002-20250213    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                   randconfig-001-20250212    clang-18
arm                   randconfig-001-20250213    gcc-14.2.0
arm                   randconfig-002-20250212    clang-16
arm                   randconfig-002-20250213    gcc-14.2.0
arm                   randconfig-003-20250212    clang-21
arm                   randconfig-003-20250213    gcc-14.2.0
arm                   randconfig-004-20250212    clang-16
arm                   randconfig-004-20250213    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250212    gcc-14.2.0
arm64                 randconfig-001-20250213    gcc-14.2.0
arm64                 randconfig-002-20250212    gcc-14.2.0
arm64                 randconfig-002-20250213    gcc-14.2.0
arm64                 randconfig-003-20250212    clang-16
arm64                 randconfig-003-20250213    gcc-14.2.0
arm64                 randconfig-004-20250212    gcc-14.2.0
arm64                 randconfig-004-20250213    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250212    gcc-14.2.0
csky                  randconfig-001-20250213    clang-21
csky                  randconfig-002-20250212    gcc-14.2.0
csky                  randconfig-002-20250213    clang-21
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250212    clang-21
hexagon               randconfig-001-20250213    clang-21
hexagon               randconfig-002-20250212    clang-21
hexagon               randconfig-002-20250213    clang-21
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250212    clang-19
i386        buildonly-randconfig-001-20250213    clang-19
i386        buildonly-randconfig-002-20250212    gcc-12
i386        buildonly-randconfig-002-20250213    clang-19
i386        buildonly-randconfig-003-20250212    gcc-12
i386        buildonly-randconfig-003-20250213    clang-19
i386        buildonly-randconfig-004-20250212    gcc-12
i386        buildonly-randconfig-004-20250213    clang-19
i386        buildonly-randconfig-005-20250212    gcc-12
i386        buildonly-randconfig-005-20250213    clang-19
i386        buildonly-randconfig-006-20250212    gcc-12
i386        buildonly-randconfig-006-20250213    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20250213    clang-19
i386                  randconfig-002-20250213    clang-19
i386                  randconfig-003-20250213    clang-19
i386                  randconfig-004-20250213    clang-19
i386                  randconfig-005-20250213    clang-19
i386                  randconfig-006-20250213    clang-19
i386                  randconfig-007-20250213    clang-19
i386                  randconfig-011-20250213    gcc-12
i386                  randconfig-012-20250213    gcc-12
i386                  randconfig-013-20250213    gcc-12
i386                  randconfig-014-20250213    gcc-12
i386                  randconfig-015-20250213    gcc-12
i386                  randconfig-016-20250213    gcc-12
i386                  randconfig-017-20250213    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250212    gcc-14.2.0
loongarch             randconfig-001-20250213    clang-21
loongarch             randconfig-002-20250212    gcc-14.2.0
loongarch             randconfig-002-20250213    clang-21
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250212    gcc-14.2.0
nios2                 randconfig-001-20250213    clang-21
nios2                 randconfig-002-20250212    gcc-14.2.0
nios2                 randconfig-002-20250213    clang-21
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250212    gcc-14.2.0
parisc                randconfig-001-20250213    clang-21
parisc                randconfig-002-20250212    gcc-14.2.0
parisc                randconfig-002-20250213    clang-21
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc               randconfig-001-20250212    gcc-14.2.0
powerpc               randconfig-001-20250213    clang-21
powerpc               randconfig-002-20250212    clang-16
powerpc               randconfig-002-20250213    clang-21
powerpc               randconfig-003-20250212    gcc-14.2.0
powerpc               randconfig-003-20250213    clang-21
powerpc64             randconfig-001-20250212    clang-16
powerpc64             randconfig-001-20250213    clang-21
powerpc64             randconfig-002-20250212    gcc-14.2.0
powerpc64             randconfig-002-20250213    clang-21
powerpc64             randconfig-003-20250212    gcc-14.2.0
powerpc64             randconfig-003-20250213    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250212    clang-21
riscv                 randconfig-001-20250213    clang-21
riscv                 randconfig-002-20250212    clang-18
riscv                 randconfig-002-20250213    clang-21
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250212    clang-15
s390                  randconfig-001-20250213    clang-21
s390                  randconfig-002-20250212    clang-17
s390                  randconfig-002-20250213    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250212    gcc-14.2.0
sh                    randconfig-001-20250213    clang-21
sh                    randconfig-002-20250212    gcc-14.2.0
sh                    randconfig-002-20250213    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250212    gcc-14.2.0
sparc                 randconfig-001-20250213    clang-21
sparc                 randconfig-002-20250212    gcc-14.2.0
sparc                 randconfig-002-20250213    clang-21
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250212    gcc-14.2.0
sparc64               randconfig-001-20250213    clang-21
sparc64               randconfig-002-20250212    gcc-14.2.0
sparc64               randconfig-002-20250213    clang-21
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250212    clang-16
um                    randconfig-001-20250213    clang-21
um                    randconfig-002-20250212    gcc-12
um                    randconfig-002-20250213    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250212    gcc-11
x86_64      buildonly-randconfig-001-20250213    gcc-12
x86_64      buildonly-randconfig-002-20250212    clang-19
x86_64      buildonly-randconfig-002-20250213    gcc-12
x86_64      buildonly-randconfig-003-20250212    clang-19
x86_64      buildonly-randconfig-003-20250213    gcc-12
x86_64      buildonly-randconfig-004-20250212    clang-19
x86_64      buildonly-randconfig-004-20250213    gcc-12
x86_64      buildonly-randconfig-005-20250212    gcc-12
x86_64      buildonly-randconfig-005-20250213    gcc-12
x86_64      buildonly-randconfig-006-20250212    clang-19
x86_64      buildonly-randconfig-006-20250213    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250213    clang-19
x86_64                randconfig-002-20250213    clang-19
x86_64                randconfig-003-20250213    clang-19
x86_64                randconfig-004-20250213    clang-19
x86_64                randconfig-005-20250213    clang-19
x86_64                randconfig-006-20250213    clang-19
x86_64                randconfig-007-20250213    clang-19
x86_64                randconfig-008-20250213    clang-19
x86_64                randconfig-071-20250213    gcc-12
x86_64                randconfig-072-20250213    gcc-12
x86_64                randconfig-073-20250213    gcc-12
x86_64                randconfig-074-20250213    gcc-12
x86_64                randconfig-075-20250213    gcc-12
x86_64                randconfig-076-20250213    gcc-12
x86_64                randconfig-077-20250213    gcc-12
x86_64                randconfig-078-20250213    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250212    gcc-14.2.0
xtensa                randconfig-001-20250213    clang-21
xtensa                randconfig-002-20250212    gcc-14.2.0
xtensa                randconfig-002-20250213    clang-21

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
