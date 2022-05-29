Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB795372AB
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 23:12:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LBB7l2fxSz302c
	for <lists+linux-erofs@lfdr.de>; Mon, 30 May 2022 07:12:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O6uHv3eZ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O6uHv3eZ;
	dkim-atps=neutral
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LBB7b1QxZz2yV6
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 May 2022 07:12:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653858731; x=1685394731;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=I05kEg2ui0JLxpzDtnZyGMTCC0qy0P8YHXPFZSeQ/1A=;
  b=O6uHv3eZebm8OaQKnO4wDZgwJks782u5If58WCF2r+x0gFowHVFsRjaO
   7EZby8XhIdSgQHo6fTSKSFlQ7rUKxvzJGdR08IqD8+TsZ3O+YURakTrQd
   CAOwkFkAx6FvNNQ38SryUtWoKXkYNhnRp3GMO6Vb5SM0x8nxlQZcmjpVs
   nYqF1OYKDOoNkcOGQIGbUA8Gbfl5FRNXGACT48rim3ii7iVIEnPZuSHKl
   M5NC9smwptqqLcqwSvp4Vwee3bvIV8ghSsIKmD89w2vpNuyM+lErw7reQ
   z3S7o1cuKs3S37cgr6E5DNouUxGVVsO/hH/oIHLJdTX1sTHkxFdvx33tH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="335490423"
X-IronPort-AV: E=Sophos;i="5.91,261,1647327600"; 
   d="scan'208";a="335490423"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 14:12:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,261,1647327600"; 
   d="scan'208";a="561668794"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 29 May 2022 14:11:58 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1nvQCc-0001F6-60;
	Sun, 29 May 2022 21:11:58 +0000
Date: Mon, 30 May 2022 05:11:42 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 6e95d0a01899ed176b3450db057c3c0a9609cf47
Message-ID: <6293e18e.LtWyyUxoksAHC0k9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 6e95d0a01899ed176b3450db057c3c0a9609cf47  erofs: update documentation

elapsed time: 726m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
mips                     loongson1b_defconfig
sh                           se7206_defconfig
sh                ecovec24-romimage_defconfig
arm                            hisi_defconfig
arm                         lubbock_defconfig
xtensa                          iss_defconfig
powerpc                      pcm030_defconfig
sh                           se7619_defconfig
arc                              alldefconfig
m68k                          multi_defconfig
sh                     magicpanelr2_defconfig
arm                  randconfig-c002-20220529
x86_64                        randconfig-c001
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
alpha                            allyesconfig
nios2                            allyesconfig
sh                               allmodconfig
arc                                 defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
parisc64                            defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20220529
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func

clang tested configs:
powerpc              randconfig-c003-20220529
x86_64                        randconfig-c007
arm                  randconfig-c002-20220529
mips                 randconfig-c004-20220529
s390                 randconfig-c005-20220529
riscv                randconfig-c006-20220529
i386                          randconfig-c001
powerpc                     tqm8560_defconfig
arm                       netwinder_defconfig
arm                           omap1_defconfig
arm                          pxa168_defconfig
mips                        omega2p_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         s5pv210_defconfig
arm                     davinci_all_defconfig
mips                  cavium_octeon_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20220529
hexagon              randconfig-r045-20220529
s390                 randconfig-r044-20220529
riscv                randconfig-r042-20220529

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
