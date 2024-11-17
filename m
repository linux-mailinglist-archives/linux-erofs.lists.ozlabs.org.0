Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C17D9D0497
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Nov 2024 16:57:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XrwPC1jmTz3bZ4
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Nov 2024 02:57:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731859020;
	cv=none; b=Xk4eUg0ZV1lIYrXW5x4r9/UBPkCPcG0CBUfXnsWqqndMiTYRJVde996JS5x65j6O7d5hKel+j12QaLfg4nW9aD9ZKmW8qTFNMUsnfd1mSfslTxY90I4hzCZdJFSfUyil2MuwQJg4OLzWiCSh9wa5R9+k6hZB86jAU2WfzvtoT6q9t0kgO97rUqfo7P3tt2c2iObEZl8m2hrevGs2Qg/xP1p6H5MM1NKiLPXJrqRfYtawUL20jgRQbO5ig10pR0ksJhQbi9htCbqhjH5oW5ow+5lGv2OqJ89KgHBv1j0vUpUBI7Hyk00v5Ci5Fju7WuMhqxIa0XGP7i4nLQIMp23pzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731859020; c=relaxed/relaxed;
	bh=ejlLgT1CfusqbPm1NGwhKr/x3gIgsEz77CH/oArEQ+k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QQ8s9grTK41XSK/ZSlV/P88EyRvOac6mVYU+XSzzyTzUfzZ+7FIBzcpOKvpxPwYSShQVWOpvM4LnwzMVnuuUlIlFP4jOAXv+YSeyq1uWzxMZMktS1MN+wg/Zk4PTqPWSGcf2UDc/D5DbUVehnzlVkIQ5urbl5g4UkUYaOtLIIcuFI4snhDi4/wri2vqV5xL7yu8QHuMJXoeTgyYGE3pOBNahaRHnPhZUr9rqXAPPzX1C3bTVTQMM2nmml2FXu7DMrjJn8LqZV3j+hm04gWA/ouWTKC08fQ8RajA/Mi7h5Kume+vShXZgtScmfQ0CSrphbOSfGk4QnPr9GnSyvlP0lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AEDTBKKj; dkim-atps=neutral; spf=pass (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AEDTBKKj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XrwP51ZWJz2yT0
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 Nov 2024 02:56:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731859018; x=1763395018;
  h=date:from:to:cc:subject:message-id;
  bh=jDU8JdmjqveoSN2aTnJHvDkF98nZlDWS8Vx6VhYwuxs=;
  b=AEDTBKKjXCzyzjUE1Kf4fwjhUPWlPqsveziiLnlQphYsbGXuWNb5XgHY
   NeiQmelEPoLS0odneGRLl767jr2ixbzPv0qK0YoCXH50K6fNmtup+rYwH
   4hh6aZ5rZdLSYV8wOi2gz+BgKQtI3VH3mP5owjYD6Bx/MFlQNrWULpqeG
   pk5+XvdU7+M1gB3soPRNozw/n7smj2749tcyK8sj4Le1Hyc6EavNCdWT0
   9lXLODGlIj60hPQIBLnX9+98Zzfum76AiZSSdKSfH7nUGKZ06oi7n0bS1
   VPNg/bQieG4QE6mbPTD8yhLXWAxx9vYIm/QXEXMXIPW1e19qnMqf92oqS
   w==;
X-CSE-ConnectionGUID: qiM9vsyaTKu7jXQdCSDbgQ==
X-CSE-MsgGUID: zWWczW7iTn60qvBLMUTvRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="31946944"
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="31946944"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 07:56:49 -0800
X-CSE-ConnectionGUID: gLOUjZW5TmqD6++PlxeReg==
X-CSE-MsgGUID: XktuO+c8SS+k55eduSHXMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="112303995"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 17 Nov 2024 07:56:47 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tChdl-0001r7-0M;
	Sun, 17 Nov 2024 15:56:45 +0000
Date: Sun, 17 Nov 2024 23:56:06 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 2795294b4d617b6b7bdfa4b5bba7562a14381f51
Message-ID: <202411172301.9KUKwdlj-lkp@intel.com>
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
branch HEAD: 2795294b4d617b6b7bdfa4b5bba7562a14381f51  erofs: handle NONHEAD !delta[1] lclusters gracefully

elapsed time: 1455m

configs tested: 130
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241117    clang-20
arc                   randconfig-002-20241117    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                          collie_defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                          ixp4xx_defconfig    clang-20
arm                        multi_v7_defconfig    clang-20
arm                         nhk8815_defconfig    clang-20
arm                          pxa3xx_defconfig    clang-20
arm                             pxa_defconfig    clang-20
arm                   randconfig-001-20241117    clang-20
arm                   randconfig-002-20241117    clang-20
arm                   randconfig-003-20241117    clang-20
arm                   randconfig-004-20241117    clang-20
arm                         s5pv210_defconfig    clang-20
arm                           sama7_defconfig    clang-20
arm                           sunxi_defconfig    clang-20
arm                           u8500_defconfig    clang-20
arm                       versatile_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241117    clang-20
arm64                 randconfig-002-20241117    clang-20
arm64                 randconfig-003-20241117    clang-20
arm64                 randconfig-004-20241117    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241117    clang-20
csky                  randconfig-002-20241117    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241117    clang-20
hexagon               randconfig-002-20241117    clang-20
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241117    clang-19
i386        buildonly-randconfig-002-20241117    clang-19
i386        buildonly-randconfig-003-20241117    clang-19
i386        buildonly-randconfig-004-20241117    clang-19
i386        buildonly-randconfig-005-20241117    clang-19
i386        buildonly-randconfig-006-20241117    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241117    clang-19
i386                  randconfig-002-20241117    clang-19
i386                  randconfig-003-20241117    clang-19
i386                  randconfig-004-20241117    clang-19
i386                  randconfig-005-20241117    clang-19
i386                  randconfig-006-20241117    clang-19
i386                  randconfig-011-20241117    clang-19
i386                  randconfig-012-20241117    clang-19
i386                  randconfig-013-20241117    clang-19
i386                  randconfig-014-20241117    clang-19
i386                  randconfig-015-20241117    clang-19
i386                  randconfig-016-20241117    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241117    clang-20
loongarch             randconfig-002-20241117    clang-20
m68k                              allnoconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241117    clang-20
nios2                 randconfig-002-20241117    clang-20
openrisc                          allnoconfig    clang-20
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241117    clang-20
parisc                randconfig-002-20241117    clang-20
parisc64                            defconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc               randconfig-001-20241117    clang-20
powerpc               randconfig-002-20241117    clang-20
powerpc               randconfig-003-20241117    clang-20
powerpc64                        alldefconfig    clang-20
powerpc64             randconfig-001-20241117    clang-20
powerpc64             randconfig-002-20241117    clang-20
powerpc64             randconfig-003-20241117    clang-20
riscv                             allnoconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241117    clang-20
riscv                 randconfig-002-20241117    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241117    clang-20
s390                  randconfig-002-20241117    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20241117    clang-20
sh                    randconfig-002-20241117    clang-20
sh                            shmin_defconfig    clang-20
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241117    clang-20
sparc64               randconfig-002-20241117    clang-20
um                                allnoconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241117    clang-20
um                    randconfig-002-20241117    clang-20
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                          iss_defconfig    clang-20
xtensa                randconfig-001-20241117    clang-20
xtensa                randconfig-002-20241117    clang-20
xtensa                    xip_kc705_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
