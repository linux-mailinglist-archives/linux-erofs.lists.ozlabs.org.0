Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798279FB421
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Dec 2024 19:45:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YH6Qd4rGxz3041
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Dec 2024 05:45:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734979511;
	cv=none; b=jAYjDvlTTIIkAStvuJlXwUFKCMVXDsWYKA3DUp2Ci3SMuZjE1z8C6/VxPuQj/gG65Z6MIKcVHI8e7LegsemIkitJBCklBqrmcMr3dxJH/+KHyiTytb3TCHGmGMKmUIWPEnQK6NIibuzQgTwvvULyyVMl7W5YI98FcpFM1GkxTHw3+OzgCpk+pH38u8v7zcBeQ/9XviWvZqD8/73yxAMgDjbKQ8qpKbLVeq6FvwtbmsemPBu9KmAOGT+D6WP6qIynXbPKLldrRJgEpUgoQKNwPQ+Ki3k0Awa/7JFOWSaH3edqdo09KvbcnPcvYxK2LaROiKWZaI3NLVElVLMpzvUZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734979511; c=relaxed/relaxed;
	bh=FH6Npp0LHnWal9d5EJDtzKxWiIOr+gYrGEYoSJ5VH88=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CFgPqFzE61+xf2PY+3cxng3frmvAR27ysVieEnvHdnGlqvGpp/XXOLb/FpuIo80m7rImaoVfQUGkQ2I/Ese3J0uiDXoATktm0uCS3N7LOPzQHYBB/H02N4mxhthCqNfBsQspfAOHwfh8q0+zZjlzpywTJaWMgJum7GCnn3/EfaJ1PHrBTNEJVCHwMWqNaERG6g3TLWRk0R9qYTKtLzmhJgdSk/KDLrOB60nXCkNoCDeUYufZEeZgw1n5cOb50hjLoRQpvH3asEILwRDeA448FKN6KHjfgqfkPVS6sOPkHE3+Rcf/B+bNJxsve2ZHtPvVqV8w73H6IC9tx7cUKw2gqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hxhvp9Zc; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hxhvp9Zc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YH6QX3bfQz2xdg
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Dec 2024 05:45:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734979509; x=1766515509;
  h=date:from:to:cc:subject:message-id;
  bh=jQM8KJLCBUrZuHfZJRoHpo7DZAqRgCeLazd7/TmUDfI=;
  b=Hxhvp9Zcv+FKeqHSp71PvwpwlKlp9GFMGJNETBxS/PUI2Z5nrbaTS243
   92LBxRF3Lb8w3MKKWt7A6diw1P4s/o/w2N+mMSda9HPJxwHMyaFidJNR0
   cOmCbIlUZkI4gJAaRfwIdjJ4bQ+XmqyxOkAmvdL5zD32tqkho0G1ybx0q
   bqRBbOtBPWo3DgfLvBTt16PA4nSUpsvnZrDFHHD3t4y6+ll3tOc2tZlW6
   fZKKfNYOaC6XBPFtUJWEiYjFkfkz2lAMoIpZqzN8YezK1qy/12oKconb+
   4Litcx0zuvBUulFwq4MqrFx9YVwvS6g+yhEAWllTftRjuK+NKymn4rhT1
   A==;
X-CSE-ConnectionGUID: PTeICuIzSTi3+66Tr5vYmw==
X-CSE-MsgGUID: +zjk4uUmQxaEYPj76+Mskw==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="46048451"
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="46048451"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 10:45:02 -0800
X-CSE-ConnectionGUID: wuEIpoC5Tne/+P60cCXhJQ==
X-CSE-MsgGUID: IiDHFIIyRE2eBBJSpl3NkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122541070"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 23 Dec 2024 10:45:01 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tPnQI-0000Yx-1m;
	Mon, 23 Dec 2024 18:44:58 +0000
Date: Tue, 24 Dec 2024 02:44:21 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 a80f578554b713af1a379346ed550e5dc61f083e
Message-ID: <202412240206.NtdHs3AR-lkp@intel.com>
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
branch HEAD: a80f578554b713af1a379346ed550e5dc61f083e  erofs: micro-optimize superblock checksum

elapsed time: 727m

configs tested: 199
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241223    gcc-13.2.0
arc                   randconfig-002-20241223    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         bcm2835_defconfig    clang-16
arm                     davinci_all_defconfig    gcc-14.2.0
arm                                 defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                        keystone_defconfig    gcc-14.2.0
arm                         lpc32xx_defconfig    clang-20
arm                            mmp2_defconfig    gcc-14.2.0
arm                        multi_v5_defconfig    gcc-14.2.0
arm                          pxa168_defconfig    clang-20
arm                             pxa_defconfig    gcc-14.2.0
arm                   randconfig-001-20241223    gcc-14.2.0
arm                   randconfig-002-20241223    clang-16
arm                   randconfig-003-20241223    clang-20
arm                   randconfig-004-20241223    gcc-14.2.0
arm                        spear3xx_defconfig    clang-16
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241223    gcc-14.2.0
arm64                 randconfig-002-20241223    clang-18
arm64                 randconfig-003-20241223    gcc-14.2.0
arm64                 randconfig-004-20241223    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241223    gcc-14.2.0
csky                  randconfig-002-20241223    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241223    clang-19
hexagon               randconfig-002-20241223    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241223    clang-19
i386        buildonly-randconfig-002-20241223    clang-19
i386        buildonly-randconfig-003-20241223    clang-19
i386        buildonly-randconfig-004-20241223    gcc-12
i386        buildonly-randconfig-005-20241223    clang-19
i386        buildonly-randconfig-006-20241223    gcc-12
i386                  randconfig-001-20241223    gcc-12
i386                  randconfig-002-20241223    gcc-12
i386                  randconfig-003-20241223    gcc-12
i386                  randconfig-004-20241223    gcc-12
i386                  randconfig-005-20241223    gcc-12
i386                  randconfig-006-20241223    gcc-12
i386                  randconfig-007-20241223    gcc-12
i386                  randconfig-011-20241223    clang-19
i386                  randconfig-012-20241223    clang-19
i386                  randconfig-013-20241223    clang-19
i386                  randconfig-014-20241223    clang-19
i386                  randconfig-015-20241223    clang-19
i386                  randconfig-016-20241223    clang-19
i386                  randconfig-017-20241223    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241223    gcc-14.2.0
loongarch             randconfig-002-20241223    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    clang-20
m68k                                defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    gcc-14.2.0
mips                           ci20_defconfig    clang-19
mips                      maltaaprp_defconfig    clang-20
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241223    gcc-14.2.0
nios2                 randconfig-002-20241223    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241223    gcc-14.2.0
parisc                randconfig-002-20241223    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                   motionpro_defconfig    clang-20
powerpc               mpc834x_itxgp_defconfig    clang-18
powerpc                      pmac32_defconfig    clang-20
powerpc               randconfig-001-20241223    clang-18
powerpc               randconfig-002-20241223    clang-16
powerpc               randconfig-003-20241223    clang-20
powerpc                  storcenter_defconfig    gcc-14.2.0
powerpc                     tqm8560_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241223    gcc-14.2.0
powerpc64             randconfig-002-20241223    clang-18
powerpc64             randconfig-003-20241223    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241223    clang-20
riscv                 randconfig-002-20241223    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241223    clang-20
s390                  randconfig-002-20241223    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20241223    gcc-14.2.0
sh                    randconfig-002-20241223    gcc-14.2.0
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                        sh7785lcr_defconfig    clang-20
sh                             shx3_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241223    gcc-14.2.0
sparc                 randconfig-002-20241223    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241223    gcc-14.2.0
sparc64               randconfig-002-20241223    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241223    clang-16
um                    randconfig-002-20241223    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241223    gcc-12
x86_64      buildonly-randconfig-002-20241223    clang-19
x86_64      buildonly-randconfig-003-20241223    clang-19
x86_64      buildonly-randconfig-004-20241223    gcc-12
x86_64      buildonly-randconfig-005-20241223    gcc-12
x86_64      buildonly-randconfig-006-20241223    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241223    clang-19
x86_64                randconfig-002-20241223    clang-19
x86_64                randconfig-003-20241223    clang-19
x86_64                randconfig-004-20241223    clang-19
x86_64                randconfig-005-20241223    clang-19
x86_64                randconfig-006-20241223    clang-19
x86_64                randconfig-007-20241223    clang-19
x86_64                randconfig-008-20241223    clang-19
x86_64                randconfig-071-20241223    gcc-12
x86_64                randconfig-072-20241223    gcc-12
x86_64                randconfig-073-20241223    gcc-12
x86_64                randconfig-074-20241223    gcc-12
x86_64                randconfig-075-20241223    gcc-12
x86_64                randconfig-076-20241223    gcc-12
x86_64                randconfig-077-20241223    gcc-12
x86_64                randconfig-078-20241223    gcc-12
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241223    gcc-14.2.0
xtensa                randconfig-002-20241223    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
